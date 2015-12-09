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
-- User: Lena
-- Date: 2015-11-20
-- Time: 10:50
-- To change this template use File | Settings | File Templates.
--


lunit = require "lunit"
module( "inttest_id_9", package.seeall, lunit.testcase )
--local event = require ("toolkit.Event")

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
function setup()
    clear_mock()
end

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