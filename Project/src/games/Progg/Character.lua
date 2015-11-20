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
----
-- Constructor of the character.
-- @param: the initial position of the character
-- @author Ludwig Wikblad; Mario Pizcueta
----
function Character:new(newPosition)
  local o = Character:super()
  -- @member position:Position
  o.position = newPosition
  o.state = 0
  -- @member map:Map
  o.map = Map:new()
  o.map:load()
  return Character:init(o)
end

----------------------------------------
-- The logic that executes the whole queue when called.
-- @param inqueue - the queue with all the actions to be executed
-- @author Ludwig Wikblad
----------------------------------------
function Character:startExecution(inqueue)
  local queue = inqueue:getExecutionQueue()
  for i=1, #queue.actions do
    local act = queue:pop()
    if(act~=nil)then
      if act == Commands.LOOP then
        local nrOfIterations = inqueue.loopCounter
        for k = 1, nrOfIterations do
          for i =1, #queue.loopActions do
            act = queue.loopActions[#queue.loopActions - i + 1]
            self:execute(act)
          end
        end
      elseif act == Commands.P1 then
        for i =1, #queue.p1Actions do
          act = table.remove(queue.p1Actions)
          self:execute(act)
        end

      elseif act == Commands.P2 then
        for i =1, #queue.p2Actions do
          act = table.remove(queue.p2Actions)
          self:execute(act)
        end
      else
        self:execute(act)
      end
    end
  end
end

---------------------------------------
-- Executes the given command by asking map if action
-- is legal and then telling map to perform action
-- @param: the command to execute of class Commands
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
-- @param position - describes the characters position (x,y)
-- @param state - which direction the character is turned
-- @return boolean value of whether it's ok or not to take the action
-- @author Ludwig Wikblad
-----------------------------------------------------------------
function Character:checkCollision(position, state)
  return self.map:canMove(position:getX(), position:getY(), state)
  --return true
end

return Character