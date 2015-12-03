--
-- Created by IntelliJ IDEA.
-- User: Andreas Mansson
-- Date: 2015-11-16
-- Time: 22:45
-- To change this template use File | Settings | File Templates.
--

lunit = require "lunit"
module( "inttest_id_3", package.seeall, lunit.testcase )

local SUT1 = 'games.Progg.Commands'
local SUT2 = 'games.Progg.BuildArea'
local SUT3 = 'games.Progg.Character'
local SUT4 = 'games.Progg.Queue'

--Corresponds to function bottomMenuEventHandler:update(object,eventListener,event)
--in BottomMenu

--local function create_mock(class_to_mock)
--  -- unload the package if loaded to dissmiss previous mocks
--  package.loaded[class_to_mock] = nil
--  package.preload[class_to_mock] = nil
--  -- import lemock
--  local lemock = require 'lemock'
--  -- initiate mock controller
--  local mc = lemock.controller()
--  return mc
--end
--
--local function verify_mock(mc)
--  local status, err = pcall(function ()
--    -- Verify that the mocks has been called as stated.
--    mc:verify()
--  end)
--  if err then -- if error fail the test.
--    fail(err)
--  end
--end
--
--function setup()
--
--end
--
--function teardown()
--  package.loaded['games.Progg.Queue'] = nil
--  package.preload['games.Progg.Queue'] = nil
--end


--function test_update_queue()
--    local queue = require(SUT4)
--    local commands = require(SUT1)
--    local buildarea =require(SUT2)
--    local q = queue:new()
--    local inputArea = "queue"
--
--    local class_to_mock = "games.Progg.BottomMenu"
--    local mc = create_mock(class_to_mock)
--    local drawIcons = mc:mock()
--    local setQueue = mc:mock()
--
--    --Only drawIcons in ButtomMenu need to be mocked. Reload class
--    local ps=require(class_to_mock)
--
--    package.loaded[class_to_mock].drawIcons = drawIcons
--    package.loaded[class_to_mock].setQueue = setQueue
--
--    drawIcons(mc.ANYARGS) ;mc :returns(nil) :anytimes()
--    setQueue(mc.ANYARGS) ;mc :returns(nil) :anytimes()
--    mc:replay()
--
--    local ps1 = require(SUT1)
--    local ps4=ps:new()
--
--    local event = require "toolkit.Event"
--    event.key = event.KEY_ONE
--
--    local a = ps1:new(event)
--    -- a.command = a.MOVE
--    -- SUT1 =  'games.Progg.Queue'
--    -- SUT2 =  'games.Progg.Commands'
--    local bb = require(SUT4)
--    local b = bb:new(ps4,buildarea:new(16))
--
--
--    --Push MOVE-command into queue
--    b:push(commands.MOVE, inputArea)
--    local c1 = b.actions[1]
--    lunit.assert_equal(commands.MOVE, c1, "Did not found the correct element in the queue")
--
--    --Push TURN_LEFT-command into queue
--    b:push(commands.TURN_LEFT, inputArea)
--    local c1 = b.actions[2]
--    lunit.assert_equal(commands.TURN_LEFT, c1, "Did not found the correct element in the queue")
--
--    --Push TURN_RIGHT-command into queue
--    b:push(commands.TURN_RIGHT, inputArea)
--    local c1 = b.actions[2]
--    lunit.assert_equal(commands.TURN_RIGHT, c1, "Did not found the correct element in the queue")
--
--    --Push TURN_LEFT-command into queue
--    b:push(commands.TURN_LEFT, inputArea)
--    local c1 = b.actions[2]
--    lunit.assert_equal(commands.TURN_LEFT, c1, "Did not found the correct element in the queue")
--
--
--
--    --local BottomMenu = require(SUT)
--    --local bm = BottomMenu:new(16,nil)
--
--    --bm.queue:push(Commands.MOVE, "queue")
--
--    --local a = Event:new(Event.KEY_ONE, Event.KEY_STATE_DOWN)
--
--    --bm.bottomM1enuEventHandler:update(bm,nil,a)
--    --bm.queue:push(Commands.MOVE, "queue")
--end

function setup()
    clear_mock()
    event = require ("toolkit.Event")
    Commands = require('games.Progg.Commands')
end


