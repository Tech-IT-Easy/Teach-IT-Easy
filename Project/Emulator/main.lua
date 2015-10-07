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

--Interface scaling variables
local appnamebaseline = screen:get_height()*0.08
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
local addprofileheight = screen:get_height()*0.16
local activeaddprofileheight = addprofileheight * 0.96
local activeaddprofiley = addprofiley+(addprofileheight-activeaddprofileheight)

--Fonts
local appname = sys.new_freetype({g=131, r=0, b=143}, 25, {x= screen:get_width()*0.45, y=appnamebaseline}, 'data/BlackoutMidnight.ttf')



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
    appname:draw_over_surface(screen, "TEACH IT EASY")
    renderUI()


  end

  gfx.update()

end

function active(x1)
  if x1==1 then
    screen:fill({g=131, r=0, b=143}, {x=hspacing, y=itemy, w=itemwidth, h= itemheight})
    screen:fill({g=255, r=255, b=255}, {x=hspacing + itemwidth*0.02 , y=activey, w=activewidth, h=activeheight})
  end

  if x1==2 then
    screen:fill({g=131, r=0, b=143}, {x=(hspacing*2)+itemwidth, y=itemy, w=itemwidth, h= itemheight})
    screen:fill({g=255, r=255, b=255}, {x=(hspacing*2)+itemwidth + itemwidth*0.02 , y=activey, w=activewidth, h=activeheight})
  end

  if x1==3 then
    screen:fill({g=131, r=0, b=143}, {x=(hspacing*3)+(itemwidth*2), y=itemy, w=itemwidth, h= itemheight})
    screen:fill({g=255, r=255, b=255}, {x=(hspacing*3)+(itemwidth*2) + itemwidth*0.02 , y=activey, w=activewidth, h=activeheight})
  end

  if x1==4 then
    screen:fill({g=131, r=0, b=143}, {x=(hspacing*4)+(itemwidth*3), y=itemy, w=itemwidth, h= itemheight})
    screen:fill({g=255, r=255, b=255}, {x=(hspacing*4)+(itemwidth*3) + itemwidth*0.02 , y=activey, w=activewidth, h=activeheight})
  end
end

function inactive(x1)
  --screen:fill({g=228, r=187, b=235}, {x=x1, y=itemy, w=itemwidth, h=itemheight})

  if x1==1 then
    screen:fill({g=228, r=187, b=235}, {x=hspacing, y=itemy, w=itemwidth, h= itemheight})
  end

  if x1==2 then
    screen:fill({g=228, r=187, b=235}, {x=(hspacing*2)+itemwidth, y=itemy, w=itemwidth, h= itemheight})
  end

  if x1==3 then
    screen:fill({g=228, r=187, b=235}, {x=(hspacing*3)+(itemwidth*2), y=itemy, w=itemwidth, h= itemheight})
  end

  if x1==4 then
    screen:fill({g=228, r=187, b=235}, {x=(hspacing*4)+(itemwidth*3), y=itemy, w=itemwidth, h= itemheight})
  end
end

function renderUI()

  if pos==1 then active(1)
  else inactive(1) end

  if pos==5 then screen:fill({g=131, r=0, b=143}, {x=0, y=addprofiley, w=screen:get_width(), h=addprofileheight})
    screen:fill({g=255, r=255, b=255}, {x=0, y=activeaddprofiley, w=screen:get_width(), h=activeaddprofileheight})
  else screen:fill({g=228, r=187, b=235}, {x=0, y=addprofiley, w=screen:get_width(), h=addprofileheight}) end


  if pos==2 then active(2)
  else inactive(2) end

  if pos==3 then active(3)
  else inactive(3) end

  if pos==4 then active(4)
  else inactive(4) end

end
