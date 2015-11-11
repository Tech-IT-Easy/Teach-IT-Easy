

local Object = require('toolkit.Object')

Position = extends(Object.class())

local X = 0
local Y = 0

function Position:new(x,y)
self.X = x
self.Y = y
return self.class()
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