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

--local button_active = gfx.loadpng('data/activeitem.png')
--local button_one = {255, 0, 0, 0}
local button_inactive = gfx.loadpng('data/activeitem.png')
--button_inactive:set_alpha(150)
--local pos_one = "{x=150, y=200,w=button_active:get_width() * 0.5, h=button_active:get_height()*0.5}"
--local pos_two = "{x=394,y=200,w=button_inactive:get_width() * 0.5, h=button_inactive:get_height()*0.5}"
--local button_three = gfx.loadpng('data/activeitem.png')
--local button_four = screen:fill({g=236, r=238, b=225}, {x=0, y=0, w=1280, height=600})
local background = gfx.loadpng('data/background.png')
local pos = 1;
--positions = {pos_one, pos_two}


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

    --screen:fill({g=236, r=238, b=225}, {x=0, y=0, w=1280, height=600})
    --screen:fill({g=187, r=155, b=89}, {x=0, y=600, w=1280, height=120})
    
    screen:copyfrom(background, nil, {x=0,y=0,w=screen:get_width()*0.5, h=screen:get_height()},true)
    renderUI()
    --[[
    screen:fill({g=89, r=200, b=89}, {x=150, y=200, w=button_inactive:get_width() * 0.5, h=button_inactive:get_height()*0.5})
    screen:fill({g=187, r=155, b=89}, {x=394, y=200, w=button_inactive:get_width() * 0.5, h=button_inactive:get_height()*0.5})
    screen:fill({g=187, r=155, b=89}, {x=638, y=200, w=button_inactive:get_width() * 0.5, h=button_inactive:get_height()*0.5})
    screen:fill({g=187, r=155, b=89}, {x=882, y=200, w=button_inactive:get_width() * 0.5, h=button_inactive:get_height()*0.5})
    screen:fill({g=187, r=155, b=89}, {x=0, y=620, w=button_inactive:get_width() * 5, h=button_inactive:get_height()*0.2})
    ]]--
    
    --[[screen:copyfrom(button_active, nil, {x=150,y=200,w=button_inactive:get_width() * 0.5, h=button_inactive:get_height()*0.5},true)
    screen:copyfrom(button_inactive, nil, {x=394,y=200,w=button_inactive:get_width() * 0.5, h=button_inactive:get_height()*0.5},true)
    screen:copyfrom(button_inactive, nil, {x=638,y=200,w=button_inactive:get_width() * 0.5, h=button_inactive:get_height()*0.5},true)
    screen:copyfrom(button_inactive, nil, {x=882,y=200,w=button_inactive:get_width() * 0.5 , h=button_inactive:get_height()*0.5},true)
    screen:copyfrom(button_inactive, nil, {x=-60,y=620,w=button_inactive:get_width() * 5 , h=button_inactive:get_height()*0.2},true)
    --]]
    --screen:copyfrom({g=255, r=255, b=255,nil, a=100}, {x=75, y=100, w=200, h=300,},true)
    --button_one:set_alpha(150)    
  --  screen:copyfrom(button_one, nil, {x=75,y=100,w=button_one:get_width(), h=button_one:get_height()},true)
    --screen:copyfrom(button_two, nil, {x=75,y=100,w=button_one:get_width(), h=button_one:get_height()},true)
    --screen:copyfrom(button_three, nil, {x=75,y=100,w=button_one:get_width(), h=button_one:get_height()},true)
    --screen:copyfrom(button_four, nil, {x=75,y=100,w=button_one:get_width(), h=button_one:get_height()},true)
    

  end


  gfx.update()


  --sys.new_timer(1000,"callback")

end

