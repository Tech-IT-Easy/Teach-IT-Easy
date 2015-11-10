local Object = require("toolkit.Object")
local Character = extends(Object.class())
local Commands = require('games.Progg.Commands')
local Position = require('games.Progg.Position')

local position = nil
----
--0 == UP
--1 == RIGHT
--2 == DOWN
--3 == LEFT
----
local state = 0
local step = 5
----
--Constructor of the character
----
function Character:new(newPosition)
position = newPosition
print("Character created "..position:getX()..","..position:getY())
return self.class()
end



---
--Executes the given command
---
function Character:execute(command)
 --Moving up
    if(command == Commands.MOVE) then
      if(self:checkCollision(position,state)) then
        if(state==0) then
         position:setY(position:getY()-step)
        elseif(state==1) then
         position:setX(position:getX()+step)
        elseif(state==2) then
         position:setY(position:getY()+step)
        elseif(state==3) then
         position:setX(position:getX()-step)
        end
      end
    end

    if(command == Commands.TURN_LEFT) then
    --Moving left
    state = (state-1)%4
    end

    if(command == Commands.TURN_RIGHT) then
    --moving right
        state = (state+1)%4
    end
    
    print("Char position "..position:getX()..","..position:getY())
    print("Char state"..state)

end

function Character:checkCollision(position, state)
return true
end

return Character