function test_adding_commands()
    local levelData = require('games.Progg.levels.ProggLevels'):new()
    local leveldata = levelData:getProggLevels()
    local GameProgress = require('toolkit.GameProgress')

    local context_sim = {}
    context_sim.profile={}
    context_sim.profile.images={}
    context_sim.profile.images.UP='data/avatar/cute_robot/UP.png'
    context_sim.profile.images.DOWN='data/avatar/cute_robot/UP.png'
    context_sim.profile.images.RIGHT='data/avatar/cute_robot/UP.png'
    context_sim.profile.images.LEFT='data/avatar/cute_robot/UP.png'
    context_sim.profile.gameprogress = GameProgress:new("test_avatar")

    leveldata[4].mapData = "9acfffff5f3cffff5ff7ffff5fffffff7fffffff"

    local test = require("games.Progg.BottomMenu")
    local commands = require('games.Progg.Commands')
    local bottommenu = test:new(leveldata[4],context_sim)
    local test_event
    local bm_queue
    local test_command

    -----------------------------------------------------------------------------------------------
     -- Adding some commands
    -----------------------------------------------------------------------------------------------
    --Tests function bottomMenuEventHandler:update in BottomMenu when key is pressed with key = "1"
    test_event = event:new("1", "down") --simulates a key press on key 1
    bottomMenuEventHandler:update(bottommenu,nil,test_event)
    bm_queue = bottommenu.queue.actions[1]
    --print("Added " .. bm_queue .. " in the queue")
    test_command = commands.MOVE
    lunit.assert_equal(test_command, bm_queue,  "Did not found the correct element in the queue")

    --Tests function bottomMenuEventHandler:update in BottomMenu when key is pressed with key = "2"
    test_event = event:new("2", "down") --simulates a key press on key 2
    bottomMenuEventHandler:update(bottommenu,nil,test_event)
    bm_queue = bottommenu.queue.actions[2]
    --print("Added " .. bm_queue .. " in the queue")
    test_command = commands.TURN_LEFT
    lunit.assert_equal(test_command, bm_queue, "Did not found the correct element in the queue")

    --Tests function bottomMenuEventHandler:update in BottomMenu when key is pressed with key = "3"
    test_event = event:new("3", "down") --simulates a key press on key 3
    bottomMenuEventHandler:update(bottommenu,nil,test_event)
    bm_queue = bottommenu.queue.actions[3]
    --print("Added " .. bm_queue .. " in the queue")
    test_command = commands.TURN_RIGHT
    lunit.assert_equal(test_command, bm_queue, "Did not found the correct element in the queue")

    --print("Commands added")
    -----------------------------------------------------------------------------------------------
     -- Added commands
    -----------------------------------------------------------------------------------------------

    --TO BE IMPLEMENTED WHEN BOTTOMMENU IS FULLY IMPLEMENTED!
    --Tests function bottomMenuEventHandler:update in BottomMenu when key is pressed with key = "4"
--    test_event = event:new("4", "down") --simulates a key press on key 4
--    bottomMenuEventHandler:update(bottommenu,nil,test_event)
--    bm_queue = bottommenu.queue.actions[4]
--    print("Added " .. bm_queue .. " in the queue")
--    test_command = commands.TURN_RIGHT
--    lunit.assert_equal(bm_queue, test_command, "Did not found the correct element in the queue")

    --TO BE IMPLEMENTED WHEN BOTTOMMENU IS FULLY IMPLEMENTED!
    --Tests function bottomMenuEventHandler:update in BottomMenu when key is pressed with key = "5"
