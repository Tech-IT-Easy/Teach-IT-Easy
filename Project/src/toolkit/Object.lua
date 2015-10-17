-----------------------------------------------------------
--  Super class of all the class
--  This class makes all the subclass as object-oriented feature
--
-- @Author:Created by Chuck, Aug 16,2015
-- @Author:Updated by author,date
-----------------------------------------------------------


-----------------------------------------------------------
-- Implement inheritance feature in Lua. Create a new class 
-- that inherits from a base class
-- @baseClass which is inherited
-----------------------------------------------------------
function extends( baseClass )

  -- The following lines are equivalent to the SimpleClass example:

  -- Create the table and metatable representing the class.
  local new_class = {}
  local class_mt = { __index = new_class }
  
  -- Note that this function uses class_mt as an upvalue, so every instance
  -- of the class will share the same metatable.
  --
  function new_class.class()
    local newinst = {}
    setmetatable( newinst, class_mt )
    return newinst
  end
  
  function new_class:new()
    print("super new class is called")
    return new_class.class()
  end
  -- The following is the key to implementing inheritance:

  -- The __index member of the new class's metatable references the
  -- base class.  This implies that all methods of the base class will
  -- be exposed to the sub-class, and that the sub-class can override
  -- any of these methods.
  --
  if baseClass then
    setmetatable( new_class, { __index = baseClass } )
  end

  -- Return the class object of the instance
  function new_class:className()
    return new_class
  end

  -- Return the super class object of the instance
  function new_class:superClass()
    return baseClass
  end

  -- Return true if the caller is an instance of theClass
  function new_class:isa( theClass )
    local b_isa = false
    local cur_class = new_class
    while ( nil ~= cur_class ) and ( false == b_isa ) do
      if cur_class == theClass then
        b_isa = true
      else
        cur_class = cur_class:superClass()
      end
    end
    return b_isa
  end
  return new_class
end

-- Supper class of all the object
local Object = extends(nil)
return Object
