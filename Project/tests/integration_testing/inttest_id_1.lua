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
-- Date: 2015-11-12
-- Time: 12:28
-- To change this template use File | Settings | File Templates.
--

lunit = require "lunit"
module( "inttest_id_1", package.seeall, lunit.testcase )

local SUT_1 = 'games.Progg.Queue'
local SUT_2 = 'games.Progg.Commands'

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
-- Test if commands can be added to the queue, in the right order
-- @system_under_test: Queue:push(action, queueType), Commands
-- @author name: Andreas
-------------------------------------
function test_command_queue()
    local a = require(SUT_1)
    local b = require(SUT_2)

    local queue = a:new(nil, nil, {["queue"] = 16, ["loop"] = 11, ["P1"] = 13, ["P2"] = 16 })
    local commands = b:new()

--    local command1=commands.MOVE
--    local queue_cmd1 = commands:new(command1)
--
--    local command2=commands.MOVE
--    local queue_cmd2 = commands:new(command2)
--
--    local command3=commands.TURN_LEFT
--    local queue_cmd3 = commands:new(command3)
--
--    local command4=commands.TURN_RIGHT
--    local queue_cmd4 = commands:new(command4)
--
--    local command5=commands.LOOP
--    local queue_cmd5 = commands:new(command5)
--
--    local command5=commands.LOOP
--    local queue_cmd5 = commands:new(command5)

    --local addedcommands={}

    queue:push(commands.MOVE, "queue")
    lunit.assert_equal(commands.MOVE, queue.actions[1], "Did not get the right value from the queue")

    queue:push(commands.MOVE, "queue")
    lunit.assert_equal(commands.MOVE, queue.actions[2], "Did not get the right value from the queue")

    queue:push(commands.TURN_LEFT, "queue")
    lunit.assert_equal(commands.TURN_LEFT, queue.actions[3], "Did not get the right value from the queue")

    queue:push(commands.TURN_RIGHT, "queue")
    lunit.assert_equal(commands.TURN_RIGHT, queue.actions[4], "Did not get the right value from the queue")

    queue:push(commands.LOOP, "queue")
    lunit.assert_equal(commands.LOOP, queue.actions[5], "Did not get the right value from the queue")

    queue:push(commands.MOVE, "loop")
    lunit.assert_equal(commands.MOVE, queue.loopActions[1][1], "Did not get the right value from the queue")

    queue:push(commands.MOVE, "loop")
    lunit.assert_equal(commands.MOVE, queue.loopActions[1][2], "Did not get the right value from the queue")

    queue:push(commands.TURN_LEFT, "loop")
    lunit.assert_equal(commands.TURN_LEFT, queue.loopActions[1][3], "Did not get the right value from the queue")

    queue:push(commands.TURN_RIGHT, "loop")
    lunit.assert_equal(commands.TURN_RIGHT, queue.loopActions[1][4], "Did not get the right value from the queue")

    queue:push(commands.MOVE, "queue")
    lunit.assert_equal(commands.MOVE, queue.actions[6], "Did not get the right value from the queue")

    queue:push(commands.P1, "queue")
    lunit.assert_equal(commands.P1, queue.actions[7], "Did not get the right value from the queue")

    queue:push(commands.MOVE, "P1")
    lunit.assert_equal(commands.MOVE, queue.p1Actions[1], "Did not get the right value from the queue")

    queue:push(commands.MOVE, "P1")
    lunit.assert_equal(commands.MOVE, queue.p1Actions[2], "Did not get the right value from the queue")

    queue:push(commands.TURN_LEFT, "P1")
    lunit.assert_equal(commands.TURN_LEFT, queue.p1Actions[3], "Did not get the right value from the queue")

    queue:push(commands.TURN_RIGHT, "P1")
    lunit.assert_equal(commands.TURN_RIGHT, queue.p1Actions[4], "Did not get the right value from the queue")

    queue:push(commands.P2, "queue")
    lunit.assert_equal(commands.P1, queue.actions[7], "Did not get the right value from the queue")

    queue:push(commands.MOVE, "P2")
    lunit.assert_equal(commands.MOVE, queue.p2Actions[1], "Did not get the right value from the queue")

    queue:push(commands.MOVE, "P2")
    lunit.assert_equal(commands.MOVE, queue.p2Actions[2], "Did not get the right value from the queue")

    queue:push(commands.TURN_LEFT, "P2")
    lunit.assert_equal(commands.TURN_LEFT, queue.p2Actions[3], "Did not get the right value from the queue")

    queue:push(commands.TURN_RIGHT, "P2")
    lunit.assert_equal(commands.TURN_RIGHT, queue.p2Actions[4], "Did not get the right value from the queue")

end
