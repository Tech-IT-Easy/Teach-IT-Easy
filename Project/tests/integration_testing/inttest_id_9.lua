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
local SUT3 = 'games.Progg.BottomMenu'

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

-------------------------------------
-- Test if what is built in BuildArea is drawed correctly from DrawBuildArea, if it is a loop
-- @system_under_test: BuildArea:new(maxCommands, pos), DrawBuildArea:getFileName(action)
-- @author name: Lena
-------------------------------------

function test_loop_drawing ()
    local a = require(SUT1)
    local b = require(SUT1)

    local bottomMenu = b:new(10, "context")

    local buildArea = a:new(10, 1)
    local queue = {"move", "turn-right", "turn-left" }

    buildArea:setQueue(queue, "loop")

    lunit.assert_equal(buildArea.drawBuildArea:getFileName(buildArea.loopQueue[1]), "data/progg_game_icons/arrow_up.png", "Did not draw the correct action from the queue")
    lunit.assert_equal(buildArea.drawBuildArea:getFileName(buildArea.loopQueue[2]), "data/progg_game_icons/turn_right.png", "Did not draw the correct action from the queue")
    lunit.assert_equal(buildArea.drawBuildArea:getFileName(buildArea.loopQueue[3]), "data/progg_game_icons/turn_left.png", "Did not draw the correct action from the queue")

end

-------------------------------------
-- Test if what is built in BuildArea is drawed correctly from DrawBuildArea, if it is a procedure 1
-- @system_under_test: BuildArea:new(maxCommands, pos), DrawBuildArea:getFileName(action)
-- @author name: Lena
-------------------------------------

function test_p1_drawing ()
    local a = require(SUT1)

    local buildArea = a:new(10, 1)
    local queue = {"move", "turn-right", "turn-left" }

    buildArea:setQueue(queue, "P1")

    lunit.assert_equal(buildArea.drawBuildArea:getFileName(buildArea.p1Queue[1]), "data/progg_game_icons/arrow_up.png", "Did not draw the correct action from the queue")
    lunit.assert_equal(buildArea.drawBuildArea:getFileName(buildArea.p1Queue[2]), "data/progg_game_icons/turn_right.png", "Did not draw the correct action from the queue")
    lunit.assert_equal(buildArea.drawBuildArea:getFileName(buildArea.p1Queue[3]), "data/progg_game_icons/turn_left.png", "Did not draw the correct action from the queue")

end

-------------------------------------
-- Test if what is built in BuildArea is drawed correctly from DrawBuildArea, if it is a procedure 2
-- @system_under_test: BuildArea:new(maxCommands, pos), DrawBuildArea:getFileName(action)
-- @author name: Lena
-------------------------------------

function test_p2_drawing ()
    local a = require(SUT1)

    local buildArea = a:new(10, 1)
    local queue = {"move", "turn-right", "turn-left" }

    buildArea:setQueue(queue, "P2")

    lunit.assert_equal(buildArea.drawBuildArea:getFileName(buildArea.p2Queue[1]), "data/progg_game_icons/arrow_up.png", "Did not draw the correct action from the queue")
    lunit.assert_equal(buildArea.drawBuildArea:getFileName(buildArea.p2Queue[2]), "data/progg_game_icons/turn_right.png", "Did not draw the correct action from the queue")
    lunit.assert_equal(buildArea.drawBuildArea:getFileName(buildArea.p2Queue[3]), "data/progg_game_icons/turn_left.png", "Did not draw the correct action from the queue")

end