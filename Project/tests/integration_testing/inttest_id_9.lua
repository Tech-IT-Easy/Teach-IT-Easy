--
-- Created by IntelliJ IDEA.
-- User: Lena
-- Date: 2015-11-20
-- Time: 10:50
-- To change this template use File | Settings | File Templates.
--


lunit = require "lunit"
module( "inttest_id_9", package.seeall, lunit.testcase )
local event = require ("toolkit.Event")

local SUT1 = 'games.Progg.BuildArea'
local SUT2 = 'games.Progg.DrawBuildArea'

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


-- Test if what is built in Build Area is drawed correctly

function test_loop_drawing ()
    local build = require("games.Progg.BuildArea")
    local drawbuild = require("games.Progg.DrawBuildArea")
    local buildarea = build:new(10, 17)
    local queue = {"move", "turn-right", "turn-left"}
    buildarea:setQueue(queue, "loop")
    buildarea:showqueue(queue)
    drawbuild:getFileName(queue)

end
--Test if character moved according to the added procedure
function test_execute_queue_3()
    local test = require("games.Progg.BottomMenu")
    local commands = require('games.Progg.Commands')
    local bottommenu = test:new(16,nil)
    local test_event
    local bm_queue
    local test_command

-----------------------------------------------------------------------------------------------
     -- Creating PROCEDURE-action
    -----------------------------------------------------------------------------------------------
    --Tests function bottomMenuEventHandler:update in BottomMenu when key is pressed with key = "7"
    test_event = event:new("7", "down") --simulates a key press on key 7
    bottomMenuEventHandler:update(bottommenu,nil,test_event)
    bm_queue = bottommenu.queue.actions[1]
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

    --Test if character moved according to the added commands
    test_event = event:new("0", "down") --simulates a key press on key 0
    bottomMenuEventHandler:update(bottommenu,nil,test_event)
    local pos_X = bottommenu.character.position:getX()
    local pos_Y=bottommenu.character.position:getY()
    lunit.assert_equal(1,pos_X ,"Did not move to the right x-coordinate")
    lunit.assert_equal(4,pos_Y ,"Did not move to the right x-coordinate")
end



