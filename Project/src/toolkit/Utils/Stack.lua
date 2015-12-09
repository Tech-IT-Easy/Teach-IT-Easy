--[[TEACH IT EASY, an educational games platform
    Copyright (C) 2015  Linköping University

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.


    MIT LICENSE:
    Copyright (c) 2015 Zenterio AB

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:



    The above copyright notice and this permission notice shall be included in
    all copies or substantial portions of the Software.


    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
    THE SOFTWARE.


    ]]
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

