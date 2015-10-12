
-- Object class for trying out inheritance

Object = {}

function Object:new()
  newObject = {}
  self.__index = self
  return setmetatable(newObject,self)
end

return Object:new()