--    test_event = event:new("5", "down") --simulates a key press on key 5
--    bottomMenuEventHandler:update(bottommenu,nil,test_event)
--    bm_queue = bottommenu.queue.actions[5]
--    print("Added " .. bm_queue .. " in the queue")
--    test_command = commands.TURN_RIGHT
--    lunit.assert_equal(bm_queue, test_command, "Did not found the correct element in the queue")

    -----------------------------------------------------------------------------------------------
     -- Creating LOOP-action
    -----------------------------------------------------------------------------------------------
    --Tests function bottomMenuEventHandler:update in BottomMenu when key is pressed with key = "6"
    test_event = event:new("6", "down") --simulates a key press on key 6
    bottomMenuEventHandler:update(bottommenu,nil,test_event)
    bm_queue = bottommenu.queue.actions[4] --NEED TO CHANGE THIS TO 6 WHEN CODE ABOVE IS UNCOMMENTED!
    --print("Added " .. bm_queue .. " in the queue")
    test_command = commands.LOOP
    lunit.assert_equal(test_command, bm_queue, "Did not found the correct element in the queue")

    --Select number of iteration. Selects 5 iterations in this case.
    test_event = event:new("5", "down") --simulates a key press on key 6
    bottomMenuEventHandler:update(bottommenu,nil,test_event)
    local loopCounter = bottommenu.queue.loopCounter
    --print("Number of iterations: " .. loopCounter)
    lunit.assert_equal(5, loopCounter[1], "Not correct number of iterations")

    --Tests function bottomMenuEventHandler:update in BottomMenu when key is pressed with key = "1"
    --Adding MOVE-action to loop
    test_event = event:new("1", "down") --simulates a key press on key 1
    bottomMenuEventHandler:update(bottommenu,nil,test_event)
    bm_queue = bottommenu.queue.loopActions[1][1]
    --print("Added " .. bm_queue .. " in the loop-queue")
    test_command = commands.MOVE
    lunit.assert_equal(test_command, bm_queue, "Did not found the correct element in the queue")

    --Tests function bottomMenuEventHandler:update in BottomMenu when key is pressed with key = "2"
    --Adding TURN_LEFT-action to loop
    test_event = event:new("2", "down") --simulates a key press on key 2
    bottomMenuEventHandler:update(bottommenu,nil,test_event)
    bm_queue = bottommenu.queue.loopActions[1][2]
    --print("Added " .. bm_queue .. " in the loop-queue")
    test_command = commands.TURN_LEFT
    lunit.assert_equal(test_command, bm_queue, "Did not found the correct element in the queue")

    --Tests function bottomMenuEventHandler:update in BottomMenu when key is pressed with key = "3"
    --Adding TURN_RIGHT-action to loop
    test_event = event:new("3", "down") --simulates a key press on key 3
    bottomMenuEventHandler:update(bottommenu,nil,test_event)
    bm_queue = bottommenu.queue.loopActions[1][3]
    --print("Added " .. bm_queue .. " in the loop-queue")
    test_command = commands.TURN_RIGHT
    lunit.assert_equal(test_command, bm_queue, "Did not found the correct element in the queue")

    --Exits the loop-mode
    test_event = event:new("0", "down") --simulates a key press on key
    bottomMenuEventHandler:update(bottommenu,nil,test_event)

    --print("LOOP-action created")
    -----------------------------------------------------------------------------------------------
     -- LOOP-action created
    -----------------------------------------------------------------------------------------------


    -----------------------------------------------------------------------------------------------
     -- Adding some commands
    -----------------------------------------------------------------------------------------------
    --Tests function bottomMenuEventHandler:update in BottomMenu when key is pressed with key = "2"
    test_event = event:new("2", "down") --simulates a key press on key 2
    bottomMenuEventHandler:update(bottommenu,nil,test_event)
    bm_queue = bottommenu.queue.actions[5]
    --print("Added " .. bm_queue .. " in the queue")
    test_command = commands.TURN_LEFT
    lunit.assert_equal(test_command, bm_queue, "Did not found the correct element in the queue")

    --Tests function bottomMenuEventHandler:update in BottomMenu when key is pressed with key = "3"
    test_event = event:new("3", "down") --simulates a key press on key 3
    bottomMenuEventHandler:update(bottommenu,nil,test_event)
    bm_queue = bottommenu.queue.actions[6]
    --print("Added " .. bm_queue .. " in the queue")
    test_command = commands.TURN_RIGHT
    lunit.assert_equal(test_command, bm_queue, "Did not found the correct element in the queue")

    --print("Commands added")
    -----------------------------------------------------------------------------------------------
     -- Added commands
    -----------------------------------------------------------------------------------------------

    -----------------------------------------------------------------------------------------------
     -- Creating PROCEDURE-action
    -----------------------------------------------------------------------------------------------
    --Tests function bottomMenuEventHandler:update in BottomMenu when key is pressed with key = "7"
    test_event = event:new("7", "down") --simulates a key press on key 7
    bottomMenuEventHandler:update(bottommenu,nil,test_event)
    bm_queue = bottommenu.queue.actions[7]
    --print("Added " .. bm_queue .. " in the queue")
    test_command = commands.P1
    lunit.assert_equal(test_command, bm_queue, "Did not found the correct element in the queue")

    --Tests function bottomMenuEventHandler:update in BottomMenu when key is pressed with key = "1"
    --Adding MOVE-action to procedure P1
    test_event = event:new("1", "down") --simulates a key press on key 1
    bottomMenuEventHandler:update(bottommenu,nil,test_event)
    bm_queue = bottommenu.queue.p1Actions[1]
    --print("Added " .. bm_queue .. " in the P1-queue")
    test_command = commands.MOVE
    lunit.assert_equal(test_command, bm_queue, "Did not found the correct element in the queue")

    --Tests function bottomMenuEventHandler:update in BottomMenu when key is pressed with key = "2"
    --Adding TURN_LEFT-action to procedure P1
    test_event = event:new("2", "down") --simulates a key press on key 2
    bottomMenuEventHandler:update(bottommenu,nil,test_event)
    bm_queue = bottommenu.queue.p1Actions[2]
    --print("Added " .. bm_queue .. " in the P1-queue")
    test_command = commands.TURN_LEFT
    lunit.assert_equal(test_command, bm_queue, "Did not found the correct element in the queue")

    --Tests function bottomMenuEventHandler:update in BottomMenu when key is pressed with key = "3"
    --Adding TURN_RIGHT-action to procedure P1
    test_event = event:new("3", "down") --simulates a key press on key 3
    bottomMenuEventHandler:update(bottommenu,nil,test_event)
    bm_queue = bottommenu.queue.p1Actions[3]
    --print("Added " .. bm_queue .. " in the P1-queue")
    test_command = commands.TURN_RIGHT
    lunit.assert_equal(test_command, bm_queue, "Did not found the correct element in the queue")

    --Exits the procedure-mode
    test_event = event:new("0", "down") --simulates a key press on key
    bottomMenuEventHandler:update(bottommenu,nil,test_event)

    --print("PROCEDURE-action created")
    -----------------------------------------------------------------------------------------------
     -- PROCEDURE-action created
    -----------------------------------------------------------------------------------------------

    -----------------------------------------------------------------------------------------------
     -- Adding some commands
    -----------------------------------------------------------------------------------------------
    --Tests function bottomMenuEventHandler:update in BottomMenu when key is pressed with key = "2"
    test_event = event:new("2", "down") --simulates a key press on key 2
    bottomMenuEventHandler:update(bottommenu,nil,test_event)
    bm_queue = bottommenu.queue.actions[8]
    --print("Added " .. bm_queue .. " in the queue")
    test_command = commands.TURN_LEFT
    lunit.assert_equal(test_command, bm_queue, "Did not found the correct element in the queue")

    --Tests function bottomMenuEventHandler:update in BottomMenu when key is pressed with key = "3"
    test_event = event:new("3", "down") --simulates a key press on key 3
    bottomMenuEventHandler:update(bottommenu,nil,test_event)
    bm_queue = bottommenu.queue.actions[9]
    --print("Added " .. bm_queue .. " in the queue")
    test_command = commands.TURN_RIGHT
    lunit.assert_equal(test_command, bm_queue, "Did not found the correct element in the queue")

    --print("Commands added")
    -----------------------------------------------------------------------------------------------
     -- Added commands
    -----------------------------------------------------------------------------------------------

    -----------------------------------------------------------------------------------------------
     -- Creating PROCEDURE-action
    -----------------------------------------------------------------------------------------------
    --Tests function bottomMenuEventHandler:update in BottomMenu when key is pressed with key = "7"
    test_event = event:new("8", "down") --simulates a key press on key 7
    bottomMenuEventHandler:update(bottommenu,nil,test_event)
    bm_queue = bottommenu.queue.actions[10]
    --print("Added " .. bm_queue .. " in the queue")
    test_command = commands.P2
    lunit.assert_equal(test_command, bm_queue, "Did not found the correct element in the queue")

    --Tests function bottomMenuEventHandler:update in BottomMenu when key is pressed with key = "1"
    --Adding MOVE-action to procedure P2
    test_event = event:new("1", "down") --simulates a key press on key 1
    bottomMenuEventHandler:update(bottommenu,nil,test_event)
    bm_queue = bottommenu.queue.p2Actions[1]
    --print("Added " .. bm_queue .. " in the P2-queue")
    test_command = commands.MOVE
    lunit.assert_equal(test_command, bm_queue, "Did not found the correct element in the queue")

    --Tests function bottomMenuEventHandler:update in BottomMenu when key is pressed with key = "2"
    --Adding TURN_LEFT-action to procedure P2
    test_event = event:new("2", "down") --simulates a key press on key 2
    bottomMenuEventHandler:update(bottommenu,nil,test_event)
    bm_queue = bottommenu.queue.p2Actions[2]
    --print("Added " .. bm_queue .. " in the P2-queue")
    test_command = commands.TURN_LEFT
    lunit.assert_equal(test_command, bm_queue, "Did not found the correct element in the queue")

    --Tests function bottomMenuEventHandler:update in BottomMenu when key is pressed with key = "3"
    --Adding TURN_RIGHT-action to procedure P2
    test_event = event:new("3", "down") --simulates a key press on key 3
    bottomMenuEventHandler:update(bottommenu,nil,test_event)
    bm_queue = bottommenu.queue.p2Actions[3]
    --print("Added " .. bm_queue .. " in the P2-queue")
    test_command = commands.TURN_RIGHT
    lunit.assert_equal(test_command, bm_queue, "Did not found the correct element in the queue")

    --Exits the procedure-mode
    test_event = event:new("0", "down") --simulates a key press on key
    bottomMenuEventHandler:update(bottommenu,nil,test_event)

    --print("PROCEDURE-action created")
    -----------------------------------------------------------------------------------------------
     -- PROCEDURE-action created
    -----------------------------------------------------------------------------------------------

    -----------------------------------------------------------------------------------------------
     -- Adding some commands
    -----------------------------------------------------------------------------------------------
    --Tests function bottomMenuEventHandler:update in BottomMenu when key is pressed with key = "2"
    test_event = event:new("2", "down") --simulates a key press on key 2
    bottomMenuEventHandler:update(bottommenu,nil,test_event)
    bm_queue = bottommenu.queue.actions[11]
    --print("Added " .. bm_queue .. " in the queue")
    test_command = commands.TURN_LEFT
    lunit.assert_equal(test_command, bm_queue, "Did not found the correct element in the queue")

    --Tests function bottomMenuEventHandler:update in BottomMenu when key is pressed with key = "3"
    test_event = event:new("3", "down") --simulates a key press on key 3
    bottomMenuEventHandler:update(bottommenu,nil,test_event)
    bm_queue = bottommenu.queue.actions[12]
    --print("Added " .. bm_queue .. " in the queue")
    test_command = commands.TURN_RIGHT
    lunit.assert_equal(test_command, bm_queue, "Did not found the correct element in the queue")

    --print("Commands added")
    -----------------------------------------------------------------------------------------------
     -- Added commands
    -----------------------------------------------------------------------------------------------

