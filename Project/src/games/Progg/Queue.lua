------------------------------
--The queue that contains the actions the player wants to take.
--Allows others to push things to the queue, remove last (pop),
--change place of something in the queue(setPosition) and create a new queue.
------------------------------
local Object = require('toolkit.Object')

Queue = extends(Object.class())
local executionQueue = nil

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
--Used when the actions in the queue should be executed.
--It will probably send one action each time it's called,
--the one that was added first
--------------------------------------------------------
function Queue:execute()
  ---------------
  --code
  ---------------
  if executionQueue == nil then
    for _,obj in pairs(self.actions) do
      table.insert(executionQueue, table.remove(self.actions))
    end
  end

  return table.remove(executionQueue)

end

return Queue