--[[TEACH IT EASY, an educational games platform
    Copyright (C) 2015  Linköping University

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.


    MIT LICENSE:
    Copyright (c) 2015 Zenterio AB

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:



    The above copyright notice and this permission notice shall be included in
    all copies or substantial portions of the Software.


    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
    THE SOFTWARE.


    ]]
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

function setup()
    clear_mock()
end
-------------------------------------
-- Testing position of the character creation and state
-- @system_under_test: Character:new(newPosition)
-- @author name: ??
-------------------------------------

function test_Character_new()
    package.loaded[SUT] = nil
    package.loaded['games.Progg.Commands'] = nil
    local lemock = require 'lemock' -- needed to be able to make a mock
    local mc = lemock.controller() -- same here
    local Map_left = mc:mock()
    --local new_left = mc:mock()
    local getPosition = mc:mock()
    local load = mc:mock()
    local canMove = mc:mock()
    local setCharacter = mc:mock()
    local moveCharacter = mc:mock()

    package.loaded['games.Progg.Map'] = nil -- need to delete the package where the function is taken from.
    package.preload['games.Progg.Map'] = function () -- Create preload. When the program wants to include love. This function will run instead
        return Map_left
    end

    Map_left.new(Map_left,mc.ANYARGS) ; mc:returns({getPosition=getPosition, load=load, canMove=canMove, setCharacter=setCharacter
    ,moveCharacter=moveCharacter, startPos = 2}) :anytimes() --startPos =2 <=> 2+(1-1)*8 = 2 = x + (y - 1) * self.columns in getPosition in Map class
    getPosition(mc.ANYARGS) ; mc:returns(nil) :anytimes()
    load(mc.ANYARGS) ; mc:returns(nil) :anytimes()
    canMove(mc.ANYARGS) ; mc:returns(true) :anytimes()
    setCharacter(mc.ANYARGS) ; mc:returns(true) :anytimes()
    moveCharacter(mc.ANYARGS) ; mc:returns(nil) :anytimes()

    mc:close()
    mc:replay()
    local Character = require(SUT)

    local char = Character:new(2,1,nil,{level = 1, maxCommands = {["queue"] = 16, ["loop"] = 0, ["P1"] = 0, ["P2"] = 0, ["if-wall"] = 0, ["if-not-wall"] = 0 }, mapData = "ffffffff9aefffff5fffffff5fffffff7fffffff", levelGoalPosition = 11, levelStartPosition = 33, objectives = {} },nil)
    local x = 2
    local y = 1
    local stt = 0

    lunit.assert_equal(char.position.x,x,"The character is not created on the right position X")
    lunit.assert_equal(char.position.y,y,"The character is not created on the right position Y")
    lunit.assert_equal(char.state,stt,"The character is not created on the right position Y")
    mc:verify()


    package.loaded['games.Progg.Map'] = nil
    package.preload['games.Progg.Map'] = nil

end

-------------------------------------
-- Test for execute a command move when state up
-- @system_under_test: Character:new(newPosition), Character:execute(command)
-- @author name: ??
-------------------------------------

function test_Character_move()
    package.loaded[SUT] = nil
    package.loaded['games.Progg.Commands'] = nil
    local lemock = require 'lemock' -- needed to be able to make a mock
    local mc = lemock.controller() -- same here
    local Map_left = mc:mock()
    --local new_left = mc:mock()
    local getPosition = mc:mock()
    local load = mc:mock()
    local canMove = mc:mock()
    local setCharacter = mc:mock()
    local moveCharacter = mc:mock()

    package.loaded['games.Progg.Map'] = nil -- need to delete the package where the function is taken from.
    package.preload['games.Progg.Map'] = function () -- Create preload. When the program wants to include love. This function will run instead
        return Map_left
    end

    Map_left.new(Map_left,mc.ANYARGS) ; mc:returns({getPosition=getPosition, load=load, canMove=canMove, setCharacter=setCharacter
    ,moveCharacter=moveCharacter, startPos = 9}) :anytimes() --startPos =9 <=> 1+(2-1)*8 = 9 = x + (y - 1) * self.columns in getPosition in Map class
    getPosition(mc.ANYARGS) ; mc:returns(nil) :anytimes()
    load(mc.ANYARGS) ; mc:returns(nil) :anytimes()
    canMove(mc.ANYARGS) ; mc:returns(true) :anytimes()
    setCharacter(mc.ANYARGS) ; mc:returns(true) :anytimes()
    moveCharacter(mc.ANYARGS) ; mc:returns(nil) :anytimes()

    mc:close()
    mc:replay()
    local Character = require(SUT)
    local Command = require('games.Progg.Commands')
    local char = Character:new(1,2,nil,{level = 1, maxCommands = {["queue"] = 16, ["loop"] = 0, ["P1"] = 0, ["P2"] = 0, ["if-wall"] = 0, ["if-not-wall"] = 0 }, mapData = "ffffffff9aefffff5fffffff5fffffff7fffffff", levelGoalPosition = 11, levelStartPosition = 33, objectives = {} },nil)

    char:execute(Command.MOVE)

    lunit.assert_equal(char.position.y,1,"The character doesnt move forward up properly")
    mc:verify()
    package.loaded['games.Progg.Map'] = nil
    package.preload['games.Progg.Map'] = nil

