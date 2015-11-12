--
-- Created by IntelliJ IDEA.
-- User: johannaskolling
-- Date: 15-11-12
-- Time: 10:51
-- To change this template use File | Settings | File Templates.
--

lunit = require "lunit"
module( "Integration_commands_queue", package.seeall, lunit.testcase )
local event = require "src.toolkit.Event"
local SUT1 =  'src.games.Progg.Queue'
local SUT2 =  'src.games.Progg.Commands'

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
  package.loaded['src.games.Progg.Queue'] = nil
  package.preload['src.games.Progg.Queue'] = nil
end


function test_queue_with_commands()
  local class_to_mock = "games.Progg.BottomMenu"
  package.loaded[class_to_mock]:drawIcons = nil
  package.preload[class_to_mock] = nil
  -- import lemock
  local lemock = require 'lemock'
  -- initiate mock controller
  local mc = lemock.controller()


  local drawIcons = mc:mock()

  drawIcons(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  mc:replay()

  local newBottomMenu = require "games.Progg.BottomMenu"


  local ps = require(SUT2)
  a = ps:new(ps.MOVE)
 -- a.command = a.MOVE
  local bb = require(SUT1)
  b = bb:new(newBottomMenu)
  b:push(a)

end