

local Object = require('toolkit.Object')
local Event = extends(Object.class())

Position.X = 0
Position.Y = 0

function Position:new(x,y)

self.X = x
self.Y = y
return self.class()
end


--Geters and setters of X and Y
function Position.getX()

return self.X
end

function Position.getY()

return self.Y
end

function Position.setX(x)
self.X = x
end

function Position.setY(y)
self.Y = y
end


return Position