function renderUI()
  
  if pos==1 then screen:fill({g=89, r=200, b=89}, {x=150, y=200, w=button_inactive:get_width() * 0.5, h=button_inactive:get_height()*0.5})
  else screen:fill({g=187, r=155, b=89}, {x=150, y=200, w=button_inactive:get_width() * 0.5, h=button_inactive:get_height()*0.5}) end
  
  --[[if pos==2 then screen:fill({g=89, r=200, b=89}, {x=394, y=200, w=button_inactive:get_width() * 0.5, h=button_inactive:get_height()*0.5})
  else screen:fill({g=187, r=155, b=89}, {x=150, y=200, w=button_inactive:get_width() * 0.5, h=button_inactive:get_height()*0.5}) end
  
  if pos==3 then screen:fill({g=89, r=200, b=89}, {x=638, y=200, w=button_inactive:get_width() * 0.5, h=button_inactive:get_height()*0.5})
  else screen:fill({g=187, r=155, b=89}, {x=150, y=200, w=button_inactive:get_width() * 0.5, h=button_inactive:get_height()*0.5}) end
  
  if pos==4 then screen:fill({g=89, r=200, b=89}, {x=882, y=200, w=button_inactive:get_width() * 0.5, h=button_inactive:get_height()*0.5})
  else screen:fill({g=187, r=155, b=89}, {x=150, y=200, w=button_inactive:get_width() * 0.5, h=button_inactive:get_height()*0.5}) end
  ]]--
  if pos==5 then screen:fill({g=89, r=200, b=89}, {x=0, y=580, w=button_inactive:get_width() * 5, h=button_inactive:get_height()*0.3})
  else screen:fill({g=187, r=155, b=89}, {x=0, y=580, w=button_inactive:get_width() * 5, h=button_inactive:get_height()*0.3}) end
  
  if pos==2 then screen:fill({g=89, r=200, b=89}, {x=394, y=200, w=button_inactive:get_width() * 0.5, h=button_inactive:get_height()*0.5})
  else screen:fill({g=187, r=155, b=89}, {x=394, y=200, w=button_inactive:get_width() * 0.5, h=button_inactive:get_height()*0.5}) end
  
  if pos==3 then screen:fill({g=89, r=200, b=89}, {x=638, y=200, w=button_inactive:get_width() * 0.5, h=button_inactive:get_height()*0.5})
  else screen:fill({g=187, r=155, b=89}, {x=638, y=200, w=button_inactive:get_width() * 0.5, h=button_inactive:get_height()*0.5}) end
  
  if pos==4 then screen:fill({g=89, r=200, b=89}, {x=882, y=200, w=button_inactive:get_width() * 0.5, h=button_inactive:get_height()*0.5})
  else screen:fill({g=187, r=155, b=89}, {x=882, y=200, w=button_inactive:get_width() * 0.5, h=button_inactive:get_height()*0.5}) end
  --[[if pos == 1 then screen:copyfrom(button_active, nil, {x=150,y=200,w=button_active:get_width() * 0.5, h=button_active:get_height()*0.5},true)
  else screen:copyfrom(button_inactive, nil, {x=150,y=200,w=button_inactive:get_width() * 0.5, h=button_inactive:get_height()*0.5},true)
  end
  if pos == 2 then screen:copyfrom(button_active, nil, {x=394,y=200,w=button_active:get_width() * 0.5, h=button_active:get_height()*0.5}, true)
  else screen:copy(button_inactive, nil, {x=394,y=200,w=button_inactive:get_width() * 0.5, h=button_inactive:get_height()*0.5}, true)
  end
  --[[if pos == 3 then button_three:set_aplha(255)
  else button_three:set_alpha(150)
  end
  if pos == 4 then button_four:set_alpha(255)
  else button_four:set_alpha(150)
  end--]]
  --button_two:set_alpha(150)  
  --screen:copyfrom(button_one, nil, {x=75,y=100,w=button_one:get_width() * 0.7, h=button_one:get_height()*0.7},true)
  --screen:copyfrom(button_two, nil, {x=450,y=100,w=button_one:get_width() * 1.5, h=button_one:get_height()*1.5},true)
  --screen:copyfrom(button_three, nil, {x=825,y=100,w=button_one:get_width() * 1.5, h=button_one:get_height()*1.5},true)
  --screen:copyfrom(button_four, nil, {x=850,y=620,w=button_four:get_width() * 1.2 , h=button_one:get_height() /4},true)
end
