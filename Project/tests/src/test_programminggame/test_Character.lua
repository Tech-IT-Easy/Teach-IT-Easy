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

-------------------------------------
-- Testing position of the character creation and state
-- @system_under_test: Character:new(newPosition)
-- @author name: ??
-------------------------------------

function test_Character_new()

    local Character = require(SUT)
    --x,y, rightMenu, levelData, context
    local leveldata = {objectives={1}}
    local rightmenu = {}
    local context = {}
    local char = Character:new(2,1, rightmenu, leveldata, context)
    local x = 2
    local y = 1
    local stt = 0
    
    lunit.assert_equal(char.position.x,x,"The character is not created on the right position X")
    lunit.assert_equal(char.position.y,y,"The character is not created on the right position Y")
    lunit.assert_equal(char.state,stt,"The character is not created on the right position Y")
end

-------------------------------------
-- Test for execute a command move when state up
-- @system_under_test: Character:new(newPosition), Character:execute(command)
-- @author name: ??
-------------------------------------

function test_Character_move()

    local Character = require(SUT)
    local Command = require('games.Progg.Commands')
    local char = Character:new(1,2)
    char:execute(Command.MOVE)
    
    lunit.assert_equal(char.position.y,1,"The character doesnt move forward up properly")
end

-------------------------------------
-- Test for execute a command turn-left
-- @system_under_test: Character:new(newPosition), Character:execute(command)
-- @author name: ??
-------------------------------------

function test_Character_turnLeft()

    local Character = require(SUT)
    local Command = require('games.Progg.Commands')
    local char = Character:new(2,1)
    char:execute(Command.TURN_LEFT)
    
    lunit.assert_equal(char.state,3,"The character doesnt change state properly when turned left")
end

-------------------------------------
--Test for execute a command turn-right
-- @system_under_test: Character:new(newPosition), Character:execute(command)
-- @author name: ??
-------------------------------------

function test_Character_turnRight()

    local Character = require(SUT)
    local Command = require('games.Progg.Commands')
    local char = Character:new(2,1)
    char:execute(Command.TURN_RIGHT)
    
    lunit.assert_equal(char.state,1,"The character doesnt change state propperly when turned right")
end
