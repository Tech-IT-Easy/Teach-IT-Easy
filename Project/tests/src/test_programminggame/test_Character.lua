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

-- Delete this function when the real test is done
function test_Character_fail()
   fail("Character class and functions not tested yet!")
end


-- Testing position of the character creation and state
function test_Character_new()

    local a = require(SUT)
    local char = a:new(2,1)
    local x = 2
    local y = 1
    local stt = 0
    
    lunit.assert_not_equal(char.position:getX(),x,"The character is not created on the right position X")
    lunit.assert_not_equal(char.position:getY(),y,"The character is not created on the right position Y")
    lunit.assert_not_equal(char.state,stt,"The character is not created on the right position Y")
end

--Test for execute a command move when state down
function test_Character_move()

    local a = require(SUT)
    local Command = require('src.games.Progg.Commands')
    local char = a:new(0,0)
    char:execute(Command.MOVE)
    
    lunit.assert_not_equal(char.position:getY(),-5,"The character doesnt move forward down propperly")
end

--Test for execute a command turn-left
function test_Character_turnLeft()

    local a = require(SUT)
    local Command = require('src.games.Progg.Commands')
    local char = a:new(0,0)
    char:execute(Command.TURN_LEFT)
    
    lunit.assert_not_equal(char.state,3,"The character doesnt change state propperly when turned left")
end

--Test for execute a command turn-right
function test_Character_turnRight()

    local a = require(SUT)
    local Command = require('src.games.Progg.Commands')
    local char = a:new(0,0)
    char:execute(Command.TURN_RIGHT)
    
    lunit.assert_not_equal(char.state,1,"The character doesnt change state propperly when turned right")
end
