-----------------------------------------------------------
--  Super class of all the class
--  This class makes all the subclass as object-oriented feature
--
-- @Author:Created by Chuck, Aug 16,2015
-- @Author:Updated by Chuck, Nov 11,2015 fixed inheritance problems
-----------------------------------------------------------


-----------------------------------------------------------
-- Implement inheritance feature in Lua. Create a new class 
-- that inherits from a base class
-- @baseClass which is inherited
-----------------------------------------------------------
function extends( baseClass )
  -- create a new blank class 
  local newClass = {}
  
  -- set base class of new class is baseClass
  newClass._baseClass = baseClass
  
  -- set __index of new class itself to make preparation for subclass
  newClass.__index = newClass

  -- create a init function to create a real object
  function newClass:super(args)
    return self._baseClass:new(args)
  end
  
  -- get the base class
  function newClass:getBaseClass()
    return self._baseClass
  end
  
  -- initialize this class
  function newClass:init(o)
    return setmetatable(o,self)
  end
  
  -- set metatable of new class is baseClass
  if baseClass ~= nil then
      setmetatable(newClass,baseClass)
  end
  return newClass
end


Object = {}
Object.__index = Object

function Object:new(args)
  return setmetatable({},self)
end

return Object
