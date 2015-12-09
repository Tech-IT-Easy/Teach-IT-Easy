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
-------------------------------
--The highest level for the game. Creates the parts of the game and
--tells the parts to update.
-------------------------------

local rightMenu = require('games.Progg.RightMenu')
local BottomMenu = require('games.Progg.BottomMenu')
local Game = require('toolkit.Game')
--Will have to include the classes of the other components here
local ProggGame = extends(Game)


-----------------------------------------------------------
-- Constructor method, see 'toolkit.Game'. Called by GameFactory.
-- @param context:PlatformContext - A pointer to the context that the game exists in
-- @return a new game:ProggGame instance
-----------------------------------------------------------
function ProggGame:new(context, level)
  local o = ProggGame:super()

  -- @member BottomMenu:BottomMenu
  -- @member map:Map
  local levelData = context.proggGameLevels[level]

--  o.bottomMenu = BottomMenu:new(levelData, context)
  o.bottomMenu = BottomMenu:new(levelData, context)
  o.rightMenu = rightMenu:new()

  --o.map = map:new()
  --------------------------------
  -- super characters
  --------------------------------
  self.platformContext = context
  self:initListener()
  --self.gameEventListener:attach(o.inputHandler)
  self.gameEventListener:attach(o.rightMenu)
  self.gameEventListener:attach(o.bottomMenu)
  self.gameEventListener:attach(o.selectLevel)
  
  return ProggGame:init(o)
end

-----------------------------------------------------------
-- Loading resources, only called when the game starts
-- as of right now.
-- @author Ludwig Wikblad, changed by others when needed
-----------------------------------------------------------
function ProggGame:load()
  -----------------------
  -- call load on all resources e.g.
  -- UI:load()
  -----------------------
  --self.map:load()

  self.bottomMenu:load()
end

-----------------------
--When the platform launches the game it calls this function
-- @author Chuck
-----------------------
function ProggGame:start()
  self:load()
  ----------------------
  --We might need to do more here as well
  ----------------------
end


------------------------
--Updates all objects that are part of the game
-- and are displayed on the screen
-- @author Chuck
------------------------
function ProggGame:update()
  -----------------------
  --Calls update on all objects, e.g.
  --UI:update()
  self.bottomMenu:show()
 
  --self.buildArea:show()
  --self.inputHandler:show()
end

return ProggGame