end

function test_delete()
    local levelData = require('games.Progg.levels.ProggLevels'):new()
    local leveldata = levelData:getProggLevels()
    local GameProgress = require('toolkit.GameProgress')

    local context_sim = {}
    context_sim.profile={}
    context_sim.profile.images={}
    context_sim.profile.images.UP='data/avatar/cute_robot/UP.png'
    context_sim.profile.images.DOWN='data/avatar/cute_robot/UP.png'
    context_sim.profile.images.RIGHT='data/avatar/cute_robot/UP.png'
    context_sim.profile.images.LEFT='data/avatar/cute_robot/UP.png'
    context_sim.profile.gameprogress = GameProgress:new("test_avatar")

    local test = require("games.Progg.BottomMenu")
    local commands = require('games.Progg.Commands')
    local bottommenu = test:new(leveldata[1],context_sim)
    local test_event
    local bm_queue
    local test_command

    -----------------------------------------------------------------------------------------------
     -- Adding some commands
    -----------------------------------------------------------------------------------------------
    --Tests function bottomMenuEventHandler:update in BottomMenu when key is pressed with key = "1"
    test_event = event:new("1", "down") --simulates a key press on key 1
    bottomMenuEventHandler:update(bottommenu,nil,test_event)
    bm_queue = bottommenu.queue.actions[1]
    --print("Added " .. bm_queue .. " in the queue")
    test_command = commands.MOVE
    lunit.assert_equal(test_command, bm_queue,  "Did not found the correct element in the queue")

    --Tests function bottomMenuEventHandler:update in BottomMenu when key is pressed with key = "2"
    test_event = event:new("2", "down") --simulates a key press on key 2
    bottomMenuEventHandler:update(bottommenu,nil,test_event)
    bm_queue = bottommenu.queue.actions[2]
    --print("Added " .. bm_queue .. " in the queue")
    test_command = commands.TURN_LEFT
    lunit.assert_equal(test_command, bm_queue, "Did not found the correct element in the queue")

    --Tests function bottomMenuEventHandler:update in BottomMenu when key is pressed with key = "3"
    test_event = event:new("3", "down") --simulates a key press on key 3
    bottomMenuEventHandler:update(bottommenu,nil,test_event)
    bm_queue = bottommenu.queue.actions[3]
    --print("Added " .. bm_queue .. " in the queue")
    test_command = commands.TURN_RIGHT
    lunit.assert_equal(test_command, bm_queue, "Did not found the correct element in the queue")

    --print("Commands added")
    -----------------------------------------------------------------------------------------------
     -- Added commands
    -----------------------------------------------------------------------------------------------

    bottommenu:deleteAction(1,"queue")
    local cmd_1 = bottommenu.queue.actions[1]
    local cmd_2 = bottommenu.queue.actions[2]

    lunit.assert_equal(commands.TURN_LEFT, cmd_1, "Not right command in position 1")
    lunit.assert_equal(commands.TURN_RIGHT, cmd_2, "Not right command in position 2")
