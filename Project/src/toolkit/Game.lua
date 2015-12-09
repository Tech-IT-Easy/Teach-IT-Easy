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
-- This class is for avoiding system cohesion. It is super class
-- of all specific game.
--
-- @Author:Created by Chuck, Aug 16,2015
-- @Author:Updated by Chuck, Nov 11,2015 fit to new structure
-----------------------------------------------------------

local EventListener = require('toolkit.EventListener')
local Object = require('toolkit.Object')

local Game = extends(Object)

-----------------------------------------------------------
-- Construct method
-- @param context:PlatformContext which specific context the game belongs to
-- @return :Game a new instance of a game
-----------------------------------------------------------
function Game:new(context)
  local o = Game:super()
  
  -- A game need to know current paltform context 
  o.platformContext = nil
  
  -- Game owns itself listener to know what events are happening
  o.gameEventListener = nil
  
  return Game:init(o)
end

-----------------------------------------
-- Adds the Games listener as a chainListener to the PlatformContext's listener
-- @author Chuck
-----------------------------------------
function Game:initListener()
  -- Default event listener
  if self.platformContext ~= nil then
    self.gameEventListener = EventListener:new(self)
    self.platformContext.platformEventListener:addChainListener(self.gameEventListener)
  else
    print("add listener error")
  end
end

return Game