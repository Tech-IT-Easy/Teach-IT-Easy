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

require("platform.PlatformContext")
require('toolkit.Events')

-- create global a game context
platformContext = PlatformContext:new()

-- listen keyboard events
function onKey(key,state)
  ADLogger.trace("OnKey("..key..","..state..")")
  
  -- state change and update buffer 
  platformContext:process(Events.formatSystemIdentifier[key]) 
  
end


-- load resources 

function onStart()
  
  ADLogger.trace("onStart")
  if ADConfig.isSimulator then
    if arg[#arg] == "-debug" then require("mobdebug").start() end
  end
  
  platformContext:load()
  platformContext:show()  
end

