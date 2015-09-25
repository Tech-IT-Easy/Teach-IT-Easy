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


local icon_pos = {x = 450, y=200}
local icon = gfx.loadpng('data/logo.png')

function onKey(key,state)
  ADLogger.trace("OnKey("..key..","..state..")")
  screen:clear({g=65, r=2, b=100}, {x=450,y=200,w=300,height=300})
  if (key=='right') or (key=='left') or (key=='up') or (key=='down') then
    if key=='right' then       
      icon_pos.x = icon_pos.x + 2       
    end
    if key=='left' then icon_pos.x = icon_pos.x - 2 end
    if key=='up' then icon_pos.y = icon_pos.y - 2 end
    if key=='down' then icon_pos.y = icon_pos.y + 2 end
  end
    
  if icon then 
    screen:copyfrom(icon, nil, icon_pos,true)	
    gfx.update()
  end
end


function onStart()
  
  ADLogger.trace("onStart")
  if ADConfig.isSimulator then
    if arg[#arg] == "-debug" then require("mobdebug").start() end
  end
  
  --Clear the screen dark green
  screen:clear({g=50, r=0, b=0})
  
  --Load in a JPEG image
  local lena = gfx.loadjpeg('data/lena.jpg')

  local ft = sys.new_freetype({g=100, r=100, b=255, a=155}, 25, {x=15,y=39}, 'data/Pacifico.ttf')
  if ft then
    if lena then
      ft:draw_over_surface(lena, 'test')
    end
  end

  --Render at full size
  if lena then screen:copyfrom(lena, nil, {x=10,y=10},true)	end
  
  --Set alpha on image
  lena:set_alpha(100)
  --Render at quarter size
  if lena then screen:copyfrom(lena, nil, {x=300,y=10,w=lena:get_width() / 2, h=lena:get_height()/2},true)	end
  
  --Clear a few rectangles
  screen:clear({g=15, r=220, b=15}, {x=450,y=10,w=20,height=15})
  screen:clear({g=220, r=15, b=15}, {x=450,y=30,w=20,height=15})
  screen:fill({g=15, r=15, b=220}, {x=450,y=50,w=20,height=15})
  
  --Load in a PNG image
  local transparent_image = gfx.loadpng('data/transparency.png')
  
  --Render at full size
  if transparent_image then screen:copyfrom(transparent_image, nil, {x=10,y=300},true)	end
  
  
  --Set up a timer to render a random color box
  callback = function(timer)
    screen:clear({g=math.random()*255, r=math.random()*255, b=math.random()*255}, {x=475,y=10,w=55,height=55})
    gfx.update()
  end
  
  gfx.update()
  
  
  sys.new_timer(1000,"callback")
        
end


