--[[TEACH IT EASY, an educational games platform
    Copyright (C) 2015  Linköping University

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.


    MIT LICENSE:
    Copyright (c) 2015 Zenterio AB

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:



    The above copyright notice and this permission notice shall be included in
    all copies or substantial portions of the Software.


    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
    THE SOFTWARE.


    ]]
----------------------------------------
-- This class represents the queue with
-- actions to execute in the programming game.
----------------------------------------

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
  o.loopCounter = {}
  o.INFINITY = 999
  o.loopPointer = 0
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
    print(self.loopPointer)
  if queueType == "queue" or queueType == nil then
    if  queueType == nil or self.maxCommands[queueType] > #self.actions then
        table.insert(self.actions,action)
        if(action=="loop")then
          table.insert(self.loopActions,{})
          self.loopPointer = self.loopPointer+1
        end
        if self.bottomMenu ~= nil then 
          self.bottomMenu:setQueue(self) 
        end
    end
  elseif queueType == "loop" then
    if self.maxCommands[queueType] > #self.loopActions and self:containsRecursion(action, self.loopActions, queueType) == false then
        print("#loopActions ="..#self.loopActions)
        print(self.loopActions[self.loopPointer])
        for i=1, #self.loopActions do
            print(self.loopActions[i])
        end
        table.insert(self.loopActions[self.loopPointer],action)
        if self.buildArea ~= nil then self.buildArea:setQueue(self.loopActions[self.loopPointer], queueType) end
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

  -- When switching places of loops they must be switched in the table that contains all the loops as well.
  -- firstLoop and secondLoop keeps track of where in self.loopActions the loops are
  local firstLoop = 0
      for i = currentPos, 0, -1 do
          if self.actions[i] == "loop" then
              firstLoop = firstLoop + 1
          end
      end
  local secondLoop = 0
      for i = goalPos, 0, -1 do
          if self.actions[i] == "loop" then
              secondLoop = secondLoop + 1
          end
      end

  if(self.actions[currentPos]=="loop" and self.actions[goalPos]=="loop")then
      table.insert(self.loopActions, secondLoop, table.remove(self.loopActions, firstLoop))
      table.insert(self.loopCounter, secondLoop, table.remove(self.loopCounter, firstLoop))
  elseif self.actions[currentPos]=="loop" then
    if firstLoop > secondLoop then
      table.insert(self.loopActions, secondLoop + 1, table.remove(self.loopActions, firstLoop))
      table.insert(self.loopCounter, secondLoop + 1, table.remove(self.loopCounter, firstLoop))
    elseif secondLoop == #self.loopActions then
      table.insert(self.loopActions, table.remove(self.loopActions, firstLoop))
      table.insert(self.loopCounter, table.remove(self.loopCounter, firstLoop))
    else
      table.insert(self.loopActions, secondLoop, table.remove(self.loopActions, firstLoop))
      table.insert(self.loopCounter, secondLoop, table.remove(self.loopCounter, firstLoop))
    end
  end

  if currentPos > goalPos then
    table.insert(self.actions, goalPos, table.remove(self.actions, currentPos))
  elseif goalPos == #self.actions then
    table.insert(self.actions, table.remove(self.actions, currentPos))
  else
    table.insert(self.actions, goalPos, table.remove(self.actions, currentPos))
  end

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
      table.insert(executionQueue.loopActions, i, self.loopActions[i])
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

----------------------------------------
-- Clears the whole queue
-- @param queueType:Queue to be cleared
-- @author Ludwig Wikblad
----------------------------------------
function Queue:clearAll(queueType)
  if queueType == "queue" or queueType == nil then
    self.actions = {}
    self.loopActions = {}
    self.loopCounter = {}
    self.loopPointer = 0
    self.p1Actions = {}
    self.p2Actions = {}
    self.ifTrueActions = {}
    self.ifFalseActions = {}

    if self.buildArea ~= nil then
      self.buildArea:setQueue({}, "all")
    end

  elseif queueType == "loop" then
    self.loopActions[self.loopPointer] = {}
    if self.buildArea ~= nil then
      self.buildArea:setQueue(self.loopActions[self.loopPointer], queueType)
    end
  elseif queueType == "P1" then
    self.p1Actions = {}
  elseif queueType == "P2" then
    self.p2Actions = {}
  elseif queueType == "if-wall" then
    self.ifTrueActions = {}
  elseif queueType == "if-not-wall" then
    self.ifFalseActions = {}
  end
  if queueType == "queue" then
    self.bottomMenu.drawBottomMenu:emptySlots(queueType)
  else
    self.buildArea.drawBuildArea:emptySlots(queueType)
  end
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

    if action == "loop" or action == "P1"or action == "P2" then --Remove when method calls are allowed
    print("Calling a method from a method is not allowed yet") --Remove when method calls are allowed
    return false --Remove when method calls are allowed

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

