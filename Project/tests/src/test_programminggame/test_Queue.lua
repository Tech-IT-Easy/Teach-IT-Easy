--
-- Created by IntelliJ IDEA.
-- User: Lena
-- Date: 2015-11-04
-- Time: 11:22
-- To change this template use File | Settings | File Templates.
--

lunit = require "lunit"
module( "test_Queue", package.seeall, lunit.testcase )

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
-- Function 5. setPosition()
-- >> Description: allows someone to switch positions for two objects in the queue
-- >> Input: -
-- >> Output: -
-- Function 6. empty()
-- >> Description: checks if queue is empty
-- >> Input: -
-- >> Output: -

-- -------------------------------------------------------------


-- Tests if an object can be added to the queue
function test_push_1()
  local a = require(SUT)
  local queuelist = a:new(nil)
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
  queuelist:push(queuecmd_1, "queue")
  queuelist:push(queuecmd_2, "queue")

  -- Get the added objects from queue
  local c1 = queuelist.actions[1]
  local c2 = queuelist.actions[2]

  lunit.assert_equal(queuecmd_2, c2, "Did not found the correct element in the queue")
  lunit.assert_equal(queuecmd_1, c1, "Did not found the correct element in the queue")
end

-- Tests if the element last added can be deleted, presumes that add() functions works in adding element, as it is tested above
function test_delete()
    local queuelist = require(SUT):new()
    local queuecmd_1 = "Command_1"
    local queuecmd_2 = "Command_2"

    queuelist:push(queuecmd_1, "queue")
    queuelist:push(queuecmd_2, "queue")


    queuelist:pop()

    lunit.assert_equal(queuecmd_1, queuelist.actions[1], "Did not have the expected element in list")
    lunit.assert_equal(nil, queuelist.actions[2], "Did not remove the expected element in list")

end

-- Tests if elements in queue can be collected from first element to last
function test_execute()
    local queuelist = require(SUT):new()
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

-- Tests if two object can swap places in the queue
function test_SetPos()
    local a = require(SUT)
    local queuelist = a:new()
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

