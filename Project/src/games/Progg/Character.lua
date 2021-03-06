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
-----------------------------------------------------------
-- This class represents the character and its position in the game.
-- @Author:Created by Mario Pizcueta, Nov 11,2015
-- @Author:Updated by Tobias Lundell, Nov 26, 2015 added functionality for character to execute if-statements
-- ---------------------------------

local Object = require("toolkit.Object")
local Character = extends(Object)
local Commands = require('games.Progg.Commands')
local Map = require('games.Progg.Map')

----
--0 == UP
--1 == RIGHT
--2 == DOWN
--3 == LEFT
----
local executionProgress = 0
----
-- Constructor of the character.
-- @param x:integer the initial x-position of the character
-- @param y:integer the initial y-position of the character
-- @author Ludwig Wikblad; Mario Pizcueta
----
function Character:new(x,y, rightMenu, levelData, context)
  local o = Character:super()
 -- o.position = {x = x, y = y}
 -- o.startPosition = {x = x, y = y}
  o.state = 0
  -- @member map:Map
  o.map = Map:new(context)
  o.map:load(levelData)
  o.position = {x = o.map.startPos%8 , y = math.ceil(o.map.startPos/8) }
  o.startPosition = {x = o.map.startPos%8, y = math.ceil(o.map.startPos/8)}
  o.hasWon=false
  o.step = 1
  o.rightMenu = rightMenu
  o.ifIterations = 0
  o.context = context
  o.levelData = levelData
  o.procProcess = {}
  o.recursionLevel = 0
  o.recursionTrack = {}
  return Character:init(o)
end

