--
-- Created by IntelliJ IDEA.
-- User: Andreas Mansson
-- Date: 2015-11-04
-- Time: 20:03
-- To change this template use File | Settings | File Templates.
--

lunit = require "lunit"
module( "test_selectAction", package.seeall, lunit.testcase )

local SUT = 'src.games.Progg.Queue'
--require "source.model.command.Queue" -- import the Queue class


---------------------------------------------------------------
-- Tests for functions of class Queue in Software Architecture
-- Tests corresponds to UC06 in SRS
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

-- Tests if an object can be added to the queue
function test_push_1()
  local a = require(SUT)
  local queuelist = a:new()
  local queuecmd_1 = "Command_1"

  --Add object 'queuecmd_1' to the queue 'queuelist'
  if pcall(queuelist:push(), queuecmd_1) then
    lunit.fail("Could not push an object to the queue")
  end

end

-- Tests if objects added to the queue are added correctly
function test_push_2()
  local a = require(SUT)
  local queuelist = a:new()
  local queuecmd_1 = "Command_1"
  local queuecmd_2 = "Command_2"

  -- Pushes two items to the queue
  queuelist:push(queuecmd_1)
  queuelist:push(queuecmd_2)

  -- Get the added objects from queue
  local c1 = queuelist.actions[1]
  local c2 = queuelist.actions[2]

  lunit.assert_equal(queuecmd_2, c2, "Did not found the correct element in the queue")
  lunit.assert_equal(queuecmd_1, c1, "Did not found the correct element in the queue")
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

