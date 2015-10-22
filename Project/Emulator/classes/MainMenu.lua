MainMenu = {} --MenuView:new()

-------------------------------------
-- Creates the Main menu.
-- @return self. The created menu-object.
-- @author Erik
-------------------------------------
function MainMenu:new()

  self.oursurface = gfx.new_surface(screen:get_width(), screen:get_height())

  -- text placing
  self.appnamebaseline = self.oursurface:get_height() * 0.08
  self.pagenamebaseline = self.oursurface:get_height() * 0.15
  self.usernamebaseline = self.oursurface:get_height() * 0.125

  -- images
  self.background = gfx.loadpng("data/background_h720.png")

  -- fonts
  self.appname = sys.new_freetype({g=255, r=255, b=255}, self.oursurface:get_height()*0.04, {x= self.oursurface:get_width()*0.43, y=self.appnamebaseline}, script_path..'data/BlackoutMidnight.ttf')
  self.pagename = sys.new_freetype({g=255, r=255, b=255}, self.oursurface:get_height()*0.07, {x= self.oursurface:get_width()*0.375, y=self.pagenamebaseline}, script_path..'data/Chalkduster.ttf')
  self.username = sys.new_freetype({g=255, r=255, b=255}, self.oursurface:get_height()*0.035, {x= self.oursurface:get_width()*0.15, y=self.usernamebaseline}, script_path..'data/GROBOLD.ttf')
  self.games = sys.new_freetype({g=131, r=0, b=143}, self.oursurface:get_height()*0.1, {x= self.oursurface:get_width()*0.15, y=(self.oursurface:get_height()*0.75)}, script_path..'data/condensed.ttf')
  self.backbutton = sys.new_freetype({g=0, r=0, b=0}, self.oursurface:get_height()*0.03, { x=self.oursurface:get_width()*0.8103, y=self.oursurface:get_height()*0.08046}, script_path..'data/condensed.ttf')
  self.backtext = sys.new_freetype({g=255, r=255, b=255}, self.oursurface:get_height()*0.03, { x=self.oursurface:get_width()*0.765, y=self.oursurface:get_height()*0.125}, script_path..'data/GROBOLD.ttf')

  --self.sidebuttons = { "Trophy room", "Wardrobe", "Settings" }

  return self
end

-------------------------------------
-- Handles the button-click sent from main.
-- @param key. Represent which button was pressed.
-- @return string. Either " " as standard or a string representing view to be changed to.
-- @author Erik
-------------------------------------
function MainMenu:handleinput(key)

  if key == 'right' and self.pos == 0 then
    self:gamebuttoninactive()
    self.pos = 1
    self:sidebuttonactive(self.pos)

  elseif key == 'down' and self.pos > 0 and self.pos < 3 then
    self:sidebuttoninactive(self.pos)
    self.pos = self.pos + 1
    self:sidebuttonactive(self.pos)

  elseif key == 'up' and self.pos > 1 and self.pos < 4 then
    self:sidebuttoninactive(self.pos)
    self.pos = self.pos - 1
    self:sidebuttonactive(self.pos)
  elseif key == 'left' and self.pos > 0 and self.pos < 4 then
    self:sidebuttoninactive(self.pos)
    self.pos = 0
    self:gamebuttonactive()
  elseif key == '1' and self.pos == 0 then
    return { "games", self.usernamestring }

  elseif key == 'backspace' then
    return { "profilesel" }
  end

  return { " " }
end


-------------------------------------
-- Loads the view to the self.oursurface.
-- @author Erik
-------------------------------------
function MainMenu:loadview(input)
  self.pos = 0
  self.sidebuttons = { "Trophy room", "Wardrobe", "Settings" }
  self.usernamestring = "Test"
  self:printbackground()
  self:renderui()
end

-------------------------------------
-- Prints background on self.oursurface.
-- @author Erik
-------------------------------------
function MainMenu:printbackground()
  self.oursurface:copyfrom(self.background, nil, { x = 0, y = 0, w = self.oursurface:get_width(), h = self.oursurface:get_height() }, true)
end


