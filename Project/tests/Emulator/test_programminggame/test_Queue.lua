--
-- Created by IntelliJ IDEA.
-- User: Lena
-- Date: 2015-11-04
-- Time: 11:22
-- To change this template use File | Settings | File Templates.
--
lunit = require "lunit"
module( "test_selectAction", package.seeall, lunit.testcase )

require "source.model.command.Queue" -- import the Queue class


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

function test_delete()
  --cmdlist = CommandQueue:new()
  --leftcmd = LeftCommand:new()
  --rightcmd = RightCommand:new()
  --forwardcmd = ForwardCommand:new()
  --loopcmd = LoopCommand:new()
  --procedurecmd = ProcedureCommand:new()
  --ifcmd = IfCommand:new()

  --cmdlist:add(leftcmd)
  --cmdlist:add(rightcmd)
  --cmdlist:add(forwardcmd)
  --cmdlist:add(loopcmd)
  --cmdlist:add(procedurecmd)
  --cmdlist:add(ifcmd)

  --assert_equal(forwardcmd, cmdlist:delete(3), "Should have deleted " .. forwardcmd .. ", but did remove" .. cmdlist:delete(3) .."instead")
end

function test_execute()
end
