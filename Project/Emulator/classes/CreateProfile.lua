CreateProfile = {} --MenuView:new()

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


function CreateProfile:new()

  -- text placing
  self.appnamebaseline = screen:get_height()*0.08
  self.pagenamebaseline = screen:get_height()*0.15

  -- images
  self.background = gfx.loadpng("data/background_h720.png")

  -- fonts
  -- Needs to be changed to absolute path on STB, or implement solution
  self.appname = sys.new_freetype({g=255, r=255, b=255}, screen:get_height()*0.04, {x= screen:get_width()*0.43, y=self.appnamebaseline}, script_path..'data/BlackoutMidnight.ttf')
  self.pagename = sys.new_freetype({g=255, r=255, b=255}, screen:get_height()*0.07, {x= screen:get_width()*0.275, y=self.pagenamebaseline}, script_path..'data/Chalkduster.ttf')


  --Profile name
  self.profilename=""

  --Keyboard

  self.letters = {'A', 'B', 'C', 'DONE'}

  --Keys
  self.itemy = screen:get_height() *   0.6
  self.itemheight = screen:get_height() * 0.14
  self.itemwidth = screen:get_width() * 0.09
  self.activeheight = self.itemheight * 0.48
  self.activey = self.itemy + ((self.itemheight - self.activeheight) / 2)
  self.activewidth = self.itemwidth * 0.48
  self.hspacing = screen:get_width() * 0.048

  return self
end

function CreateProfile:handleinput(key)
  if key == 'right' and self.pos < #self.letters then self:inactive(self.pos) self.pos = self.pos + 1 self:active(self.pos) end
  if key == 'left' and self.pos > 1 then self:inactive(self.pos) self.pos = self.pos - 1 self:active(self.pos) end
  if key == '1' and self.pos < 4 then self.profilename = self.profilename..self.letters[self.pos] self:updatetext() return {" "}  end
  if key == '1' and self.pos == 4 then self:chooseavatar() return {" "} end
  return {" "}
end

--load view
function CreateProfile:loadview()
  self.pos = 1
  self:printbackground()
  self:renderui()

end

function CreateProfile:printbackground()
  screen:copyfrom(self.background, nil, {x=0,y=0,w=screen:get_width(), h=screen:get_height()},true)
end



function CreateProfile:renderui()

  self.appname:draw_over_surface(screen, "TEACH IT EASY")
  self.pagename:draw_over_surface(screen, "TYPE IN YOUR NAME")
  screen:clear({g=255, r=255, b=255}, {x=screen:get_width()*0.1, y=screen:get_height()*0.25 * 1.2, w=screen:get_width()*0.8, h= screen:get_height()*0.3 * 0.6})
  screen:clear({g=131, r=0, b=143}, {x=0, y=screen:get_height()*0.55, w=screen:get_width(), h= screen:get_height()*0.45})
  --self.keyletter:draw_over_surface(screen, self.letters[1])
  self:active(1)
  for i = 2, 4, 1 do
    self:inactive(i)
  end
end

    function CreateProfile:active(x1)
            screen:clear({ g = 255, r = 255, b = 255 }, { x = (self.hspacing * x1) + self.itemwidth * (x1 - 1), y = self.itemy, w = self.itemwidth, h = self.itemheight })
            screen:clear({ g = 255, r = 255, b = 255 }, { x = (self.hspacing * x1) + self.itemwidth * (x1 - 1) + self.itemwidth * 0.02, y = self.activey, w = self.activewidth, h = self.activeheight })

                self.keyletter = sys.new_freetype({g=131, r=0, b=143}, screen:get_height()*0.04, {x = (self.hspacing * x1) + self.itemwidth * (x1 - 1) + screen:get_width() * 0.025, y=self.itemy + screen:get_height() * 0.01}, script_path..'data/BlackoutMidnight.ttf')
                --screen:copyfrom(self.images[x1], nil, { x = (self.hspacing * x1) + self.itemwidth * (x1 - 1) + screen:get_width() * 0.025, y = self.itemy + screen:get_height() * 0.01, w = self.image1:get_width() * 0.6, h = self.image1:get_height() * 0.6 }, true)
                self.keyletter:draw_over_surface(screen, self.letters[x1])


    end

    function CreateProfile:inactive(x1)
            screen:clear({ g = 228, r = 187, b = 235 }, { x = (self.hspacing * x1) + self.itemwidth * (x1 - 1), y = self.itemy, w = self.itemwidth, h = self.itemheight })
            --if x1 < (#letters + 1) then
                 self.keyletter = sys.new_freetype({g=131, r=0, b=143}, screen:get_height()*0.04, {x = (self.hspacing * x1) + self.itemwidth * (x1 - 1) + screen:get_width() * 0.025, y=self.itemy + screen:get_height() * 0.01}, script_path..'data/BlackoutMidnight.ttf')
                --screen:copyfrom(self.images[x1], nil, { x = (self.hspacing * x1) + self.itemwidth * (x1 - 1) + screen:get_width() * 0.025, y = self.itemy + screen:get_height() * 0.01, w = self.image1:get_width() * 0.6, h = self.image1:get_height() * 0.6 }, true)
                self.keyletter:draw_over_surface(screen, self.letters[x1])
           -- end

    end

function CreateProfile:updatetext()
    screen:clear({g=255, r=255, b=255}, {x=screen:get_width()*0.1, y=screen:get_height()*0.25 * 1.2, w=screen:get_width()*0.8, h= screen:get_height()*0.3 * 0.6})
    self.typed = sys.new_freetype({g=131, r=0, b=143}, screen:get_height()*0.1 , {x = screen:get_width() * 0.11, y=screen:get_height() * 0.3 * 1.2}, script_path..'data/BlackoutMidnight.ttf')
    self.typed:draw_over_surface(screen, self.profilename)
end

function CreateProfile:chooseavatar()
    self:printbackground()
    self.appname:draw_over_surface(screen, "TEACH IT EASY")
    self.pagename:draw_over_surface(screen, "CHOOSE YOUR AVATAR")
end

return CreateProfile