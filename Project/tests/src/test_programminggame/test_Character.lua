--
-- Created by IntelliJ IDEA.
-- User: Andreas Mansson
-- Date: 2015-11-05
-- Time: 11:34
-- To change this template use File | Settings | File Templates.
--

lunit = require "lunit"
module( "test_Character", package.seeall, lunit.testcase )
local lemock = require 'lemock'
local SUT = 'games.Progg.Character'

-------------------------------------
-- Testing position of the character creation and state
-- @system_under_test: Character:new(newPosition)
-- @author name: ??
-------------------------------------

function test_Character_new()
    local class_to_mock = "games.Progg.Map"

    local mc = lemock.controller()
    local Map = mc:mock()
    local env = mc:mock()
    package.loaded[class_to_mock] = nil
    package.preload[class_to_mock] = function()
        local games = {}
        games.Progg = {}
        games.Progg.Map =Map

        return Map
    end
    Map:new(mc.ANYARGS) ;mc :returns(env) :anytimes()
    env:setCharacter(mc.ANYARGS) ;mc :returns(nil) :anytimes()
    env:load(mc.ANYARGS) ;mc :returns(nil) :anytimes()
    env:canMove(mc.ANYARGS) ;mc :returns(true) :anytimes()
    env:moveCharacter(mc.ANYARGS) ;mc :returns(nil) :anytimes()
    env:getPosition(mc.ANYARGS) ;mc :returns(nil) :anytimes()
    mc:replay()

    local Character = require(SUT)
    local char = Character:new(2,1)
    local x = 2
    local y = 1
    local stt = 0

    lunit.assert_equal(char.position.x,x,"The character is not created on the right position X")
    lunit.assert_equal(char.position.y,y,"The character is not created on the right position Y")
    lunit.assert_equal(char.state,stt,"The character is not created on the right position Y")
    mc:verify()
    package.loaded[class_to_mock] = nil
    package.preload[class_to_mock] = nil
end

-------------------------------------
-- Test for execute a command move when state up
-- @system_under_test: Character:new(newPosition), Character:execute(command)
-- @author name: ??
-------------------------------------

function test_Character_move()
    local class_to_mock = "games.Progg.Map"

    local mc = lemock.controller()
    local Map = mc:mock()
    local env = mc:mock()
    package.loaded[class_to_mock] = nil
    package.preload[class_to_mock] = function()
        local games = {}
        games.Progg = {}
        games.Progg.Map =Map

        return Map
    end
    Map:new(mc.ANYARGS) ;mc :returns(env) :anytimes()
    env:setCharacter(mc.ANYARGS) ;mc :returns(nil) :anytimes()
    env:load(mc.ANYARGS) ;mc :returns(nil) :anytimes()
    env:canMove(mc.ANYARGS) ;mc :returns(true) :anytimes()
    env:moveCharacter(mc.ANYARGS) ;mc :returns(nil) :anytimes()
    env:getPosition(mc.ANYARGS) ;mc :returns(nil) :anytimes()
    mc:replay()

    local Character = require(SUT)

    local Command = require('games.Progg.Commands')
    local char = Character:new(1,2,nil,{level = 1, maxCommands = {["queue"] = 16, ["loop"] = 0, ["P1"] = 0, ["P2"] = 0, ["if-wall"] = 0, ["if-not-wall"] = 0 }, mapData = "ffffffff9aefffff5fffffff5fffffff7fffffff", levelGoalPosition = 11, levelStartPosition = 33, objectives = {} },nil)
    char:execute(Command.MOVE)
    
    lunit.assert_equal(char.position.y,1,"The character doesnt move forward up properly")
    mc:verify()
    package.loaded[class_to_mock] = nil
    package.preload[class_to_mock] = nil
end

-------------------------------------
-- Test for execute a command turn-left
-- @system_under_test: Character:new(newPosition), Character:execute(command)
-- @author name: ??
-------------------------------------

function test_Character_turnLeft()
    local class_to_mock = "games.Progg.Map"

    local mc = lemock.controller()
    local Map = mc:mock()
    local env = mc:mock()
    package.loaded[class_to_mock] = nil
    package.preload[class_to_mock] = function()
        local games = {}
        games.Progg = {}
        games.Progg.Map =Map

        return Map
    end
    Map:new(mc.ANYARGS) ;mc :returns(env) :anytimes()
    env:setCharacter(mc.ANYARGS) ;mc :returns(nil) :anytimes()
    env:load(mc.ANYARGS) ;mc :returns(nil) :anytimes()
    env:canMove(mc.ANYARGS) ;mc :returns(true) :anytimes()
    env:moveCharacter(mc.ANYARGS) ;mc :returns(nil) :anytimes()
    env:getPosition(mc.ANYARGS) ;mc :returns(nil) :anytimes()
    mc:replay()

    local Character = require(SUT)
    local Command = require('games.Progg.Commands')
    local char = Character:new(2,1)
    char:execute(Command.TURN_LEFT)

    lunit.assert_equal(char.state,3,"The character doesnt change state properly when turned left")
    mc:verify()
    package.loaded[class_to_mock] = nil
    package.preload[class_to_mock] = nil
end

---------------------------------------
----Test for execute a command turn-right
---- @system_under_test: Character:new(newPosition), Character:execute(command)
---- @author name: ??
---------------------------------------

function test_Character_turnRight()
    local class_to_mock = "games.Progg.Map"

    local mc = lemock.controller()
    local Map = mc:mock()
    local env = mc:mock()
    package.loaded[class_to_mock] = nil
    package.preload[class_to_mock] = function()
        local games = {}
        games.Progg = {}
        games.Progg.Map =Map

        return Map
    end
    Map:new(mc.ANYARGS) ;mc :returns(env) :anytimes()
    env:setCharacter(mc.ANYARGS) ;mc :returns(nil) :anytimes()
    env:load(mc.ANYARGS) ;mc :returns(nil) :anytimes()
    env:canMove(mc.ANYARGS) ;mc :returns(true) :anytimes()
    env:moveCharacter(mc.ANYARGS) ;mc :returns(nil) :anytimes()
    env:getPosition(mc.ANYARGS) ;mc :returns(nil) :anytimes()
    mc:replay()

    local Character = require(SUT)
    local Command = require('games.Progg.Commands')
    local char = Character:new(2,1)
    char:execute(Command.TURN_RIGHT)

    lunit.assert_equal(char.state,1,"The character doesnt change state propperly when turned right")
    mc:verify()
    package.loaded[class_to_mock] = nil
    package.preload[class_to_mock] = nil
end
