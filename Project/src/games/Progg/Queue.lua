local Object = require('toolkit.Object')
local Queue = extends(Object)

---------------------------------------------------------------
-- Constructor for the Queue
-- @param newBottomMenu:BottomMenu The place where the queue is drawn.
-- @param newBuildArea:BuildArea. The places where the loops and procedures are edited.
-- @return queue:Queue a new queue instance
-- @author Ludwig Wikblad
-- @author Tobias Lundell
----------------------------------------------------------------
function Queue:new(newBottomMenu, newBuildArea, maxCommands)
  local o = Queue:super()
  o.actions = {}
  o.loopActions = {}
  o.p1Actions = {}
  o.p2Actions = {}
  o.ifTrueActions = {}
  o.ifFalseActions = {}
  o.maxCommands = maxCommands
  o.loopCounter = 2
  o.INFINITY = 999
  -- @member bottomMenu:BottomMenu
  if newBottomMenu ~= nil then o.bottomMenu = newBottomMenu end
  -- @member buildArea:BuildArea
  if newBuildArea ~= nil then o.buildArea = newBuildArea end

  return Queue:init(o)
end

-------------------------------------
-- Adds something at the end of the queue
-- @param action:Command - the action to be placed in the queue,
-- @param queueType:String - the table to place the action in
-- @author Ludwig Wikblad
-------------------------------------
function Queue:push(action, queueType)
  if queueType == "queue" or queueType == nil then
    if  queueType == nil or self.maxCommands[queueType] > #self.actions then
        table.insert(self.actions,action)
        if self.bottomMenu ~= nil then self.bottomMenu:setQueue(self) end
    end
  elseif queueType == "loop" then
    if self.maxCommands[queueType] > #self.loopActions and self:containsRecursion(action, self.loopActions, queueType) == false then
        table.insert(self.loopActions,action)
        if self.buildArea ~= nil then self.buildArea:setQueue(self.loopActions, queueType) end
    end
  elseif queueType == "P1" then
    if self.maxCommands[queueType] > #self.p1Actions and self:containsRecursion(action, self.p1Actions, queueType) == false then
        table.insert(self.p1Actions,action)
        if self.buildArea ~= nil then self.buildArea:setQueue(self.p1Actions, queueType) end
    end
  elseif queueType == "P2" then
    if self.maxCommands[queueType] > #self.p2Actions and self:containsRecursion(action, self.p2Actions, queueType) == false then
        table.insert(self.p2Actions,action)
        if self.buildArea ~= nil then self.buildArea:setQueue(self.p2Actions, queueType) end
    end
  elseif queueType == "if-wall" then
    if self.maxCommands[queueType] > #self.ifTrueActions and self:containsRecursion(action, self.ifTrueActions, queueType) == false then
      table.insert(self.ifTrueActions, action)
      if self.buildArea ~= nil then self.buildArea:setQueue(self.ifTrueActions, queueType) end
    end
  elseif queueType == "if-not-wall" then
    if self.maxCommands[queueType] > #self.ifFalseActions and self:containsRecursion(action, self.ifFalseActions, queueType) == false then
      table.insert(self.ifFalseActions, action)
      if self.buildArea ~= nil then self.buildArea:setQueue(self.ifFalseActions, queueType) end
    end
  end
end


function Queue:getQueue()
  return
end

--------------------------------------
-- Removes the object that was added last in the main queue
-- @return the removed action:Commands
-- @author Ludwig Wikblad
--------------------------------------
function Queue:pop()
  return table.remove(self.actions)
end


----------------------------------------------------------------
-- Allows someone to switch positions for two objects in the queue
-- @param currentPos:integer, goalPos:integer the positions of the objects that should be switched
-- @author Ludwig Wikblad
----------------------------------------------------------------
function Queue:setPosition(currentPos, goalPos)
  self.actions[currentPos], self.actions[goalPos] = self.actions[goalPos], self.actions[currentPos]
end


----------------------------------------
-- Returns a queue in reversed order, so that
-- another part of the program can use pop to
-- go through it in execution order.
-- @return a queue:Queue instance with all the actions
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
  if self.ifTrueActions ~= nil then
    for i = 1, #self.ifTrueActions do
      table.insert(executionQueue.ifTrueActions, i, self.ifTrueActions[#self.ifTrueActions - i + 1])
    end
  end
  if self.ifFalseActions ~= nil then
    for i = 1, #self.ifFalseActions do
      table.insert(executionQueue.ifFalseActions, i, self.ifFalseActions[#self.ifFalseActions - i + 1])
    end
  end
  return executionQueue
end

-------------
--- !!Note!! This function will be uncommented and work as intended when calling methods from methods is supported. !!Note!!
---
--- Used to make sure that not more than one recursion call is made in a method.
--- @return false if adding action that is not itself (aka not recursive) or if there isn't a recursive call already added.
--- @return true if method already contains a call to itself.
--- @author Mikael Ögren
----
function Queue:containsRecursion(action, Queue, queueType)
--  if action ~= queueType then
--    return false
--  else

    if action == "loop" or action == "P1" or action == "P2" then --Remove when method calls are allowed
    print("Calling a method from a method is not allowed yet") --Remove when method calls are allowed
    return true --Remove when method calls are allowed

--    for i = 1, #Queue do
--      if Queue[i] == action then
--        print("Only allowed to use recursion once!")
--        return true
--      end
--    end
  else return false --Remove when method calls are allowed
  end
--  return false
end

return Queue

