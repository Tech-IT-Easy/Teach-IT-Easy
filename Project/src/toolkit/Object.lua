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
-- @param baseClass which is inherited
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
