--
-- Created by IntelliJ IDEA.
-- User: Andreas Mansson
-- Date: 2015-11-05
-- Time: 11:34
-- To change this template use File | Settings | File Templates.
--

lunit = require "lunit"
module( "test_Character", package.seeall, lunit.testcase )
local SUT = 'games.Progg.Character'

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
  package.loaded['games.Progg.Map'] = nil
  package.preload['games.Progg.Map'] = nil
end

-------------------------------------
-- Testing position of the character creation and state
-- @system_under_test: Character:new(newPosition)
-- @author name: ??
-------------------------------------

function test_Character_new()

    local Character = require(SUT)

    --local Character = require(SUT)
    local char = Character:new(2,1,nil,{level = 1, maxCommands = {["queue"] = 16, ["loop"] = 0, ["P1"] = 0, ["P2"] = 0, ["if-wall"] = 0, ["if-not-wall"] = 0 }, mapData = "ffffffff9aefffff5fffffff5fffffff7fffffff", levelGoalPosition = 11, levelStartPosition = 33, objectives = {} },context_sim)
    local x = 2
    local y = 1
    local stt = 0

    lunit.assert_equal(char.position.x,x,"The character is not created on the right position X")
    lunit.assert_equal(char.position.y,y,"The character is not created on the right position Y")
    lunit.assert_equal(char.state,stt,"The character is not created on the right position Y")
    --mc:verify()
    verify_mock(mc)
end

-------------------------------------
-- Test for execute a command move when state up
-- @system_under_test: Character:new(newPosition), Character:execute(command)
-- @author name: ??
-------------------------------------

function test_Character_move()

    local mc = create_mock(SUT)
    local drawHighlight = mc:mock()
    local ps=require(class_to_mock)
    package.loaded[class_to_mock].drawHighlight = drawHighlight
    drawHighlight(mc.ANYARGS) ;mc :returns(nil) :anytimes()

  mc:replay()

    local Character = require(SUT)

    local Command = require('games.Progg.Commands')
    local char = Character:new(1,2,nil,{level = 1, maxCommands = {["queue"] = 16, ["loop"] = 0, ["P1"] = 0, ["P2"] = 0, ["if-wall"] = 0, ["if-not-wall"] = 0 }, mapData = "ffffffff9aefffff5fffffff5fffffff7fffffff", levelGoalPosition = 11, levelStartPosition = 33, objectives = {} },context_sim)
    char:execute(Command.MOVE)
    
    lunit.assert_equal(char.position.y,1,"The character doesnt move forward up properly")
    --mc:verify()
    verify_mock(mc)
end

-------------------------------------
-- Test for execute a command turn-left
-- @system_under_test: Character:new(newPosition), Character:execute(command)
-- @author name: ??
-------------------------------------

function test_Character_turnLeft()

local Character = require(SUT)
    local Command = require('games.Progg.Commands')
    local char = Character:new(2,1,nil,{level = 1, maxCommands = {["queue"] = 16, ["loop"] = 0, ["P1"] = 0, ["P2"] = 0, ["if-wall"] = 0, ["if-not-wall"] = 0 }, mapData = "ffffffff9aefffff5fffffff5fffffff7fffffff", levelGoalPosition = 11, levelStartPosition = 33, objectives = {} },context_sim)
    char:execute(Command.TURN_LEFT)

    lunit.assert_equal(char.state,3,"The character doesnt change state properly when turned left")
    --mc:verify()
    verify_mock(mc)
end

---------------------------------------
----Test for execute a command turn-right
---- @system_under_test: Character:new(newPosition), Character:execute(command)
---- @author name: ??
---------------------------------------

function test_Character_turnRight()

local Character = require(SUT)
    local Command = require('games.Progg.Commands')
    local char = Character:new(2,1,nil,{level = 1, maxCommands = {["queue"] = 16, ["loop"] = 0, ["P1"] = 0, ["P2"] = 0, ["if-wall"] = 0, ["if-not-wall"] = 0 }, mapData = "ffffffff9aefffff5fffffff5fffffff7fffffff", levelGoalPosition = 11, levelStartPosition = 33, objectives = {} },context_sim)
    char:execute(Command.TURN_RIGHT)

    lunit.assert_equal(char.state,1,"The character doesnt change state propperly when turned right")

    verify_mock(mc)
end