-------------------------------------
-- Prints content on self.oursurface.
-- @author Erik
-------------------------------------
function MainMenu:renderui()

  self.appname:draw_over_surface(self.oursurface, "TEACH IT EASY")
  self.pagename:draw_over_surface(self.oursurface, "MAIN MENU")
  self.username:draw_over_surface(self.oursurface, self.usernamestring)
  self.oursurface:clear({ g = 228, r = 187, b = 235 }, { x = self.oursurface:get_width() * 0.08, y = self.oursurface:get_height() * 0.09, w = self.oursurface:get_width() * 0.06, h = self.oursurface:get_height() * 0.1 })
  self:gamebuttonactive()
  for i = 1, 3, 1 do
    self:sidebuttoninactive(i)
  end
  self.oursurface:clear({ g = 0, r = 0, b = 0 }, { x = self.oursurface:get_width() * 0.8, y = self.oursurface:get_height() * 0.08, w = self.oursurface:get_width() * 0.05, h = self.oursurface:get_height() * 0.04 })
  self.oursurface:clear({ g = 230, r = 230, b = 230 }, { x = self.oursurface:get_width() * 0.803, y = self.oursurface:get_height() * 0.0845, w = self.oursurface:get_width() * 0.0455, h = self.oursurface:get_height() * 0.0308 })
  self.backbutton:draw_over_surface(self.oursurface, "BACK")
  self.backtext:draw_over_surface(self.oursurface, "Change profile")
end

-------------------------------------
-- Prints an active gamebutton.
-- @author Erik
-------------------------------------
function MainMenu:gamebuttonactive()
  self.oursurface:clear({ g = 131, r = 0, b = 143 }, { x = self.oursurface:get_width() * 0.05, y = self.oursurface:get_height() * 0.3, w = self.oursurface:get_width() * 0.42, h = self.oursurface:get_height() * 0.61 })
  self.oursurface:clear({ g = 255, r = 255, b = 255 }, { x = self.oursurface:get_width() * 0.055, y = (self.oursurface:get_height() * 0.309), w = (self.oursurface:get_width() * 0.41), h = (self.oursurface:get_height() * 0.593) })
  self.games:draw_over_surface(self.oursurface, "Games")
end

-------------------------------------
-- Prints an inactive gamebutton.
-- @author Erik
-------------------------------------
function MainMenu:gamebuttoninactive()
  self.oursurface:clear({ g = 228, r = 187, b = 235 }, { x = self.oursurface:get_width() * 0.05, y = self.oursurface:get_height() * 0.3, w = self.oursurface:get_width() * 0.42, h = self.oursurface:get_height() * 0.61 })
  self.games:draw_over_surface(self.oursurface, "Games")
end

-------------------------------------
-- Prints an active sidebutton.
-- @param x. Which place to print button.
-- @author Erik
-------------------------------------
function MainMenu:sidebuttonactive(x)
  self.oursurface:clear({ g = 131, r = 0, b = 143 }, { x = self.oursurface:get_width() * 0.5375, y = (self.oursurface:get_height() * 0.3) + ((self.oursurface:get_height() * 0.2125) * (x - 1)), w = self.oursurface:get_width() * 0.425, h = self.oursurface:get_height() * 0.185 })
  self.oursurface:clear({ g = 255, r = 255, b = 255 }, { x = self.oursurface:get_width() * 0.5425, y = (self.oursurface:get_height() * 0.309) + ((self.oursurface:get_height() * 0.2125) * (x - 1)), w = (self.oursurface:get_width() * 0.415), h = (self.oursurface:get_height() * 0.1685) })

  local sidebuttontext = sys.new_freetype({ g = 131, r = 0, b = 143}, self.oursurface:get_height() * 0.07, { x = self.oursurface:get_width()*0.65, y = (self.oursurface:get_height()*0.36) + ((self.oursurface:get_height()*0.2125)*(x-1)) }, script_path .. 'data/condensed.ttf')
  sidebuttontext:draw_over_surface(self.oursurface, self.sidebuttons[x])
end

-------------------------------------
-- Prints an inactive sidebutton.
-- @param x. Which place to print button.
-- @author Erik
-------------------------------------
function MainMenu:sidebuttoninactive(x)
  self.oursurface:clear({ g = 228, r = 187, b = 235 }, { x = self.oursurface:get_width() * 0.5375, y = (self.oursurface:get_height() * 0.3) + ((self.oursurface:get_height() * 0.2125) * (x - 1)), w = self.oursurface:get_width() * 0.425, h = self.oursurface:get_height() * 0.185 })
  local sidebuttontext = sys.new_freetype({ g = 131, r = 0, b = 143}, self.oursurface:get_height() * 0.07, { x = self.oursurface:get_width()*0.65, y = (self.oursurface:get_height()*0.36) + ((self.oursurface:get_height()*0.2125)*(x-1)) }, script_path .. 'data/condensed.ttf')
  sidebuttontext:draw_over_surface(self.oursurface, self.sidebuttons[x])
end

function MainMenu:updatescreen()
  screen:copyfrom(self.oursurface,nil,nil,false)
end

function MainMenu:remove()
  self.oursurface:destroy()
end


return MainMenu
