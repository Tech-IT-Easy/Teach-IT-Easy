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

local GameProgress =require('toolkit.GameProgress')

local UIStartWindowController = require('platform.UIStartWindowController')


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

  -- Platform menu
  -- @member platformMenu:PlatformMenu
  o.platformMenu = PlatformMenu:new()

  -- Platform event listener
  -- @member platformEventListener:EventListener
  o.platformEventListener = EventListener:new(self)

  -- Attach menu object to listener
  o.platformEventListener:attach(o.platformMenu)

  -- @member gameProgress:GameProgress
  o.gameprogress = GameProgress:new()

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
function PlatformContext:createNewMenu()
  if self.platformMenu == nil then
    self.platformMenu = PlatformMenu:new()
    self.platformEventListener:attach(self.platformMenu)
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
