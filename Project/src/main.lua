-----------------------------------------------------------
-- This class is main class for system starting. Main class
-- is like a system loop. All the procedure will be process
-- sub module. please never changed main class for game 
-- logic things
-- 
-- Main class only consists of platform context object which
-- will process all the logistic
-- 
-- @Author:Created by Chuck, Aug 16,2015
-- @Author:Updated by author,date
-----------------------------------------------------------
--
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

local PlatformContext= require("platform.PlatformContext")

-- create global a game context
platformContext = PlatformContext:new()

-----------------------------------------------------------
-- Listen keyboard events and trigger platform context listener
-----------------------------------------------------------
function onKey(key,state)
  -- ADLogger.trace("OnKey("..key..","..state..")")
  platformContext:process(key,state) 
end

-----------------------------------------------------------
-- System start only once where platform loads resources and
-- show start screen
-----------------------------------------------------------
function onStart()
  
  ADLogger.trace("onStart")
  if ADConfig.isSimulator then
    if arg[#arg] == "-debug" then require("mobdebug").start() end
  end
  
  platformContext:load()
  platformContext:show()  
end