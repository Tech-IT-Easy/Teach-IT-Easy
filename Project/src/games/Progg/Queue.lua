-------------------------------------------------------------------
--This is not using the toolkit.Object, instead it implements it's own OOP. But it works^^
-------------------------------------------------------------------

local Queue = {}

function Queue:new()
  local newObj = {actions = {}}
  self.__index = self
  return setmetatable(newObj, self)
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


----------------------------------------
--Returns a queue in reversed order, so that another part of the program can use pop to
--go through it in execution order.
--Added a function next() to the returned queue just because it's an intuitive name.
----------------------------------------
function Queue:getExecutionQueue()
  local executionQueue = self:new()
  for i = 1, #self.actions do
      table.insert(executionQueue.actions, i, self.actions[#self.actions - i + 1])
  end
  return executionQueue
end

return Queue