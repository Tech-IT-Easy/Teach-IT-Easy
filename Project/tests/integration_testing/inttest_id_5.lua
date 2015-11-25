--
-- Created by IntelliJ IDEA.
-- User: Andreas Mansson
-- Date: 2015-11-19
-- Time: 14:08
-- To change this template use File | Settings | File Templates.
--


lunit = require "lunit"
module( "inttest_id_5", package.seeall, lunit.testcase )
local event = require ("toolkit.Event")

local SUT1 = 'games.Progg.Commands'
local SUT2 = 'games.Progg.BuildArea'
local SUT3 = 'games.Progg.Character'
local SUT4 = 'games.Progg.Queue'

--Corresponds to function bottomMenuEventHandler:update(object,eventListener,event)
--in BottomMenu

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
  package.loaded['games.Progg.Queue'] = nil
  package.preload['games.Progg.Queue'] = nil
end


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


--Test if character moved according to the added loop
function test_execute_queue_2()
    local test = require("games.Progg.BottomMenu")
    local commands = require('games.Progg.Commands')
    local bottommenu = test:new({["queue"] = 16, ["loop"] = 11, ["P1"] = 13, ["P2"] = 16 },nil)
    local test_event
    local bm_queue
    local test_command

    -----------------------------------------------------------------------------------------------
     -- Creating LOOP-action
    -----------------------------------------------------------------------------------------------
    --Tests function bottomMenuEventHandler:update in BottomMenu when key is pressed with key = "6"
    test_event = event:new("6", "down") --simulates a key press on key 6
    bottomMenuEventHandler:update(bottommenu,nil,test_event)
    bm_queue = bottommenu.queue.actions[1] --NEED TO CHANGE THIS TO 6 WHEN CODE ABOVE IS UNCOMMENTED!
    --print("Added " .. bm_queue .. " in the queue")
    test_command = commands.LOOP
    lunit.assert_equal(test_command, bm_queue, "Did not found the correct element in the queue")

    --Select number of iteration. Selects 5 iterations in this case.
    test_event = event:new("5", "down") --simulates a key press on key 6
    bottomMenuEventHandler:update(bottommenu,nil,test_event)
    local loopCounter = bottommenu.queue.loopCounter
    --print("Number of iterations: " .. loopCounter)
    lunit.assert_equal(5, loopCounter, "Not correct number of iterations")

    --Tests function bottomMenuEventHandler:update in BottomMenu when key is pressed with key = "1"
    --Adding MOVE-action to loop
    test_event = event:new("1", "down") --simulates a key press on key 1
    bottomMenuEventHandler:update(bottommenu,nil,test_event)
    bm_queue = bottommenu.queue.loopActions[1]
    --print("Added " .. bm_queue .. " in the loop-queue")
    test_command = commands.MOVE
    lunit.assert_equal(test_command, bm_queue, "Did not found the correct element in the queue")

    --Tests function bottomMenuEventHandler:update in BottomMenu when key is pressed with key = "2"
    --Adding TURN_LEFT-action to loop
    test_event = event:new("2", "down") --simulates a key press on key 2
    bottomMenuEventHandler:update(bottommenu,nil,test_event)
    bm_queue = bottommenu.queue.loopActions[2]
    --print("Added " .. bm_queue .. " in the loop-queue")
    test_command = commands.TURN_LEFT
    lunit.assert_equal(test_command, bm_queue, "Did not found the correct element in the queue")

    --Tests function bottomMenuEventHandler:update in BottomMenu when key is pressed with key = "3"
    --Adding TURN_RIGHT-action to loop
    test_event = event:new("3", "down") --simulates a key press on key 3
    bottomMenuEventHandler:update(bottommenu,nil,test_event)
    bm_queue = bottommenu.queue.loopActions[3]
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

    --Test if character moved according to the added commands
    test_event = event:new("0", "down") --simulates a key press on key 0
    bottomMenuEventHandler:update(bottommenu,nil,test_event)
    local pos_X = bottommenu.character.position.x
    local pos_Y=bottommenu.character.position.y
    lunit.assert_equal(1,pos_X ,"Did not move to the right x-coordinate")
    lunit.assert_equal(5,pos_Y ,"Did not move to the right x-coordinate")
end