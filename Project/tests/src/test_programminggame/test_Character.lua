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

--
--    local testsim = require('games.Progg.Map')
--    local lemock = require 'lemock' -- needed to be able to make a mock
--    local mc = lemock.controller() -- same here
--    local new = mc:mock()
--    local getPosition = mc:mock()
--    local load = mc:mock()
--    local canMove = mc:mock()
--    local setCharacter = mc:mock()
--    local moveCharacter = mc:mock()
--
--    package.preload['games.Progg.Map'].new = new
--    package.preload['games.Progg.Map'].getPosition = getPosition
--    package.preload['games.Progg.Map'].load = load
--    package.preload['games.Progg.Map'].canMove = canMove
--    package.preload['games.Progg.Map'].setCharacter = setCharacter
--    package.preload['games.Progg.Map'].moveCharacter = moveCharacter
--
--    new(mc.ANYARGS) ; mc:returns(load) :anytimes()
--    getPosition(mc.ANYARGS) ; mc:returns(nil) :anytimes()
--    load(mc.ANYARGS) ; mc:returns(nil) :anytimes()
--    canMove(mc.ANYARGS) ; mc:returns(true) :anytimes()
--    setCharacter(mc.ANYARGS) ; mc:returns(true) :anytimes()
--    moveCharacter(mc.ANYARGS) ; mc:returns(nil) :anytimes()
--
--    mc:close()
--    mc:replay()
--
--    local Character = require(SUT)
--
--    package.loaded['games.Progg.Map'] = nil
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
    local new_left = mc:mock()
    package.loaded['games.Progg.Map'] = nil -- need to delete the package where the function is taken from.
    package.preload['games.Progg.Map'] = function () -- Create preload. When the program wants to include love. This function will run instead
        return Map_left
    end
    print("TURN-left",mc ," ", Map_left, " ", new_left)

    Map_left.new(Map_left,mc.ANYARGS) ; mc:returns(new_left) :anytimes()
    new_left.getPosition(new_left,mc.ANYARGS) ; mc:returns(nil) :anytimes()
    new_left.load(new_left,mc.ANYARGS) ; mc:returns(nil) :anytimes()
    new_left.canMove(new_left,mc.ANYARGS) ; mc:returns(true) :anytimes()
    new_left.setCharacter(new_left,mc.ANYARGS) ; mc:returns(true) :anytimes()
    new_left.moveCharacter(new_left,mc.ANYARGS) ; mc:returns(nil) :anytimes()

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
    local new_left = mc:mock()
    package.loaded['games.Progg.Map'] = nil -- need to delete the package where the function is taken from.
    package.preload['games.Progg.Map'] = function () -- Create preload. When the program wants to include love. This function will run instead
        return Map_left
    end
    print("TURN-left",mc ," ", Map_left, " ", new_left)

    Map_left.new(Map_left,mc.ANYARGS) ; mc:returns(new_left) :anytimes()
    new_left.getPosition(new_left,mc.ANYARGS) ; mc:returns(nil) :anytimes()
    new_left.load(new_left,mc.ANYARGS) ; mc:returns(nil) :anytimes()
    new_left.canMove(new_left,mc.ANYARGS) ; mc:returns(true) :anytimes()
    new_left.setCharacter(new_left,mc.ANYARGS) ; mc:returns(true) :anytimes()
    new_left.moveCharacter(new_left,mc.ANYARGS) ; mc:returns(nil) :anytimes()

    mc:close()
    mc:replay()
    local Character = require(SUT)
    --    local lemock = require 'lemock' -- needed to be able to make a mock
    --    local mc = lemock.controller() -- same here
    --    local Map_move = mc:mock()
    --    local new_move = mc:mock()
    --    package.loaded['games.Progg.Map'] = nil -- need to delete the package where the function is taken from.
    --    package.preload['games.Progg.Map'] = function () -- Create preload. When the program wants to include love. This function will run instead
    --        local games = {}
    --        games.Progg = {}
    --        games.Progg.Map = Map_move
    --        return Map_move
    --    end
    --
    --    print("MOVE",mc ," ",Map_move, " ", new_move)
    --
    --    Map_move.new(mc.ANYARGS) ; mc:returns(new_move) :anytimes()
    --    new_move.load(mc.ANYARGS) ; mc:returns(nil) :anytimes()
    --    new_move.canMove(mc.ANYARGS) ; mc:returns(true) :anytimes()
    --    new_move.setCharacter(mc.ANYARGS) ; mc:returns(true) :anytimes()
    --    new_move.moveCharacter(mc.ANYARGS) ; mc:returns(nil) :anytimes()
    --
    --    mc:close()
    --    mc:replay()

    --local Character = require(SUT)

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
    local new_left = mc:mock()
    package.loaded['games.Progg.Map'] = nil -- need to delete the package where the function is taken from.
    package.preload['games.Progg.Map'] = function () -- Create preload. When the program wants to include love. This function will run instead
    local games = {}
    games.Progg = {}
    games.Progg.Map = Map_left
    return Map_left
    end
    print("TURN-left",mc ," ", Map_left, " ", new_left)

    Map_left.new(Map_left,mc.ANYARGS) ; mc:returns(new_left) :anytimes()
    new_left.getPosition(new_left,mc.ANYARGS) ; mc:returns(nil) :anytimes()
    new_left.load(new_left,mc.ANYARGS) ; mc:returns(nil) :anytimes()
    new_left.canMove(new_left,mc.ANYARGS) ; mc:returns(true) :anytimes()
    new_left.setCharacter(new_left,mc.ANYARGS) ; mc:returns(true) :anytimes()
    new_left.moveCharacter(new_left,mc.ANYARGS) ; mc:returns(nil) :anytimes()

    mc:close()
    mc:replay()

    local Character = require(SUT)
    --    local lemock = require 'lemock' -- needed to be able to make a mock
    --    local mc = lemock.controller() -- same here
    --    local Map_left = mc:mock()
    --    local new_left = mc:mock()
    --    package.loaded['games.Progg.Map'] = nil -- need to delete the package where the function is taken from.
    --    package.preload['games.Progg.Map'] = function () -- Create preload. When the program wants to include love. This function will run instead
    --        local games = {}
    --        games.Progg = {}
    --        games.Progg.Map = Map_left
    --        return Map_left
    --    end
    --    print("TURN-left",mc ," ", Map_left, " ", new_left)
    --
    --    Map_left.new(mc.ANYARGS) ; mc:returns(new_left) :anytimes()
    --    new_left.getPosition(mc.ANYARGS) ; mc:returns(nil) :anytimes()
    --    new_left.load(mc.ANYARGS) ; mc:returns(nil) :anytimes()
    --    new_left.canMove(mc.ANYARGS) ; mc:returns(true) :anytimes()
    --    new_left.setCharacter(mc.ANYARGS) ; mc:returns(true) :anytimes()
    --    new_left.moveCharacter(mc.ANYARGS) ; mc:returns(nil) :anytimes()
    --
    --    mc:close()
    --    mc:replay()

    --local Character = require(SUT)
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
    local new_left = mc:mock()
    package.loaded['games.Progg.Map'] = nil -- need to delete the package where the function is taken from.
    package.preload['games.Progg.Map'] = function () -- Create preload. When the program wants to include love. This function will run instead
        return Map_left
    end
    print("TURN-left",mc ," ", Map_left, " ", new_left)

    Map_left.new(Map_left,mc.ANYARGS) ; mc:returns(new_left) :anytimes()
    new_left.getPosition(new_left,mc.ANYARGS) ; mc:returns(nil) :anytimes()
    new_left.load(new_left,mc.ANYARGS) ; mc:returns(nil) :anytimes()
    new_left.canMove(new_left,mc.ANYARGS) ; mc:returns(true) :anytimes()
    new_left.setCharacter(new_left,mc.ANYARGS) ; mc:returns(true) :anytimes()
    new_left.moveCharacter(new_left,mc.ANYARGS) ; mc:returns(nil) :anytimes()

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
