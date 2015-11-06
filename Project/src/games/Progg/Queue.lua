------------------------------
--The queue that contains the actions the player wants to take.
--Allows others to push things to the queue, remove last (pop),
--change place of something in the queue(setPosition) and create a new queue.
------------------------------
local Object = require('toolkit.Object')

Queue = extends(Object.class())

-------------------------------------
--Constructor creates a new instance of a queue, can take any objects
--but is meant to store actions/commands
------------------------------------
function Queue:new()
  self.actions = {}
  return self.class()
end

-------------------------------------
--Adds something at the end of the queue
-------------------------------------
function Queue:push(action)
  table.insert(self.actions,action)
end

--------------------------------------
--Removes the object in the queue that was added last
--------------------------------------
function Queue:pop()
  return table.remove(self.actions)
end
----------------------------------------------------------------
--Allows someone to switch positions for two objects in the queue
----------------------------------------------------------------
function Queue:setPosition(currentPos, goalPos)
---------------
--code
---------------
end

--------------------------------------------------------
-- This required keeping two copies of the queue in the queue and having functions for both.
-- Instead use getExecutionQueue to create a new queue instance in revesed order.
--
--OLD!: Used when the actions in the queue should be executed.
--It will probably send one action each time it's called,
--the one that was added first.
--------------------------------------------------------
--[[
function Queue:execute()

  if self.executionQueue == nil then
    for i = 1, #self.actions do
      table.insert(self.executionQueue, i, self.actions[#self.actions - i])
    end
  end

  return table.remove(self.executionQueue)
end
--]]


----------------------------------------
--Returns a queue in reversed order, so that another part of the program can use pop to
--go through it in execution order.
--Added a function next() to the returned queue just because it's an intuitive name.
----------------------------------------
function Queue:getExecutionQueue()
  local executionQueue = self:new()
  for i = 1, #self.actions do
      table.insert(executionQueue.actions, i, self.actions[#self.actions - i])
  end

  --Just pop() with a new name
  --function executionQueue:next() return table.remove(self) end

  return executionQueue
end

return Queue