end

---------------------------------------
---- Test for execute a command turn-left
---- @system_under_test: Character:new(newPosition), Character:execute(command)
---- @author name: ??
---------------------------------------

function test_Character_turnLeft()
    package.loaded[SUT] = nil
    package.loaded['games.Progg.Commands'] = nil
    local lemock = require 'lemock' -- needed to be able to make a mock
    local mc = lemock.controller() -- same here
    local Map_left = mc:mock()
    --local new_left = mc:mock()
    local getPosition = mc:mock()
    local load = mc:mock()
    local canMove = mc:mock()
    local setCharacter = mc:mock()
    local moveCharacter = mc:mock()

    package.loaded['games.Progg.Map'] = nil -- need to delete the package where the function is taken from.
    package.preload['games.Progg.Map'] = function () -- Create preload. When the program wants to include love. This function will run instead
    local games = {}
    games.Progg = {}
    games.Progg.Map = Map_left
    return Map_left
    end

    Map_left.new(Map_left,mc.ANYARGS) ; mc:returns({getPosition=getPosition, load=load, canMove=canMove, setCharacter=setCharacter
    ,moveCharacter=moveCharacter, startPos = 33}) :anytimes()
    getPosition(mc.ANYARGS) ; mc:returns(nil) :anytimes()
    load(mc.ANYARGS) ; mc:returns(nil) :anytimes()
    canMove(mc.ANYARGS) ; mc:returns(true) :anytimes()
    setCharacter(mc.ANYARGS) ; mc:returns(true) :anytimes()
    moveCharacter(mc.ANYARGS) ; mc:returns(nil) :anytimes()

    mc:close()
    mc:replay()

    local Character = require(SUT)
    local Command = require('games.Progg.Commands')
    local char = Character:new(2,1,nil,{level = 1, maxCommands = {["queue"] = 16, ["loop"] = 0, ["P1"] = 0, ["P2"] = 0, ["if-wall"] = 0, ["if-not-wall"] = 0 }, mapData = "ffffffff9aefffff5fffffff5fffffff7fffffff", levelGoalPosition = 11, levelStartPosition = 33, objectives = {} },nil)
    char:execute(Command.TURN_LEFT)

    lunit.assert_equal(char.state,3,"The character doesnt change state properly when turned left")
    mc:verify()
    package.loaded['games.Progg.Map'] = nil
    package.preload['games.Progg.Map'] = nil

end

-----------------------------------------
------Test for execute a command turn-right
------ @system_under_test: Character:new(newPosition), Character:execute(command)
------ @author name: ??
-----------------------------------------
--
function test_Character_turnRight()
    package.loaded[SUT] = nil
    package.loaded['games.Progg.Commands'] = nil
    local lemock = require 'lemock' -- needed to be able to make a mock
    local mc = lemock.controller() -- same here
    local Map_left = mc:mock()
    --local new_left = mc:mock()
    local getPosition = mc:mock()
    local load = mc:mock()
    local canMove = mc:mock()
    local setCharacter = mc:mock()
    local moveCharacter = mc:mock()

    package.loaded['games.Progg.Map'] = nil -- need to delete the package where the function is taken from.
    package.preload['games.Progg.Map'] = function () -- Create preload. When the program wants to include love. This function will run instead
        return Map_left
    end

    Map_left.new(Map_left,mc.ANYARGS) ; mc:returns({getPosition=getPosition, load=load, canMove=canMove, setCharacter=setCharacter
    ,moveCharacter=moveCharacter, startPos = 33}) :anytimes()
    getPosition(mc.ANYARGS) ; mc:returns(nil) :anytimes()
    load(mc.ANYARGS) ; mc:returns(nil) :anytimes()
    canMove(mc.ANYARGS) ; mc:returns(true) :anytimes()
    setCharacter(mc.ANYARGS) ; mc:returns(true) :anytimes()
    moveCharacter(mc.ANYARGS) ; mc:returns(nil) :anytimes()

    mc:close()
    mc:replay()

    local Character = require(SUT)

    local Command = require('games.Progg.Commands')
    local char = Character:new(2,1,nil,{level = 1, maxCommands = {["queue"] = 16, ["loop"] = 0, ["P1"] = 0, ["P2"] = 0, ["if-wall"] = 0, ["if-not-wall"] = 0 }, mapData = "ffffffff9aefffff5fffffff5fffffff7fffffff", levelGoalPosition = 11, levelStartPosition = 33, objectives = {} },nil)
    char:execute(Command.TURN_RIGHT)

    lunit.assert_equal(char.state,1,"The character doesnt change state propperly when turned right")
    mc:verify()
    package.loaded['games.Progg.Map'] = nil
    package.preload['games.Progg.Map'] = nil
end
