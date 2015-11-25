-----------------------------------------------------------
-- This class represents the character and its position in the game.
-- @Author:Created by Mario Pizcueta, Nov 11,2015
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
local step = 1
local executionProgress = 0
----
-- Constructor of the character.
-- @param the initial position:Position of the character
-- @author Ludwig Wikblad; Mario Pizcueta
----
function Character:new(newPosition)
  local o = Character:super()
  -- @member position:Position
  o.position = newPosition
  o.startPosition = newPosition
  o.state = 0
  -- @member map:Map
  o.map = Map:new()
  o.map:load()
  o.hasWon=false
  return Character:init(o)
end

----------------------------------------
-- The logic that executes the whole queue when called.
-- @param inqueue:Queue - the queue with all the actions to be executed
-- @author Ludwig Wikblad, Mario Pizcueta
----------------------------------------
function Character:startExecution(inqueue)
  self.queue = inqueue:getExecutionQueue()
  self.j = 0 --Will keep track of number of commands. No use yet

 start = function(timer)
  if(0<#self.queue.actions or self.onP1 or self.onP2 or self.onLoop) then
    local act
      if(not self.onP1 and not self.onP2 and not self.onLoop)then
      act = self.queue:pop()
      else
      act = "onProc"
      end
    if(act~=nil)then
      --If the command LOOP is encounter or if its executing LOOP
      if (act == Commands.LOOP or self.onLoop) then
        self.onLoop = true
        if(act == Commands.LOOP) then
        self.nrOfIterations = inqueue.loopCounter
        self.loopProcess = 0 --Counts the position inside the loop
        end
        if(self.nrOfIterations>0) then
            act = self.queue.loopActions[#self.queue.loopActions - self.loopProcess + 1]
            self.loopProcess = self.loopProcess+1
            self:execute(act)
            if(self.loopProcess>#self.queue.loopActions)then
            self.loopProcess = 0
            self.nrOfIterations = self.nrOfIterations-1
            end
        else
          self.onLoop = false
        end -- end of LOOP
        
      --If the command P1 is encounter or if its executing P1
      elseif (act == Commands.P1 or self.onP1) then
        self.onP1=true
        if(0<#self.queue.p1Actions)then
          act = table.remove(self.queue.p1Actions)
          self:execute(act)
        else
        self.onP1=false
        end-- end of P1

       --If the command P2 is encounter or if its executing P2
      elseif (act == Commands.P2 or self.onP2) then
        self.onP2=true
        if(0<#self.queue.p2Actions)then
          act = table.remove(self.queue.p2Actions)
          self:execute(act)
        else
          self.onP2=false
        end-- end of P2

      else
      --If not executing any procedure or loop -> normal queue
        self:execute(act)
      end -- if act ==Commands.
    self.j= self.j+1; --Keeps track of of number of commands
    end -- if act ~= nil
  else
  --End of execution
  self.executionTimer:stop()   
     --Check if the goal has been reached
     if(self.map:isInGoal(self.position:getX(),self.position:getY()))then
        self.hasWon = true
     else
         self.map:restartCharacter(self.position:getX(),self.position:getY())
         self.position = self.startPosition
         gfx.update()
     end
  end -- end of QUEUE
  
  end
  --Sets the timer
  self.executionTimer = sys.new_timer(500, "start")
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
        if(self.state ==0) then
          self.map:moveCharacter(self.position:getX(), self.position:getY(), self.state)
          self.position:setY(self.position:getY()-step)
        elseif(self.state ==1) then
          self.map:moveCharacter(self.position:getX(), self.position:getY(), self.state)
          self.position:setX(self.position:getX()+step)
        elseif(self.state ==2) then
          self.map:moveCharacter(self.position:getX(), self.position:getY(), self.state)
          self.position:setY(self.position:getY()+step)
        elseif(self.state ==3) then
          self.map:moveCharacter(self.position:getX(), self.position:getY(), self.state)
          self.position:setX(self.position:getX()-step)
        end
      else --If encounter collision-> restart
         self.executionTimer:stop()
         self.map:restartCharacter(self.position:getX(),self.position:getY())
         self.position = self.startPosition
         gfx.update()
      end
    end

    if(command == Commands.TURN_LEFT) then
    --Moving left
    self.state = (self.state -1)%4
    end

    if(command == Commands.TURN_RIGHT) then
    --moving right
        self.state = (self.state +1)%4
    end
end


-----------------------------------------------------------------
-- Calls the map to check if an action is possible to make
-- @param position:Position - describes the characters position (x,y)
-- @param state:integer - which direction the character is turned
-- @return boolean value of whether it's ok or not to take the action
-- @author Ludwig Wikblad
-----------------------------------------------------------------
function Character:checkCollision(position, state)
  return self.map:canMove(position:getX(), position:getY(), state)
  --return true
end

return Character