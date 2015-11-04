------------------------------
--The queue that contains the actions the player wants to take.
--Allows others to add things to the queue, remove last (pop),
--change place of something in the queue(setPosition) and create a new queue.
------------------------------
local Object = require('toolkit.Object')

Queue = extends(Object.class())

--I don't yet know the difference between creating this as a local 
--table or creating it as self.actions in the constructor
--local actions = {}

--Creates a new instance of a queue, can take any objects
function Queue:new()
  self.actions = {}
  return self.class()
end

--Adds something at the end of the queue
function Queue:add(action)
  table.insert(self.actions,action)
end

--Removes the object in the queue that was added last
function Queue:pop()
  return table.remove(self.actions)
end

function Queue:setPosition(currentPos, goalPos)
---------------
--code
---------------
end


return Queue