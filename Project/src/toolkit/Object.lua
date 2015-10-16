--
--  Super class of all the class
--  This class makes all the subclass as object-oriented feature
--

Object = {}

function Object:new()
  newObject = {}
  self.__index = self
  return setmetatable(newObject,self)
end

return Object--:new()