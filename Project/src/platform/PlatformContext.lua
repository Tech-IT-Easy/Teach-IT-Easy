----------------------------------------------------
-- This class is for the platform context which is used 
-- to create menu and all the objects related to platform
-- and to control the screen showing of all objects or
-- update screen
-- 
-- Created by Chuck, Aug 16,2015
-- Updated by author,date
----------------------------------------------------



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


require('toolkit.Object')
require('toolkit.EventListener')
require('platform.PlatformMenu')



PlatformContext = Object:new()

----------------------------------------------------
-- Platform context responsible for all the platform things
----------------------------------------------------
function PlatformContext:new() 
  -- Platform contains a game which will be allocated when profile selected
  self.game = {}
  
  -- Platform menu
  self.platformMenu = PlatformMenu:new()
  
  -- Platform event listener 
  self.platformEventListener = EventListener:new()
  
  -- Attach menu object to listener
  self.platformEventListener:attach(self.platformMenu)
  
  --------------
  -- code
  --------------
  
  return self
end

function PlatformContext:load()

  -- self.platformMenu:loadImage()
  --------------
  -- code
  --------------
end

----------------------------------------------------
-- Show something on the screen 
----------------------------------------------------
function PlatformContext:show()
  -- code
  
  gfx.update()  
end



----------------------------------------------------
-- Update the screen when something happens
----------------------------------------------------
local function update()
  -- code
  gfx.update()
end

----------------------------------------------------
-- Accept events and inform its event listener 
-- something happening, after which update itself
-- @event key events
----------------------------------------------------
function PlatformContext:process(event)
  self.platformEventListener:update(self,event)
  self:update()
end


return PlatformContext