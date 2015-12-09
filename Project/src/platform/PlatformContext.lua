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
-- This class is for the platform context which is used
-- to create menu and all the objects related to platform
-- and to control the screen showing of all objects or
-- update screen
-- Platform context is responsible for all the platform things
--
-- @Author:Created by Chuck, Aug 16,2015
-- @Author:Updated by author,date
-----------------------------------------------------------

ADConfig = require("Config.ADConfig")
ADLogger = require("SDK.Utils.ADLogger")
ADLogger.trace("Application Init")

if ADConfig.isSimulator then
  gfx = require "SDK.Simulator.gfx"
  zto = require "SDK.Simulator.zto"
  surface = require "SDK.Simulator.surface"
  player = require "SDK.Simulator.player"
  freetype = require "SDK.Simulator.freetype"
  sys = require "SDK.Simulator.sys"
end


local Object = require('toolkit.Object')
local EventListener = require('toolkit.EventListener')
local PlatformMenu = require('platform.PlatformMenu')
local Event = require('toolkit.Event')

local ProggLevels = require("games.Progg.levels.ProggLevels")
local GameProgress =require('toolkit.GameProgress')


PlatformContext = extends(Object)

-----------------------------------------------------------
-- Constructor method
--@return :PlatformMenu a new instance of PlatformMenu
-- @author Chuck
-----------------------------------------------------------
function PlatformContext:new()
  local o = PlatformContext:super()
  -- Platform contains a game which will be allocated when profile selected
  o.game = nil
  -- @member proggLevels:ProggLevels
  local proggLevels = ProggLevels:new()
  o.proggGameLevels = proggLevels:getProggLevels()

  -- Platform menu
  -- @member platformMenu:PlatformMenu
  o.platformMenu = PlatformMenu:new()

  -- Platform event listener
  -- @member platformEventListener:EventListener
  o.platformEventListener = EventListener:new(self)

  -- Attach menu object to listener
  o.platformEventListener:attach(o.platformMenu)

  -- @member profile:Profile
  o.profile = nil


  math.randomseed(os.time())

  --------------
  -- code
  --------------
  --UIKit example
  --o.window = UIStartWindowController:new()
  --o.platformEventListener:attach(o.window)
  return PlatformContext:init(o)
end
------------------------------------
--Allows a game to create a new menu, since the
--old menu is discarded when game is created.
-- @author Ludwig Wikblad
------------------------------------
function PlatformContext:createNewMenu(input)
  if input==nil then
  input = "games"
  end
  if self.platformMenu == nil then
    self.platformMenu = PlatformMenu:new()
    self.platformEventListener:attach(self.platformMenu)
    local newview = {}
    table.insert(newview, input)
    table.insert(newview, self.profile.name)
    self.platformMenu:changeview(newview)
    self.platformMenu:show()
  end
end

-----------------------------------------------------------
-- Load resources,such as images to platform context
-- @author Chuck
-----------------------------------------------------------
function PlatformContext:load()

-- self.platformMenu:loadImage()
--------------
-- code
--------------
end

----------------------------------------------------------
-- Show something on the screen when starting
-- @author Chuck
----------------------------------------------------------
function PlatformContext:show()
  --------------
  -- code
  --------------
  self.platformMenu:show()
  
  --UIKit example
  --self.window:presentView()
  gfx.update()
end



----------------------------------------------------------
-- Update the screen when something happens
-- @author Chuck
----------------------------------------------------------
function PlatformContext:update()
  if self.game ~= nil then
    self.game:update()
  end

  if self.platformMenu ~= nil then
    self.platformMenu:update()
  end
  
  --UIKit example
  --self.window:presentView()
  -- code
  gfx.update()
  --collectgarbage()
end

----------------------------------------------------------
-- Accept event and inform its event listener
-- there is something happening, after which it update itself
-- @param key The key that was pressed
-- @param state the state of the key, i.e. up, down or repeat
-- @author Chuck
----------------------------------------------------------
function PlatformContext:process(key,state)
  ADLogger.trace("OnKey("..key..","..state..")")
  local event = Event:new(key,state)
  self.platformEventListener:update(event)
  if event.state == Event.KEY_STATE_DOWN then
    self:update()
  end
end


return PlatformContext
