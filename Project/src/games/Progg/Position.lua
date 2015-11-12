

local Object = require('toolkit.Object')


Position = extends(Object)

local X = 0
local Y = 0

function Position:new(x,y)
local o = Position:super()
o.X = x
o.Y = y
return Position:init(o)
end

--Geters and setters of X and Y
function Position:getX()

return self.X
end

function Position:getY()

return self.Y
end

function Position:setX(x)
self.X = x
end

function Position:setY(y)
self.Y = y
end


return Position