--
-- Created by IntelliJ IDEA.
-- User: Andreas Mansson
-- Date: 2015-11-05
-- Time: 11:34
-- To change this template use File | Settings | File Templates.
--

lunit = require "lunit"
module( "test_Character", package.seeall, lunit.testcase )

local SUT = 'src.games.Progg.Character'


-- Testing position of the character creation and state
function test_Character_new()

    local a = require(SUT)
    local pos = require('src.games.Progg.Position'):new(2,1)
    local char = a:new(pos)
    local x = 2
    local y = 1
    local stt = 0
    
    lunit.assert_equal(char.position:getX(),x,"The character is not created on the right position X")
    lunit.assert_equal(char.position:getY(),y,"The character is not created on the right position Y")
    lunit.assert_equal(char.state,stt,"The character is not created on the right position Y")
end

--Test for execute a command move when state down
function test_Character_move()

    local a = require(SUT)
    local Command = require('src.games.Progg.Commands')
    local pos = require('src.games.Progg.Position'):new(0,0)
    local char = a:new(pos)
    char:execute(Command.MOVE)
    
    lunit.assert_equal(char.position:getY(),-5,"The character doesnt move forward down propperly")
end

--Test for execute a command turn-left
function test_Character_turnLeft()

    local a = require(SUT)
    local Command = require('src.games.Progg.Commands')
    local pos = require('src.games.Progg.Position'):new(2,1)
    local char = a:new(pos)
    char:execute(Command.TURN_LEFT)
    
    lunit.assert_equal(char.state,3,"The character doesnt change state propperly when turned left")
end

--Test for execute a command turn-right
function test_Character_turnRight()

    local a = require(SUT)
    local Command = require('src.games.Progg.Commands')
    local pos = require('src.games.Progg.Position'):new(2,1)
    local char = a:new(pos)
    char:execute(Command.TURN_RIGHT)
    
    lunit.assert_equal(char.state,1,"The character doesnt change state propperly when turned right")
end
