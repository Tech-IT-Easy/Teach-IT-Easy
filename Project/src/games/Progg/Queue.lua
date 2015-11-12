-------------------------------------------------------------------
--This is not using the toolkit.Object, instead it implements it's own OOP. But it works^^
-------------------------------------------------------------------

local Queue = {}

function Queue:new(newBottomMenu, newBuildArea)
  self.bottomMenu = newBottomMenu
  self.buildArea = newBuildArea
  local newObj = {actions = {}, loopActions = {}, p1Actions = {}, p2Actions = {}}
  self.__index = self
  return setmetatable(newObj, self)
end


-------------------------------------
--Adds something at the end of the queue
-------------------------------------
function Queue:push(action, queueType)

  if queueType == "queue" then
    table.insert(self.actions,action)
    self.bottomMenu:setQueue(self.actions)
  elseif queueType == "loop" then
    table.insert(self.loopActions,action)
    self.buildArea:setQueue(self.loopActions, queueType)
  elseif queueType == "P1" then
    table.insert(self.p1Actions,action)
    self.buildArea:setQueue(self.p1Actions, queueType)
  elseif queueType == "P2" then
    table.insert(self.p2,action)
    self.buildArea:setQueue(self.p2Actions, queueType)
  end
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
  self.actions[currentPos], self.actions[goalPos] = self.actions[goalPos], self.actions[currentPos]
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