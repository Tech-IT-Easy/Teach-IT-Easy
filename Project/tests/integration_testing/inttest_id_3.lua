--
-- Created by IntelliJ IDEA.
-- User: Andreas Mansson
-- Date: 2015-11-16
-- Time: 22:45
-- To change this template use File | Settings | File Templates.
--

lunit = require "lunit"
module( "test_id_3", package.seeall, lunit.testcase )
local event = require ("src.toolkit.Event")

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
  package.loaded['src.games.Progg.Queue'] = nil
  package.preload['src.games.Progg.Queue'] = nil
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
--    local event = require "src.toolkit.Event"
--    event.key = event.KEY_ONE
--
--    local a = ps1:new(event)
--    -- a.command = a.MOVE
--    -- SUT1 =  'src.games.Progg.Queue'
--    -- SUT2 =  'src.games.Progg.Commands'
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

function test_test()
    local test = require("games.Progg.BottomMenu")
    local a = test:new(16,nil)

    local b = event:new("1", "down")
    bottomMenuEventHandler:update(a,nil,b)
    local cc = a.queue.actions[1]
    print(cc)
    lunit.assert_equal(a, c1, "Did not found the correct element in the queue")
end

