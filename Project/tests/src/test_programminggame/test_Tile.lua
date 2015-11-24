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
local SUT = 'games.Progg.Tile'
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
  package.loaded['games.Progg.Tile'] = nil
  package.preload['games.Progg.Tile'] = nil
end

function test_input_0()
    local ps = require(SUT)

    local a = ps:new("0")
    assert_false(a.topBorder, "Should be false")
  assert_false(a.bottomBorder, "Should be false")
  assert_false(a.leftBorder, "Should be false")
  assert_false(a.rightBorder, "Should be false")

end

function test_input_1()
    local ps = require(SUT)

    local a = ps:new("1")
    assert_false(a.topBorder, "Should be false")
  assert_false(a.bottomBorder, "Should be false")
  assert_true(a.leftBorder, "Should be true")
  assert_false(a.rightBorder, "Should be false")

end

function test_input_2()
    local ps = require(SUT)
    local a = ps:new("2")
    assert_false(a.topBorder, "Should be false")
  assert_true(a.bottomBorder, "Should be true")
  assert_false(a.leftBorder, "Should be false")
  assert_false(a.rightBorder, "Should be false")
end

function test_input_3()
    local ps = require(SUT)
    local a = ps:new("3")
    assert_false(a.topBorder, "Should be false")
  assert_true(a.bottomBorder, "Should be true")
  assert_true(a.leftBorder, "Should be true")
  assert_false(a.rightBorder, "Should be false")
end


function test_input_4()
    local ps = require(SUT)
    local a = ps:new("4")
    assert_false(a.topBorder, "Should be false")
  assert_false(a.bottomBorder, "Should be false")
  assert_false(a.leftBorder, "Should be false")
  assert_true(a.rightBorder, "Should be true")
end

function test_input_5()
    local ps = require(SUT)
    local a = ps:new("5")
    assert_false(a.topBorder, "Should be false")
  assert_false(a.bottomBorder, "Should be false")
  assert_true(a.leftBorder, "Should be true")
  assert_true(a.rightBorder, "Should be true")
end

function test_input_6()
    local ps = require(SUT)
    local a = ps:new("6")
    assert_false(a.topBorder, "Should be false")
  assert_true(a.bottomBorder, "Should be true")
  assert_false(a.leftBorder, "Should be false")
  assert_true(a.rightBorder, "Should be true")
end

function test_input_7()
    local ps = require(SUT)
    local a = ps:new("7")
    assert_false(a.topBorder, "Should be false")
  assert_true(a.bottomBorder, "Should be true")
  assert_true(a.leftBorder, "Should be true")
  assert_true(a.rightBorder, "Should be true")
end

function test_input_8()
    local ps = require(SUT)
    local a = ps:new("8")
    assert_true(a.topBorder, "Should be true")
  assert_false(a.bottomBorder, "Should be false")
  assert_false(a.leftBorder, "Should be false")
  assert_false(a.rightBorder, "Should be false")
end

function test_input_9()
    local ps = require(SUT)
    local a = ps:new("9")
    assert_true(a.topBorder, "Should be true")
  assert_false(a.bottomBorder, "Should be false")
  assert_true(a.leftBorder, "Should be true")
  assert_false(a.rightBorder, "Should be false")
end

function test_input_a()
    local ps = require(SUT)
    local a = ps:new("a")
    assert_true(a.topBorder, "Should be true")
  assert_true(a.bottomBorder, "Should be true")
  assert_false(a.leftBorder, "Should be false")
  assert_false(a.rightBorder, "Should be false")
end

function test_input_b()
    local ps = require(SUT)
    local a = ps:new("b")
    assert_true(a.topBorder, "Should be true")
  assert_true(a.bottomBorder, "Should be true")
  assert_true(a.leftBorder, "Should be true")
  assert_false(a.rightBorder, "Should be false")
end

function test_input_c()
    local ps = require(SUT)
    local a = ps:new("c")
    assert_true(a.topBorder, "Should be true")
  assert_false(a.bottomBorder, "Should be false")
  assert_false(a.leftBorder, "Should be false")
  assert_true(a.rightBorder, "Should be true")
end

function test_input_d()
    local ps = require(SUT)
    local a = ps:new("d")
    assert_true(a.topBorder, "Should be true")
  assert_false(a.bottomBorder, "Should be false")
  assert_true(a.leftBorder, "Should be true")
  assert_true(a.rightBorder, "Should be true")
end

function test_input_e()
    local ps = require(SUT)
    local a = ps:new("e")
    assert_true(a.topBorder, "Should be true")
  assert_true(a.bottomBorder, "Should be true")
  assert_false(a.leftBorder, "Should be false")
  assert_true(a.rightBorder, "Should be true")
end

function test_input_f()
    local ps = require(SUT)
    local a = ps:new("f")
    assert_false(a.topBorder, "Should be false")
  assert_false(a.bottomBorder, "Should be false")
  assert_false(a.leftBorder, "Should be false")
  assert_false(a.rightBorder, "Should be false")
end


-- FIXME: Write tests
--[[function test_tile_fail()

    fail("Not tested , always fails...")
end]]




