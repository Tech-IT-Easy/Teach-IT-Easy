--require("classes.MenuView")

-- Inherits from MenuView

MainMenu = {} --MenuView:new()


function MainMenu:new()

  -- text placing
  self.appnamebaseline = screen:get_height()*0.08
  self.pagenamebaseline = screen:get_height()*0.15
  self.usernamebaseline = screen:get_height()*0.125

  -- images
  self.background = gfx.loadpng("data/background.png")

  -- fonts
  -- Needs to be changed to absolute path on STB, or implement solution
  self.appname = sys.new_freetype({g=255, r=255, b=255}, screen:get_height()*0.04, {x= screen:get_width()*0.43, y=self.appnamebaseline}, script_path..'data/BlackoutMidnight.ttf')
  self.pagename = sys.new_freetype({g=255, r=255, b=255}, screen:get_height()*0.07, {x= screen:get_width()*0.375, y=self.pagenamebaseline}, script_path..'data/Chalkduster.ttf')
  self.username = sys.new_freetype({g=255, r=255, b=255}, screen:get_height()*0.035, {x= screen:get_width()*0.15, y=self.usernamebaseline}, script_path..'data/GROBOLD.ttf')
  self.games = sys.new_freetype({g=131, r=0, b=143}, screen:get_height()*0.1, {x= screen:get_width()*0.15, y=(screen:get_height()*0.75)}, script_path..'data/GROBOLD.ttf')
  self.backbutton = sys.new_freetype({g=0, r=0, b=0}, screen:get_height()*0.03, { x=screen:get_width()*0.8103, y=screen:get_height()*0.08046}, script_path..'data/condensed.ttf')
  self.backtext = sys.new_freetype({g=255, r=255, b=255}, screen:get_height()*0.03, { x=screen:get_width()*0.765, y=screen:get_height()*0.125}, script_path..'data/GROBOLD.ttf')

  self.sidebuttons = {"Trophy room", "Wardrobe", "Settings"}

  return self
end


function MainMenu:handleinput(key)

  if key == 'right' and self.pos ==0 then
    self:gamebuttoninactive()
    self.pos = 1
    self:sidebuttonactive(self.pos)

  elseif key == 'down' and self.pos >0 and self.pos < 3 then
    self:sidebuttoninactive(self.pos)
    self.pos = self.pos + 1
    self:sidebuttonactive(self.pos)

  elseif key == 'up' and self.pos > 1 and self.pos < 4 then
    self:sidebuttoninactive(self.pos)
    self.pos = self.pos -1
    self:sidebuttonactive(self.pos)
  elseif key == 'left' and self.pos > 0 and self.pos < 4 then
    self:sidebuttoninactive(self.pos)
    self.pos = 0
    self:gamebuttonactive()
  elseif key == '1' and self.pos == 0 then
    return {"games", self.usernamestring}

  elseif key == 'backspace' then
    return {"profilesel"}
  else return {" "}
  end

end



function MainMenu:loadview(input)
  self.pos = 0
  self.usernamestring = input
  self:printbackground()

  self:renderui()
end

function MainMenu:printbackground()
  screen:copyfrom(self.background, nil, {x=0,y=0,w=screen:get_width(), h=screen:get_height()},true)
end



function MainMenu:renderui()

  self.appname:draw_over_surface(screen, "TEACH IT EASY")
  self.pagename:draw_over_surface(screen, "MAIN MENU")
  self.username:draw_over_surface(screen, self.usernamestring)
  screen:clear({g=228, r=187, b=235}, {x=screen:get_width()*0.08, y=screen:get_height()*0.09, w=screen:get_width()*0.06, h= screen:get_height()*0.1})
  self:gamebuttonactive()
  for i = 1, 3, 1 do
    self:sidebuttoninactive(i)
  end
  screen:clear({g=0, r=0, b=0}, {x=screen:get_width()*0.8, y=screen:get_height()*0.08, w=screen:get_width()*0.05, h= screen:get_height()*0.04})
  screen:clear({g=230, r=230, b=230}, {x=screen:get_width()*0.803, y=screen:get_height()*0.0845, w=screen:get_width()*0.0455, h= screen:get_height()*0.0308})
  self.backbutton:draw_over_surface(screen, "BACK")
  self.backtext:draw_over_surface(screen, "Change profile")


end

function MainMenu:gamebuttonactive()
  screen:clear({g=131, r=0, b=143}, {x=screen:get_width()*0.05, y=screen:get_height()*0.3, w=screen:get_width()*0.42, h= screen:get_height()*0.61})
  screen:clear({g=255, r=255, b=255}, {x=screen:get_width()*0.055 , y=(screen:get_height()*0.309), w=(screen:get_width()*0.41), h=(screen:get_height()*0.593)})
  self.games:draw_over_surface(screen, "Games")
end

function MainMenu:gamebuttoninactive()
  screen:clear({g=228, r=187, b=235}, {x=screen:get_width()*0.05, y=screen:get_height()*0.3, w=screen:get_width()*0.42, h= screen:get_height()*0.61})
  self.games:draw_over_surface(screen, "Games")
end

function MainMenu:sidebuttonactive(x)
  screen:clear({ g = 131, r = 0, b = 143 }, { x = screen:get_width()*0.5375, y = (screen:get_height()*0.3) + ((screen:get_height()*0.2125)*(x-1)) , w = screen:get_width()*0.425, h = screen:get_height()*0.185 })
  screen:clear({g=255, r=255, b=255}, {x=screen:get_width()*0.5425 , y=(screen:get_height()*0.309)+ ((screen:get_height()*0.2125)*(x-1)), w=(screen:get_width()*0.415), h=(screen:get_height()*0.1685)})

  local sidebuttontext = sys.new_freetype({ g = 131, r = 0, b = 143}, screen:get_height() * 0.07, { x = screen:get_width()*0.65, y = (screen:get_height()*0.36) + ((screen:get_height()*0.2125)*(x-1)) }, script_path .. 'data/GROBOLD.ttf')
  sidebuttontext:draw_over_surface(screen, self.sidebuttons[x])
end

function MainMenu:sidebuttoninactive(x)
  screen:clear({ g = 228, r = 187, b = 235 }, { x = screen:get_width()*0.5375, y = (screen:get_height()*0.3) + ((screen:get_height()*0.2125)*(x-1)) , w = screen:get_width()*0.425, h = screen:get_height()*0.185 })
  local sidebuttontext = sys.new_freetype({ g = 131, r = 0, b = 143}, screen:get_height() * 0.07, { x = screen:get_width()*0.65, y = (screen:get_height()*0.36) + ((screen:get_height()*0.2125)*(x-1)) }, script_path .. 'data/GROBOLD.ttf')
  sidebuttontext:draw_over_surface(screen, self.sidebuttons[x])
end



return MainMenu
