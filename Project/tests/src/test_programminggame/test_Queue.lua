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
-- Date: 2015-11-04
-- Time: 11:22
-- To change this template use File | Settings | File Templates.
--

lunit = require "lunit"
module( "test_Queue", package.seeall, lunit.testcase )

local SUT = 'games.Progg.Queue'


-------------------------------------
-- Tests if an object can be added to the queue
-- @system_under_test: Queue:new(), Queue:push(action)
-- @author name: ??
-------------------------------------

function test_push_1()
  local a = require(SUT)
  local queuelist = a:new(nil)
  local queuecmd_1 = "Command_1"

  --Add object 'queuecmd_1' to the queue 'queuelist'
  if pcall(queuelist:push(), queuecmd_1) then
    lunit.fail("Could not push an object to the queue")
  end

end

-------------------------------------
-- Tests if objects added to the queue are added correctly
-- @system_under_test: Queue:new(), Queue:push(action)
-- @author name: ??
-------------------------------------

function test_push_2()
  local a = require(SUT)
  local queuelist = a:new()
  queuelist.maxCommands = {["queue"] = 16, ["loop"] = 11, ["P1"] = 13, ["P2"] = 16 }--FIXME
  local queuecmd_1 = "Command_1"
  local queuecmd_2 = "Command_2"

  -- Pushes two items to the queue
  queuelist:push(queuecmd_1, "queue")
  queuelist:push(queuecmd_2, "queue")

  -- Get the added objects from queue
  local c1 = queuelist.actions[1]
  local c2 = queuelist.actions[2]

  lunit.assert_equal(queuecmd_2, c2, "Did not found the correct element in the queue")
  lunit.assert_equal(queuecmd_1, c1, "Did not found the correct element in the queue")
end

-------------------------------------
-- Tests if the element last added can be deleted, presumes that add() functions works in adding element, as it is tested above
-- @system_under_test: Queue:new(), Queue:push(action), Queue:pop()
-- @author name: ??
-------------------------------------

function test_delete()
    local queuelist = require(SUT):new()
    queuelist.maxCommands = {["queue"] = 16, ["loop"] = 11, ["P1"] = 13, ["P2"] = 16 }--FIXME
    local queuecmd_1 = "Command_1"
    local queuecmd_2 = "Command_2"

    queuelist:push(queuecmd_1, "queue")
    queuelist:push(queuecmd_2, "queue")


    queuelist:pop()

    lunit.assert_equal(queuecmd_1, queuelist.actions[1], "Did not have the expected element in list")
    lunit.assert_equal(nil, queuelist.actions[2], "Did not remove the expected element in list")

end

-------------------------------------
-- Tests if elements in queue can be collected from first element to last
-- @system_under_test: Queue:new(), Queue:push(action), Queue:pop(), Queue:getExecutionQueue(),
-- @author name: ??
-------------------------------------

function test_execute()
    local queuelist = require(SUT):new()
    queuelist.maxCommands = {["queue"] = 16, ["loop"] = 11, ["P1"] = 13, ["P2"] = 16 }--FIXME
    local queuecmd_1 = "Command_1"
    local queuecmd_2 = "Command_2"
    local queuecmd_3 = "Command_3"
    queuelist:push(queuecmd_1, "queue")
    queuelist:push(queuecmd_2, "queue")
    queuelist:push(queuecmd_3, "queue")

    -- Uncomment when execute() is implemented in Queue class
    local executedqueue = queuelist:getExecutionQueue()

    local expectedelements = {queuecmd_1,queuecmd_2,queuecmd_3}

     --Uncomment when execute() is implemented in Queue class
    local i = 1
    while not(i<=3) do
        assert_equal(executedqueue:pop(), expectedelements[i], "Did not find the expected element in queue")
        i = i + 1
    end
    lunit.assert_equal(3, #queuelist.actions, "Original queue should not be affected by changes in execution queue")


end

-------------------------------------
-- Tests if two object can swap places in the queue
-- @system_under_test: Queue:new(), Queue:push(action), Queue:setPosition(currentPos, goalPos)
-- @author name: ??
-------------------------------------

function test_SetPos()
    local a = require(SUT)
    local queuelist = a:new()
    queuelist.maxCommands = {["queue"] = 16, ["loop"] = 11, ["P1"] = 13, ["P2"] = 16 }--FIXME
    local queuecmd_1 = "Command_1"
    local queuecmd_2 = "Command_2"

    -- Pushes two items to the queue
    queuelist:push(queuecmd_1, "queue")
    queuelist:push(queuecmd_2, "queue")

    -- Swap place of the two objects
    queuelist:setPosition(1,2)

    local index_1 = queuelist.actions[1]
    local index_2 = queuelist.actions[2]

    -- Uncomment when setPosition is implemented in Queue class
     lunit.assert_equal(index_1,queuecmd_2,"This index does not contains the correct object")
     lunit.assert_equal(index_2,queuecmd_1,"This index does not contains the correct object")

    --lunit.fail("Function setPosition() is not implemented yet!")
end

