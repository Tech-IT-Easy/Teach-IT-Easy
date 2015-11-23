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
local EventTimer= require("toolkit.EventTimer")
-- create global a game context
platformContext = PlatformContext:new()

-----------------------------------------------------------
-- Listen keyboard events and trigger platform context listener
-----------------------------------------------------------
function onKey(key,state)
  -- ADLogger.trace("OnKey("..key..","..state..")")
  if key == 'exit' then
    sys.stop()
  end
  platformContext:process(key,state) 
  collectgarbage()
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
  
  --[[
  timeEvent must be a global variables
  callback must be a string type
  ]]--
  
  timeEvent = function(timer)
    print("I am timer")
  end
  timer = EventTimer:new{intervalMillisec=1000*1,callback="timeEvent"}
  -- timer:start() defaultly 
  
  timer:stop()
  
  
  
  -- If you want to test Chuck's refactoring in Mario, uncommment this two lines
  --local NiceMarioHelpTest = require("games.mario.NiceMarioHelpTest")
  --NiceMarioHelpTest:run()
end

