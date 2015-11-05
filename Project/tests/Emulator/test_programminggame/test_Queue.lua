--
-- Created by IntelliJ IDEA.
-- User: Lena
-- Date: 2015-11-04
-- Time: 11:22
-- To change this template use File | Settings | File Templates.
--
lunit = require "lunit"
module( "test_selectAction", package.seeall, lunit.testcase )

local SUT = 'src.games.Progg.Queue' -- import the Queue class


---------------------------------------------------------------
-- Tests for class Queue
-- Tests for UC06
---------------------------------------------------------------

-- ------------Required classes and functions------------------

-- Class Queue:
-- Function 1. new()
-- >> Description: creates a new CommandQueue
-- >> Input: -
-- >> Output: -
-- Function 2. push()
-- >> Description: adds a new command object into the queue.
-- >> Input: -
-- >> Output: -
-- Function 3. pop()
-- >> Description: delete next command object in the queue.
-- >> Input: -
-- >> Output: -
-- Function 4. execute()
-- >> Description: iterates over queue and returns the Command objects in it
-- >> Input: -
-- >> Output: -
-- Function 5. empty()
-- >> Description: checks if queue is empty
-- >> Input: -
-- >> Output: -

-- -------------------------------------------------------------
function test_add()
    queuelist = Queue:new()
    queuecmd_1 = "Command_1"
    queuecmd_2 = "Command_2"

    commands = {queuecmd_1,queuecmd_2}

    queuelist:push(queuecmd_1)
    queuelist:push(queuecmd_2)

    assert_equal() ---how to do this??? mock?
end

function test_delete() --if test_add() fails this will fail as well
    local queuelist = require(SUT):new()
    local queuecmd_1 = "Command_1"
    local queuecmd_2 = "Command_2"
    local queuecmd_3 = "Command_3"

    queuelist:push(queuecmd_1)
    queuelist:push(queuecmd_2)
    queuelist:push(queuecmd_3)

    queuelist:pop()

    expectedcommands = {queuecmd_1, queuecmd_2}

    assert_equal(expectedcommands[1], queuelist.actions[1], "Was supposed to be " .. expectedcommands[1] .. ", but was not")
    assert_equal(expectedcommands[2], queuelist.actions[2], "Was supposed to be " .. expectedcommands[1] .. ", but was not")

end

function test_execute()
end
