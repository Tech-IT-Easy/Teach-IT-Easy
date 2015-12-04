---------------------------------------
-- This class provides a implementation
-- of a stack that can be used for any
-- datatype.
--
-- @author Tobias Lundell, Dec 04, 2015
---------------------------------------

local Object = require('toolkit.Object')
local Stack = extends(Object)

---------------------------------------
-- Constructor for the class Stack
-- @author Tobias Lundell
---------------------------------------
function Stack:new()
  local o = Stack:super()
  return Stack:init(o)
end

---------------------------------------
-- Initiates an empty table with stack functions pop(), push(),
-- peek() and getn().
-- @auhtor Tobias Lundell
---------------------------------------
function Stack:Create()

  -- stack table
  local t = {}
  -- entry table
  t._et = {}

  --------------------------------------
  -- Pushes an object to the top of the stack
  -- @param ... The object to be pushed.
  -- @author Tobias Lundell
  --------------------------------------
  function t:push(...)
    if ... then
      local targs = {...}
      -- add values
      for _,v in ipairs(targs) do
        table.insert(self._et, v)
      end
    end
  end

  ---------------------------------------
  -- Pops the most recent value added to the stack
  -- @param num. The number of entries to be popped. Set to 1 if not specified.
  -- @return Table containing the popped entries.
  -- @author Tobias Lundell
  ---------------------------------------
  function t:pop(num)

    -- get num values from stack
    local num = num or 1

    -- return table
    local entries = {}

    -- get values into entries
    for i = 1, num do
      -- get last entry
      if #self._et ~= 0 then
        table.insert(entries, self._et[#self._et])
        -- remove last value
        table.remove(self._et)
      else
        break
      end
    end
    -- return unpacked entries
    return unpack(entries)
  end

  ------------------------------------------
  -- Peek at the most recent value of the stack
  -- @return The entry most recently added to the stack.
  -- @author Tobias Lundell
  ------------------------------------------
  function t:peek()

    --return table
    local entries = {}

    --get values into entries
    if #self._et ~= 0 then
      table.insert(entries, self._et[#self._et])
    end

    -- return unpacked entries
    return unpack(entries)
  end

  -------------------------------------------
  -- Get all entries in the stack.
  -- @return Table containing all the entries in the stack
  -- @author Tobias Lundell
  -------------------------------------------
  function t:getn()
    return #self._et
  end

  return t
end

return Stack