----------------------------------------
-- The logic that executes the whole queue when called.
-- @param inqueue:Queue - the queue with all the actions to be executed
-- @author Ludwig Wikblad, Mario Pizcueta
----------------------------------------
function Character:startExecution(inqueue)
  -- This if is necessary in order to handle the user trying to start the execution while it's already running.
  if self.executionTimer == nil then
    self.queue = inqueue:getExecutionQueue()
    self.j = 0 --Keeps track of number of commands.
    self.loopNumber = 1

    start = function(timer)
      --Check if the goal has been reached
      if(self.map:isInGoal(self.position.x,self.position.y) and #self.map.inGameObjectives==0)then
        self.hasWon = true
        self.map:winMessage()
        if(self.levelData.level > self.context.profile.gameprogress:getProgress("games.Progg.ProggGame").level) then
          self:updateProgress()
          self.map:drawTrophy()

        end
        self.executionTimer:stop()
        self.executionTimer = nil
        gfx.update()
          return;
      end

      if(0<#self.queue.actions or self.onP1 or self.onP2 or self.onLoop or self.onIf) then
        local act
        if(not self.onP1 and not self.onP2 and not self.onLoop and not self.onIf)then
          act = self.queue:pop()
        else
          act = "onProc"
        end
        if(act~=nil)then

          --If the command LOOP is encounter or if its executing LOOP
          if (act == Commands.LOOP or self.onLoop) then
            self.onLoop = true
            if(act == Commands.LOOP) then
              self.nrOfIterations = inqueue.loopCounter[self.loopNumber]
              self.procProcess[1] = 0 --Counts the position inside the loop
            end
            if(self.nrOfIterations>0) then
              act = self.queue.loopActions[self.loopNumber][self.procProcess[1]]
              if (act == Commands.IF) or self.onIf then
                  self.isCompleted = self:executeIfStatement()
                  if (self.isCompleted) then
                    self.procProcess[1] = self.procProcess[1]+1;
                  end
              else
                self.procProcess[1] = self.procProcess[1]+1;
                self:execute(act)
              end
              if(self.procProcess[1]>#self.queue.loopActions[self.loopNumber])then
                self.procProcess[1] = 0
                self.nrOfIterations = self.nrOfIterations-1;
              end
            else
              self.onLoop = false
              self.loopNumber = self.loopNumber+1
            end -- end of LOOP

            --If the command P1 is encounter or if its executing P1
          elseif (act == Commands.P1 or self.onP1) then
            if(act == Commands.P1) then
              self.recursionLevel=self.recursionLevel+1
              self.procProcess[self.recursionLevel] = 0
              self.recursionTrack[self.recursionLevel] = "P1"
            end
            self.onP1=true
            if(self.procProcess[self.recursionLevel]<#self.queue.p1Actions)then
              if (not self.onIf) then
                self.procProcess[self.recursionLevel] =  self.procProcess[self.recursionLevel] + 1;
              end
              act = self.queue.p1Actions[#self.queue.p1Actions - self.procProcess[self.recursionLevel] + 1]
              if(act == Commands.P1 or act == Commands.P2) then
               self.recursionLevel=self.recursionLevel+1
               self.procProcess[self.recursionLevel] = 0;
                if(act == Commands.P2)then
                  self.onP1 = false;
                  self.onP2 = true;
                  self.recursionTrack[self.recursionLevel] = "P2"
                else
                  self.recursionTrack[self.recursionLevel] = "P1"
                end
              end
                
              if (act == Commands.IF) then
                self.isCompleted = self:executeIfStatement()
              else
                self:execute(act)
              end
            else
              self.recursionLevel=self.recursionLevel-1;
              self.onP1=false
              if(self.recursionTrack[self.recursionLevel]=="P1")then
                self.onP1 = true
              elseif(self.recursionTrack[self.recursionLevel]=="P2")then
                self.onP2=true
              end
            end-- end of P1

            --If the command P2 is encounter or if its executing P2
          elseif (act == Commands.P2 or self.onP2) then
            if(act == Commands.P2) then
              self.recursionLevel=self.recursionLevel+1;
              self.procProcess[self.recursionLevel] = 0
              self.recursionTrack[self.recursionLevel] = "P2"
            end
            self.onP2=true
            if(self.procProcess[self.recursionLevel]<#self.queue.p2Actions)then
              if (not self.onIf) then
                self.procProcess[self.recursionLevel] =  self.procProcess[self.recursionLevel] + 1;
              end
              act = self.queue.p2Actions[#self.queue.p2Actions - self.procProcess[self.recursionLevel] + 1]
             if(act == Commands.P1 or act == Commands.P2) then
               self.recursionLevel=self.recursionLevel-1; 
               self.procProcess[self.recursionLevel] = 0;
               if(act == Commands.P1)then
                  self.onP1 = true;
                  self.onP2 = false;
                  self.recursionTrack[self.recursionLevel] = "P1"
                else
                  self.recursionTrack[self.recursionLevel] = "P2"
                end
               end
              if (act == Commands.IF) then
                self.isCompleted = self:executeIfStatement()
              else
                self:execute(act)
              end
            else
              self.recursionLevel=self.recursionLevel-1; 
              self.onP2=false
              if(self.recursionTrack[self.recursionLevel]=="P1")then
                self.onP1 = true
              elseif(self.recursionTrack[self.recursionLevel]=="P2")then
                self.onP2=true
              end
            end-- end of P2

            --If the command IF is encountered or it is executing IF
          elseif (act == Commands.IF or self.onIf) then
            if (act == Commands.IF) then
              self.procProcess[1] = 0
            end
            self.isCompleted = self:executeIfStatement()
            if (self.isCompleted) then
              self.procProcess[1] = self.procProcess[1] + 1;
            end
          else
            --If not executing any procedure or loop -> normal queue
            self:execute(act)
          end -- if act ==Commands.
          self.j= self.j+1; --Keeps track of of number of commands
        end -- if act ~= nil
      else
        --End of execution
        if self.executionTimer ~= nil then
          self.executionTimer:stop()
          self.executionTimer = nil
        end
        collectgarbage()
          self:reset()
          gfx.update()
      end -- end of QUEUE
    end

    --Sets the timer
    self.executionTimer = sys.new_timer(500, "start")
    
  else --This is if the user wants to terminate the execution of the queue
    self.executionTimer:stop()
    self.executionTimer = nil
    self:reset()
  end

end

---------------------------------------
-- Executes the given command by asking map if action
-- is legal and then telling map to perform action
-- @param: the command:Commands to execute
-- @author Mario Pizcueta
---------------------------------------
function Character:execute(command)
  --Moving up
  if(command == Commands.MOVE) then
    if(self:checkCollision(self.position, self.state)) then
      if(self.state == 0) then
        self.map:moveCharacter(self.position.x, self.position.y, self.state)
        self.position.y = self.position.y-self.step
      elseif(self.state == 1) then
        self.map:moveCharacter(self.position.x, self.position.y, self.state)
        self.position.x = self.position.x+self.step
      elseif(self.state == 2) then
        self.map:moveCharacter(self.position.x, self.position.y, self.state)
        self.position.y = self.position.y+self.step
      elseif(self.state == 3) then
        self.map:moveCharacter(self.position.x, self.position.y, self.state)
        self.position.x = self.position.x-self.step
      end
    else --If encounter collision-> restart
    self.executionTimer:stop()
    self.executionTimer = nil
    self:reset()
    gfx.update()
    return
    end
  end

  if(command == Commands.TURN_LEFT) then
    --Moving left
    self.state = (self.state -1)%4
    self.map:setCharacter(self.map:getPosition(self.position.x, self.position.y), self.state)
  end

  if(command == Commands.TURN_RIGHT) then
    --moving right
    self.state = (self.state +1)%4
    self.map:setCharacter(self.map:getPosition(self.position.x, self.position.y), self.state)
  end

  if(command == Commands.FIX) then
    --fixing the box
    self.map:activateBox(self.position.x, self.position.y)
  end
end


----------------------------------------
-- Executes an if statement in queue or loop
-- @ return boolean. True if if-statement is completed, false if not
-- @ author Tobias Lundell, Nov 29, 2015
----------------------------------------
function Character:executeIfStatement()
  if (not self.onIf) then
    self.ifIterations = 0
    self.onIf = true
  end
  if (not self.onIfTrue and not self.onIfFalse) then --Check condition (if wall) true or false
    if (self:checkCollision(self.position, self.state) == false) then
      self.onIfTrue = true
      self.onIfFalse = false
    else
      self.onIfFalse = true
      self.onIfTrue = false
    end
  end
  if (self.onIfTrue) then --Executes if true
    if (self.ifIterations < #self.queue.ifTrueActions) then
      self.ifIterations = self.ifIterations + 1;
      self.act = self.queue.ifTrueActions[#self.queue.ifTrueActions - self.ifIterations + 1]
      self:execute(self.act)
      return false
    else
      self.onIfTrue = false
      self.onIf = false
    end -- end ifTrue
  elseif (self.onIfFalse) then --Executes if false
    if (self.ifIterations < #self.queue.ifFalseActions) then
      self.ifIterations = self.ifIterations + 1;
      self.act = self.queue.ifFalseActions[#self.queue.ifFalseActions - self.ifIterations + 1]
      self:execute(self.act)
      return false
    else
      self.onIfFalse = false
      self.onIf = false
    end -- end ifFalse
  end
  return true
end


-----------------------------------------------------------------
-- Calls the map to check if an action is possible to make
-- @param position:Position - describes the characters position (x,y)
-- @param state:integer - which direction the character is turned
-- @return boolean value of whether it's ok or not to take the action
-- @author Ludwig Wikblad
-----------------------------------------------------------------
function Character:checkCollision(position, state)
  return self.map:canMove(position.x, position.y, state)
end

---------------------------------------
-- Resets the character to it's start position.
-- @author Ludwig Wikblad
---------------------------------------
function Character:reset()

  self.map:restartCharacter(self.position.x,self.position.y)
  self.position.x = self.startPosition.x
  self.position.y = self.startPosition.y
  self.state = 0
  self.onP1 = false
  self.procProcess[1] = 0
  self.nrOfIterations = 0
  self.onP2 = false
  self.onLoop = false
  self.onIf = false
  self.onIfTrue = false
  self.onIfFalse = false
  self.j = 0

  self.recursionLevel = 0
  self.recursionTrack = {}
  if self.rightMenu ~= nil then  self.rightMenu:stop() end
end

---------------------------------------
-- Saves the progress into the current profile
-- @author Ludwig Wikblad
---------------------------------------
function Character:updateProgress()
    local progress = self.context.profile.gameprogress:getProgress("games.Progg.ProggGame")
    progress.level = self.levelData.level
    if (self.levelData.level == 3) then
        progress.proggGameBasicLevel = true
    elseif (self.levelData.level == 4) then
        progress.proggGameProcLevel = true
    elseif (self.levelData.level == 5) then
        progress.proggGameLoopLevel = true
    elseif (self.levelData.level == 8) then
        progress.proggGameMaster = true
    end
    self.context.profile.gameprogress:setProgress("games.Progg.ProggGame", progress)
end

return Character
