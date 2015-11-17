local Object = require('toolkit.Object')
local Queue = extends(Object)
---------------------------------------------------------------
-- Constructor for the Queue
-- @param newBottomMenu,newBuildArea. The places where the queue is drawn.
-- @return a new queue instance
-- @author Ludwig Wikblad
----------------------------------------------------------------
function Queue:new(newBottomMenu, newBuildArea)
  local o = Queue:super()
  o.actions = {}
  o.loopActions = {}
  o.p1Actions = {}
  o.p2Actions = {}
  o.loopCounter = 2
  if newBottomMenu ~= nil then o.bottomMenu = newBottomMenu end
  if newBuildArea ~= nil then o.buildArea = newBuildArea end

  -- @member buildArea:BuildArea
  -- @member bottomMenu:BottomMenu

  return Queue:init(o)
end


-------------------------------------
--Adds something at the end of the queue
-- @param action - the action to be placed in the queue,
-- @param queueType - the table to place the action in
-- @return a new queue instance
-- @author Ludwig Wikblad
-------------------------------------
function Queue:push(action, queueType)

  if queueType == "queue" or queueType == nil then
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
  if self.loopActions ~= nil then
    for i = 1, #self.loopActions do
      table.insert(executionQueue.loopActions, i, self.loopActions[#self.loopActions - i + 1])
    end
  end
  if self.p1Actions ~= nil then
    for i = 1, #self.p1Actions do
      table.insert(executionQueue.p1Actions, i, self.p1Actions[#self.p1Actions - i + 1])
    end
  end
  if self.p2Actions ~= nil then
    for i = 1, #self.p2Actions do
      table.insert(executionQueue.p2Actions, i, self.p2Actions[#self.p2Actions - i + 1])
    end
  end
  return executionQueue
end

return Queue