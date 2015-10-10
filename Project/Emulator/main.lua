ADConfig = require("Config.ADConfig")
ADLogger = require("SDK.Utils.ADLogger")
ADLogger.trace("Applicatio Init")

local menu = {}

if ADConfig.isSimulator then
  gfx = require "SDK.Simulator.gfx"
  zto = require "SDK.Simulator.zto"
  surface = require "SDK.Simulator.surface"
  player = require "SDK.Simulator.player"
  freetype = require "SDK.Simulator.freetype"
  sys = require "SDK.Simulator.sys"
  script_path = ""
else
  script_path = sys.root_path()
end

local button_inactive = gfx.loadpng('data/activeitem.png')

local background = gfx.loadpng('data/background_h720.png')
local pos = 1;

local appnamebaseline = screen:get_height()*0.12
local pagenamebaseline = screen:get_height()*0.20
local itemy = screen:get_height()*0.32
local itemheight = screen:get_height()*0.28
local itemwidth = screen:get_width()*0.19
local activeheight = itemheight*0.96
local activey = itemy+((itemheight-activeheight)/2)
local activewidth = itemwidth*0.96
local hspacing = screen:get_width()*0.048
local profilenamebaseline = screen:get_height()*0.77
local addprofiley = screen:get_height()*0.84


function menu.setPos(new_pos)
  pos = new_pos
end

function menu.onKey(key,state)
  ADLogger.trace("OnKey("..key..","..state..")")
  if key == 'exit' then
    sys.stop()
  end
  if key == 'right' and state == 'down' and pos < 4 then
    pos = pos + 1
  end
  if key == 'left' and state == 'down' and pos > 1 then
    pos = pos - 1
  end
  if key == 'down' and state == 'down' then
    pos = 5
  end
  if key == 'up' and state == 'down' and pos == 5 then
    pos = 1
  end
  menu.renderUI()
  gfx.update()
  return pos
end

function onKey(key,state)
  menu.onKey(key,state)
end


function onStart()

  ADLogger.trace("onStart")
  if ADConfig.isSimulator then
    if arg[#arg] == "-debug" then require("mobdebug").start() end
  end
  screen:copyfrom(background, nil, {x=0,y=0,w=screen:get_width(), h=screen:get_height()},true)
  menu.renderUI()
  gfx.update()

end

function menu.active(x1)
  if x1==1 then
    screen:clear({g=131, r=0, b=143}, {x=hspacing, y=itemy, w=itemwidth, h= itemheight})
    screen:clear({g=255, r=255, b=255}, {x=hspacing + itemwidth*0.02 , y=activey, w=activewidth, h=activeheight})
  end

  if x1==2 then
    screen:clear({g=131, r=0, b=143}, {x=(hspacing*2)+itemwidth, y=itemy, w=itemwidth, h= itemheight})
    screen:clear({g=255, r=255, b=255}, {x=(hspacing*2)+itemwidth + itemwidth*0.02 , y=activey, w=activewidth, h=activeheight})
  end

  if x1==3 then
    screen:clear({g=131, r=0, b=143}, {x=(hspacing*3)+(itemwidth*2), y=itemy, w=itemwidth, h= itemheight})
    screen:clear({g=255, r=255, b=255}, {x=(hspacing*3)+(itemwidth*2) + itemwidth*0.02 , y=activey, w=activewidth, h=activeheight})
  end

  if x1==4 then
    screen:clear({g=131, r=0, b=143}, {x=(hspacing*4)+(itemwidth*3), y=itemy, w=itemwidth, h= itemheight})
    screen:clear({g=255, r=255, b=255}, {x=(hspacing*4)+(itemwidth*3) + itemwidth*0.02 , y=activey, w=activewidth, h=activeheight})
  end
end

function menu.inactive(x1)
  --screen:clear({g=228, r=187, b=235}, {x=x1, y=itemy, w=itemwidth, h=itemheight})

  if x1==1 then
    screen:clear({g=228, r=187, b=235}, {x=hspacing, y=itemy, w=itemwidth, h= itemheight})
  end

  if x1==2 then
    screen:clear({g=228, r=187, b=235}, {x=(hspacing*2)+itemwidth, y=itemy, w=itemwidth, h= itemheight})
  end

  if x1==3 then
    screen:clear({g=228, r=187, b=235}, {x=(hspacing*3)+(itemwidth*2), y=itemy, w=itemwidth, h= itemheight})
  end

  if x1==4 then
    screen:clear({g=228, r=187, b=235}, {x=(hspacing*4)+(itemwidth*3), y=itemy, w=itemwidth, h= itemheight})
  end
end

function menu.renderUI()

  if pos==1 then menu.active(1)
  else menu.inactive(1) end

  if pos==5 then screen:clear({g=131, r=0, b=143}, {x=0, y=580, w=screen:get_width(), h=button_inactive:get_height()*0.3})
    screen:clear({g=255, r=255, b=255}, {x=5, y=585, w=screen:get_width() - 10, h=button_inactive:get_height()*0.3 - 10})
  else screen:clear({g=228, r=187, b=235}, {x=0, y=580, w=screen:get_width(), h=button_inactive:get_height()*0.3}) end


  if pos==2 then menu.active(2)
  else menu.inactive(2) end

  if pos==3 then menu.active(3)
  else menu.inactive(3) end

  if pos==4 then menu.active(4)
  else menu.inactive(4) end

end

return menu