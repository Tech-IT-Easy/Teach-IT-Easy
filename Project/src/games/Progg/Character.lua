local Object = require("toolkit.Object")
local Character = extends(Object)
local Commands = require('games.Progg.Commands')
local Position = require('games.Progg.Position')

----
--0 == UP
--1 == RIGHT
--2 == DOWN
--3 == LEFT
----
local step = 5
----
--Constructor of the character
----
function Character:new(newPosition)
local o = Character:super()
o.position = newPosition
o.state = 0
return Character:init(o)
end



---
--Executes the given command
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