-------------------------------------------------------------------
--This is not using the toolkit.Object, instead it implements it's own OOP. But it works^^
-------------------------------------------------------------------

local Queue = {}

---------------------------------------------------------------
-- Constructor for the Queue
-- @param newBottomMenu,newBuildArea. The places where the queue is drawn.
-- @return a new queue instance
-- @author Ludwig Wikblad
----------------------------------------------------------------
function Queue:new(newBottomMenu, newBuildArea)
  if newBottomMenu ~= nil then self.bottomMenu = newBottomMenu end
  if newBuildArea ~= nil then self.buildArea = newBuildArea end
  local newObj = {actions = {}, loopActions = {}, p1Actions = {}, p2Actions = {}}
  self.__index = self
  return setmetatable(newObj, self)
end


-------------------------------------
--Adds something at the end of the queue
-- @param action - the action to be placed in the queue,
-- @param queueType - the table to place the action in
-- @return a new queue instance
-- @author Ludwig Wikblad
-------------------------------------
function Queue:push(action, queueType)

  if queueType == "queue" then
    table.insert(self.actions,action)
    if self.bottomMenu ~= nil then self.bottomMenu:setQueue(self.actions) end
  elseif queueType == "loop" then
    table.insert(self.loopActions,action)
    if self.buildArea ~= nil then self.buildArea:setQueue(self.loopActions, queueType) end
  elseif queueType == "P1" then
    table.insert(self.p1Actions,action)
    if self.buildArea ~= nil then self.buildArea:setQueue(self.p1Actions, queueType) end
  elseif queueType == "P2" then
    table.insert(self.p2Actions,action)
    if self.buildArea ~= nil then self.buildArea:setQueue(self.p2Actions, queueType) end
  end
end


--------------------------------------
--Removes the object in the queue that was added last
-- @return the removed action
-- @author Ludwig Wikblad
--------------------------------------
function Queue:pop()
  return table.remove(self.actions)
end


----------------------------------------------------------------
--Allows someone to switch positions for two objects in the queue
-- @param currentPos, goalPos the positions of the objects that should be switched
-- @author Ludwig Wikblad
----------------------------------------------------------------
function Queue:setPosition(currentPos, goalPos)
  self.actions[currentPos], self.actions[goalPos] = self.actions[goalPos], self.actions[currentPos]
end


----------------------------------------
--Returns a queue in reversed order, so that
-- another part of the program can use pop to
-- go through it in execution order.
-- @return a queue instance with all the actions
-- in the order they will be executed (by using pop())
-- @author Ludwig Wikblad
----------------------------------------
function Queue:getExecutionQueue()
  local executionQueue = self:new()
  for i = 1, #self.actions do
      table.insert(executionQueue.actions, i, self.actions[#self.actions - i + 1])
  end
  return executionQueue
end

return Queue