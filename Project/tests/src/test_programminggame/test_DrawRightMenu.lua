--
-- Created by IntelliJ IDEA.
-- User: Vilhelm
-- Date: 2015-11-17
-- Time: 14:32
-- To change this template use File | Settings | File Templates.
--


lunit = require "lunit"
module( "test_DrawRightMenu", package.seeall, lunit.testcase )
--my_file = require "games.Progg.DrawRightMenu"

local SUT = 'games.Progg.DrawRightMenu'

local function create_mock(class_to_mock)
  -- unload the package if loaded to dismiss previous mocks
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
  -- if error fail the test.
  if err then
  fail(err)
  end
end

function setup()
    clear_mock()
end

-------------------------------------
-- Testing that the getPosition returns a correct
-- number for a command
-- @system_under_test: DrawRightMenu:new(), DrawRightMenu:getPosition(command)
-- @author name: Vilhelm
-------------------------------------

function test_getPosition_correctCommand()
  -- command "move" is inputed
  local mc = create_mock(SUT)
  local ps = require(SUT)

  mc:replay()

  local a = ps:new()
  event = "move"
  assert_equal(1, a:getPosition(event), "should return 1, didn't")

  verify_mock(mc)
end

-------------------------------------
-- Testing that the getPosition doesn't
-- return a number for a non-existing command
-- @system_under_test: DrawRightMenu:new(), DrawRightMenu:getPosition(command)
-- @author name: Vilhelm
-------------------------------------

function test_getPosition_falseCommand()
  local mc = create_mock(SUT)
  local ps = require(SUT)

  mc:replay()

  local a = ps:new()
  event = "jump"
  assert_equal(nil, a:getPosition(event), "should return nothing, didn't")

  verify_mock(mc)
end

-------------------------------------
-- Testing that the getPosition returns a correct
-- file name for a command
-- @system_under_test: DrawRightMenu:new(), DrawRightMenu:getFileName(command)
-- @author name: Vilhelm
-------------------------------------

function test_getFileName_correctCommand()
  -- command "move" is inputed
  local mc = create_mock(SUT)
  local ps = require(SUT)

  mc:replay()

  local a = ps:new()
  event = "move"
  assert_equal("data/progg_game_icons/arrow_up.png", a:getFileName(event), "should return file name, didn't")

  verify_mock(mc)
end

-------------------------------------
-- Testing that the getPosition doesn't return
-- a file name for a non-existing command
-- @system_under_test: DrawRightMenu:new(), DrawRightMenu:getFileName(command)
-- @author name: Vilhelm
-------------------------------------

function test_getFileName_falseCommand()
  local mc = create_mock(SUT)
  local ps = require(SUT)

  mc:replay()

  local a = ps:new()
  event = "jump"
  assert_equal(nil, a:getFileName(event), "should return nothing, didn't")

  verify_mock(mc)
end
