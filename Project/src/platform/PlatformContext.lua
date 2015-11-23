-----------------------------------------------------------
-- This class is for the platform context which is used
-- to create menu and all the objects related to platform
-- and to control the screen showing of all objects or
-- update screen
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
local UIStartWindowView = require('platform.UIStartWindowView')

PlatformContext = extends(Object)

-----------------------------------------------------------
-- Platform context is responsible for all the platform things
-----------------------------------------------------------
function PlatformContext:new()
  local o = PlatformContext:super()
  -- Platform contains a game which will be allocated when profile selected
  o.game = nil

  -- Platform menu
  -- @member platformMenu:PlatformMenu
  o.platformMenu = PlatformMenu:new()

  -- Platform event listener
  o.platformEventListener = EventListener:new(self)

  -- Attach menu object to listener
  o.platformEventListener:attach(o.platformMenu)
  
  o.window = UIStartWindowView
  
  o.platformEventListener:attach(o.window)
  --------------
  -- code
  --------------

  return PlatformContext:init(o)
end
------------------------------------
--Allows a game to create a new menu, since the
--old menu is discarded when game is created.
------------------------------------
function PlatformContext:createNewMenu()
  if self.platformMenu == nil then
    self.platformMenu = PlatformMenu:new()
    self.platformEventListener:attach(self.platformMenu)
    self.platformMenu:show()
  end
end

-----------------------------------------------------------
-- Load resources,such as images to platform context
-----------------------------------------------------------
function PlatformContext:load()

-- self.platformMenu:loadImage()
--------------
-- code
--------------
end

----------------------------------------------------------
-- Show something on the screen when starting
----------------------------------------------------------
function PlatformContext:show()
  --------------
  -- code
  --------------
  self.platformMenu:show()
  --self.window:show()
  gfx.update()
end



----------------------------------------------------------
-- Update the screen when something happens
----------------------------------------------------------
function PlatformContext:update()
  if self.game ~= nil then
    self.game:update()
  end

  if self.platformMenu ~= nil then
    self.platformMenu:update()
  end
  
  self.window:show()
  -- code
  gfx.update()
  --collectgarbage()
end

----------------------------------------------------------
-- Accept event and inform its event listener
-- there is something happening, after which it update itself
-- @event key event
----------------------------------------------------------
function PlatformContext:process(key,state)
  ADLogger.trace("OnKey("..key..","..state..")")
  local event = Event:new(key,state)
  self.platformEventListener:update(event)
  self:update()
end


return PlatformContext
