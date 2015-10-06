ADConfig = require("Config.ADConfig")
ADLogger = require("SDK.Utils.ADLogger")
ADLogger.trace("Applicatio Init")

if ADConfig.isSimulator then

  gfx = require "SDK.Simulator.gfx"
  zto = require "SDK.Simulator.zto"
  surface = require "SDK.Simulator.surface"
  player = require "SDK.Simulator.player"
  freetype = require "SDK.Simulator.freetype"
  sys = require "SDK.Simulator.sys"
end

local button_inactive = gfx.loadpng('data/activeitem.png')

local background = gfx.loadpng('data/background.png')
local pos = 1;

function onKey(key,state)
  ADLogger.trace("OnKey("..key..","..state..")")
  if key == 'right' and state == 'down' and pos < 4 then pos = pos + 1 end
  if key == 'left' and state == 'down' and pos > 1 then pos = pos - 1 end
  if key == 'down' and state == 'down' then pos = 5 end
  if key == 'up' and state == 'down' and pos == 5 then pos = 1 end
  print(pos)
  renderUI()
  gfx.update()
end


function onStart()

  ADLogger.trace("onStart")
  if ADConfig.isSimulator then
    if arg[#arg] == "-debug" then require("mobdebug").start() end
    
    screen:copyfrom(background, nil, {x=0,y=0,w=screen:get_width(), h=screen:get_height()},true)
    renderUI()
    
  end

  gfx.update()

end

function active(x1, y2)
screen:fill({g=131, r=0, b=143}, {x=x1, y=y2, w=button_inactive:get_width() * 0.5, h=button_inactive:get_height()*0.5})
screen:fill({g=255, r=255, b=255}, {x=x1 + 5, y=y2 + 5, w=button_inactive:get_width() * 0.5 - 10, h=button_inactive:get_height()*0.5 - 10})
end

function inactive(x1, y2)
screen:fill({g=228, r=187, b=235}, {x=x1, y=y2, w=button_inactive:get_width() * 0.5, h=button_inactive:get_height()*0.5})
end

function renderUI()
  
  if pos==1 then active(150, 200)
  else inactive(150, 200) end

  if pos==5 then screen:fill({g=131, r=0, b=143}, {x=0, y=580, w=screen:get_width(), h=button_inactive:get_height()*0.3})
  screen:fill({g=255, r=255, b=255}, {x=5, y=585, w=screen:get_width() - 10, h=button_inactive:get_height()*0.3 - 10})
  else screen:fill({g=228, r=187, b=235}, {x=0, y=580, w=screen:get_width(), h=button_inactive:get_height()*0.3}) end
  
  if pos==2 then active(394, 200)
  else inactive(394, 200) end
  
  if pos==3 then active(638, 200)
  else inactive(638, 200) end
  
  if pos==4 then active(882, 200)
  else inactive(882, 200) end

end
