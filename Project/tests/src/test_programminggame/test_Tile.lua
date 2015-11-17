--
-- Created by IntelliJ IDEA.
-- User: Adde
-- Date: 2015-11-16
-- Time: 15:44
-- To change this template use File | Settings | File Templates.
--


lunit = require "lunit"
module( "src_games_Progg_Tile", package.seeall, lunit.testcase )


-- System under test
local SUT = 'src.games.Progg.Tile'
local function create_mock(class_to_mock)
  -- unload the package if loaded to dissmiss previous mocks
  package.loaded[class_to_mock] = nil
  package.preload[class_to_mock] = nil
  -- import lemock
  local lemock = require 'lemock'
  -- initiate mock controller
  local mc = lemock.controller()
  return mc
end

local function verify_mock(mc)
  local status, err = pcall(function ()
    -- Verify that the mocks has been called as stated.
    mc:verify()
  end)
  if err then -- if error fail the test.
    fail(err)
  end
end


function setup()

end

function teardown()
  package.loaded['src.games.Progg.Tile'] = nil
  package.preload['src.games.Progg.Tile'] = nil
end

function test_new()
    local ps = require(SUT)

    local a = ps:new(0)

    assert_false(a.topBorder, "Should be false")
  assert_false(a.bottomBorder, "Should be false")
  assert_false(a.leftBorder, "Should be false")
  assert_false(a.rightBorder, "Should be false")




end


function test_tile_fail()

    fail("Not tested , always fails...")
end




