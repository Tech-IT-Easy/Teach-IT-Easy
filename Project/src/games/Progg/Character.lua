-----------------------------------------------------------
-- This class represents the character and its position in the game.
-- @Author:Created by Mario Pizcueta, Nov 11,2015
-- ---------------------------------

local Object = require("toolkit.Object")
local Character = extends(Object)
local Commands = require('games.Progg.Commands')
local Position = require('games.Progg.Position')


-- @member Comands:Commands
-- @member Position:Position

----
--0 == UP
--1 == RIGHT
--2 == DOWN
--3 == LEFT
----
local step = 5
----
--Constructor of the character.
--@param: the initial position of the character
----
function Character:new(newPosition)
  local o = Character:super()
  o.position = newPosition
  o.state = 0
  return Character:init(o)
end


function Character:startExecution(inqueue)
  local queue = inqueue:getExecutionQueue()
  for i=1, #queue.actions do
    local act = queue:pop()
    if(act~=nil)then
    if act == Commands.LOOP then
      for i =1, #queue.loopActions do
        act = table.remove(queue.loopActions)
        self:execute(act)
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

---
--Executes the given command
--@param: the command to execute of class Commands
---
function Character:execute(command)
 --Moving up
    if(command == Commands.MOVE) then
      if(self:checkCollision(self.position, self.state)) then
        if(self.state ==0) then
         self.position:setY(self.position:getY()-step)
        elseif(self.state ==1) then
         self.position:setX(self.position:getX()+step)
        elseif(self.state ==2) then
         self.position:setY(self.position:getY()+step)
        elseif(self.state ==3) then
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

function Character:checkCollision(position, state)
  return true
end

return Character