end

function test_key_press()
    local levelData = require('games.Progg.levels.ProggLevels'):new()
    local leveldata = levelData:getProggLevels()
    local GameProgress = require('toolkit.GameProgress')

    local context_sim = {}
    context_sim.profile={}
    context_sim.profile.images={}
    context_sim.profile.images.UP='data/avatar/cute_robot/UP.png'
    context_sim.profile.images.DOWN='data/avatar/cute_robot/UP.png'
    context_sim.profile.images.RIGHT='data/avatar/cute_robot/UP.png'
    context_sim.profile.images.LEFT='data/avatar/cute_robot/UP.png'
    context_sim.profile.gameprogress = GameProgress:new("test_avatar")

    leveldata[4].mapData = "9acfffff5f3cffff5ff7ffff5fffffff7fffffff"

    local test = require("games.Progg.BottomMenu")
    local commands = require('games.Progg.Commands')
    local bottommenu = test:new(leveldata[4], context_sim)

    local test_event = event:new("1", "down")
    bottommenu.queue.loopActions = {{} }
    bottommenu.queue.loopPointer = 1
    bottommenu.inputArea = "loop"
    bottommenu.selectingLoopCounter=true
    bottomMenuEventHandler:update(bottommenu,nil,test_event)
    lunit.assert_equal(1, bottommenu.queue.loopCounter[1], "Key press not implies right action")

    local test_event = event:new("1", "down")
    bottommenu.selectingActionEdit=true
    bottomMenuEventHandler:update(bottommenu,nil,test_event)
    lunit.assert_true(bottommenu.isMovingAction == true, "Key press not implies right action")

    local test_event = event:new("2", "down")
    bottommenu.queue.loopActions = {{} }
    bottommenu.queue.loopPointer = 1
    bottommenu.inputArea ="loop"
    bottommenu.selectingLoopCounter=true
    bottomMenuEventHandler:update(bottommenu,nil,test_event)
    lunit.assert_true(bottommenu.queue.loopCounter[1] == 2, "Key press not implies right action")

    local test_event = event:new("2", "down")
    bottommenu.selectingActionEdit=true
    bottomMenuEventHandler:update(bottommenu,nil,test_event)
    lunit.assert_true(bottommenu.selectingActionEdit == nil, "Key press not implies right action")

    local test_event = event:new("3", "down")
    bottommenu.inputArea = "loop"
    bottommenu.selectingLoopCounter=true
    bottomMenuEventHandler:update(bottommenu,nil,test_event)
    lunit.assert_true(bottommenu.queue.loopCounter[1]==3, "Key press not implies right action")

    local test_event = event:new("3", "down")
    bottommenu.inputArea = "queue"
    bottommenu.selectingActionEdit = "loop"
    bottommenu.queue:push(Commands.LOOP, "queue")
    bottomMenuEventHandler:update(bottommenu,nil,test_event)
    lunit.assert_true(bottommenu.selectingActionEdit == nil, "Key press not implies right action")

    local test_event = event:new("3", "down")
    bottommenu.isMovingAction = true
    bottomMenuEventHandler:update(bottommenu,nil,test_event)
    lunit.assert_true(bottommenu.selectingActionEdit == nil, "Key press not implies right action")

    local test_event = event:new("4", "down")
    bottommenu.queue.loopActions = {{} }
    bottommenu.queue.loopPointer = 1
    bottommenu.inputArea ="loop"
    bottommenu.selectingLoopCounter=true
    bottomMenuEventHandler:update(bottommenu,nil,test_event)
    lunit.assert_true(bottommenu.queue.loopCounter[1] == 4, "Key press not implies right action")

    local test_event = event:new("5", "down")
    bottommenu.queue.loopActions = {{} }
    bottommenu.queue.loopPointer = 1
    bottommenu.inputArea ="loop"
    bottommenu.selectingLoopCounter=true
    bottomMenuEventHandler:update(bottommenu,nil,test_event)
    lunit.assert_true(bottommenu.queue.loopCounter[1] == 5, "Key press not implies right action")

    local test_event = event:new("6", "down")
    bottommenu.queue.loopActions = {{} }
    bottommenu.queue.loopPointer = 1
    bottommenu.inputArea ="loop"
    bottommenu.selectingLoopCounter=true
    bottomMenuEventHandler:update(bottommenu,nil,test_event)
    lunit.assert_true(bottommenu.queue.loopCounter[1] == 6, "Key press not implies right action")

    local test_event = event:new("6", "down")
    bottommenu.inputArea ="queue"
    bottommenu.selectingActionEdit = nil
    bottommenu.isMovingAction=false
    bottomMenuEventHandler:update(bottommenu,nil,test_event)
    lunit.assert_true(bottommenu.inputArea == "loop", "Key press not implies right action")

    local test_event = event:new("9", "down")
    bottommenu.queue.loopActions = {{} }
    bottommenu.queue.loopCounter = {}
    bottommenu.queue.loopPointer = 1
    bottommenu.inputArea ="loop"
    bottommenu.selectingLoopCounter=true
    bottomMenuEventHandler:update(bottommenu,nil,test_event)
    lunit.assert_equal(9, bottommenu.queue.loopCounter[1], "Key press not implies right action")

    local test_event = event:new("up", "down")
    bottommenu.position = 9 --is not upper row
    bottommenu.selectingActionEdit =nil
    bottomMenuEventHandler:update(bottommenu,nil,test_event)
    lunit.assert_true(bottommenu.prevPosition == 9, "Key press not implies right action")
    lunit.assert_true(bottommenu.position==1, "Key press not implies right action")

    local test_event = event:new("down", "down")
    bottommenu.position = 1
    bottommenu.selectingActionEdit =nil
    bottomMenuEventHandler:update(bottommenu,nil,test_event)
    lunit.assert_true(bottommenu.prevPosition == 1, "Key press not implies right action")
    lunit.assert_true(bottommenu.position==9, "Key press not implies right action")

    local test_event = event:new("left", "down")
    bottommenu.position = 3
    bottommenu.selectingActionEdit =nil
    bottomMenuEventHandler:update(bottommenu,nil,test_event)
    lunit.assert_true(bottommenu.prevPosition == 3, "Key press not implies right action")
    lunit.assert_true(bottommenu.position==2, "Key press not implies right action")

    local test_event = event:new("right", "down")
    bottommenu.position = 3
    bottommenu.selectingActionEdit =nil
    bottomMenuEventHandler:update(bottommenu,nil,test_event)
    lunit.assert_true(bottommenu.prevPosition == 3, "Key press not implies right action")
    lunit.assert_true(bottommenu.position==4, "Key press not implies right action")

    local test_event = event:new("ok", "down")
    bottommenu.isMovingAction = true
    bottomMenuEventHandler:update(bottommenu,nil,test_event)
    lunit.assert_true(bottommenu.isMovingAction == false, "Key press not implies right action")

--    local test_event = event:new("backspace", "down")
--    bottomMenuEventHandler:update(bottommenu,nil,test_event)
--    lunit.assert_true(bottommenu.context.game==nil, "Key press not implies right action")

end




