-------------------------------------
-- Object for keeping and retrieving (x,y)-positions
-- @author Mario Pizcueta
-------------------------------------

local Object = require('toolkit.Object')


local Position = extends(Object)

local X = 0
local Y = 0

--------------------------------------
-- Constructor method
-- @param x:integer the x-position
-- @param y:integer the y-position
-- @return position:position a new instance of Position
--------------------------------------
function Position:new(x,y)
local o = Position:super()
o.X = x
o.Y = y
return Position:init(o)
end

----------------------------------
-- Getter for x-position
-- @return x:integer the x-position
-- @author Mario Pizcueta
----------------------------------
function Position:getX()
return self.X
end

----------------------------------
-- Getter for y-position
-- @return y:integer the y-position
-- @author Mario Pizcueta
----------------------------------
function Position:getY()
return self.Y
end

----------------------------------
-- Setter for x-position
-- @param x:integer the x-position
-- @author Mario Pizcueta
----------------------------------
function Position:setX(x)
self.X = x
end

----------------------------------
-- Setter for x-position
-- @param x:integer the x-position
-- @author Mario Pizcueta
----------------------------------
function Position:setY(y)
self.Y = y
end


return Position