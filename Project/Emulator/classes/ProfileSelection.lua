ProfileSelection = {} --MenuView:new()


-------------------------------------
-- Creates the Profile selection-menu.
-- @return self. The created menu-object.
-- @author Erik/ Marcus
-------------------------------------
function ProfileSelection:new()

  self.oursurface = gfx.new_surface(screen:get_width(), screen:get_height())
  -- text placing
  self.appnamebaseline = self.oursurface:get_height() * 0.08
  self.pagenamebaseline = self.oursurface:get_height() * 0.15
  -- Fonts
  self.appname = sys.new_freetype({ g = 255, r = 255, b = 255 }, self.oursurface:get_height() * 0.04, { x = self.oursurface:get_width() * 0.43, y = self.appnamebaseline }, script_path .. 'data/BlackoutMidnight.ttf')

  -- images
  self.background = gfx.loadpng("data/background_h720.png")
  --self.image1 = gfx.loadpng('data/bowser.png')
  --self.image2 = gfx.loadpng('data/mario.png')
  --self.image3 = gfx.loadpng('data/toad.png')
  --self.images = { self.image1, self.image2, self.image3 }

  -- usernames
  self.usernames = { "Erik", "Marcus", "Toad" }

  -- fonts
  self.pagename = sys.new_freetype({ g = 255, r = 255, b = 255 }, self.oursurface:get_height() * 0.07, { x = self.oursurface:get_width() * 0.24, y = self.pagenamebaseline }, script_path .. 'data/GROBOLD.ttf')
  self.addprofileplus = sys.new_freetype({ g = 131, r = 0, b = 143 }, self.oursurface:get_height() * 0.075, { x = self.oursurface:get_width() * 0.35, y = self.oursurface:get_height() * 0.883 }, script_path .. 'data/BlackoutMidnight.ttf')
  self.addprofilename = sys.new_freetype({ g = 131, r = 0, b = 143 }, self.oursurface:get_height() * 0.05, { x = self.oursurface:get_width() * 0.38, y = self.oursurface:get_height() * 0.88 }, script_path .. 'data/condensed.ttf')


  -- varibles for placing
  self.itemy = self.oursurface:get_height() * 0.32
  self.itemheight = self.oursurface:get_height() * 0.35
  self.itemwidth = self.oursurface:get_width() * 0.19
  self.activeheight = self.itemheight * 0.96
  self.activey = self.itemy + ((self.itemheight - self.activeheight) / 2)
  self.activewidth = self.itemwidth * 0.96
  self.hspacing = self.oursurface:get_width() * 0.048
  self.addprofiley = self.oursurface:get_height() * 0.84
  self.addprofileheight = self.oursurface:get_height() * 0.16
  self.activeaddprofileheight = self.addprofileheight * 0.96
  self.activeaddprofiley = self.addprofiley + (self.addprofileheight - self.activeaddprofileheight)


  return self
end

-------------------------------------
-- Handles the button-click sent from main.
-- @param key. Represent which button was pressed.
-- @return string. Either " " as standard or a string representing view to be changed to.
-- @author Erik/ Marcus
-------------------------------------
function ProfileSelection:handleinput(key)
  -- each menu will have its own function to handle remote input
  if key == 'right' and self.pos < #self.usernames then
    self:inactive(self.pos)
    self.pos = self.pos + 1
    self:active(self.pos)
  elseif key == 'left' and self.pos > 1 and self.pos < #self.usernames + 1 then
    self:inactive(self.pos)
    self.pos = self.pos - 1
    self:active(self.pos)

  elseif key == 'down' then
    self:inactive(self.pos)
    self.pos = 5
    self:active(self.pos)

  elseif key == 'up' and self.pos == 5 then
    self:inactive(self.pos)
    self.pos = 1
    self:active(self.pos)

  elseif key == '1' and self.pos < 5 then
    return { "main", self.usernames[self.pos] }

  elseif key == '1' and self.pos == 5 then
    return { "create" }
  end

  return { " " }
end

-------------------------------------
-- Loads the view to the self.oursurface.
-- @author Erik/ Marcus
-------------------------------------
function ProfileSelection:loadview()
  self.pos = 1
  self:printbackground()
  self:renderui()
end

-------------------------------------
-- Prints background on self.oursurface.
-- @author Erik/ Marcus
-------------------------------------
function ProfileSelection:printbackground()
  self.oursurface:copyfrom(self.background, nil, { x = 0, y = 0, w = self.oursurface:get_width(), h = self.oursurface:get_height() }, true)
end

-------------------------------------
-- Prints content on self.oursurface.
-- @author Erik/ Marcus
-------------------------------------
function ProfileSelection:renderui()
  self.appname:draw_over_surface(self.oursurface, "TEACH IT EASY")
  self.pagename:draw_over_surface(self.oursurface, "SELECT YOUR PROFILE")
  self:active(1)
  for i = 2, 5, 1 do
    self:inactive(i)
  end
  self:printnames()
end

-------------------------------------
-- Prints an active button.
-- @param x1. Which place to print button to.
-- @author Erik/ Marcus
-------------------------------------
function ProfileSelection:active(x1)
  if x1 < 5 then
    self.oursurface:clear({ g = 131, r = 0, b = 143 }, { x = (self.hspacing * x1) + self.itemwidth * (x1 - 1), y = self.itemy, w = self.itemwidth, h = self.itemheight })
    self.oursurface:clear({ g = 255, r = 255, b = 255 }, { x = (self.hspacing * x1) + self.itemwidth * (x1 - 1) + self.itemwidth * 0.02, y = self.activey, w = self.activewidth, h = self.activeheight })
    --if x1 < (#self.images + 1) then
    --  self.oursurface:copyfrom(self.images[x1], nil, { x = (self.hspacing * x1) + self.itemwidth * (x1 - 1) + self.oursurface:get_width() * 0.025, y = self.itemy + self.oursurface:get_height() * 0.045, w = self.image1:get_width() * 0.6, h = self.image1:get_height() * 0.6 }, true)
    --end
  else
    self.oursurface:clear({ g = 131, r = 0, b = 143 }, { x = 0, y = self.addprofiley, w = self.oursurface:get_width(), h = self.addprofileheight })
    self.oursurface:clear({ g = 255, r = 255, b = 255 }, { x = 0, y = self.activeaddprofiley, w = self.oursurface:get_width(), h = self.activeaddprofileheight })
    self.addprofileplus:draw_over_surface(self.oursurface, "+")
    self.addprofilename:draw_over_surface(self.oursurface, "ADD A PROFILE")
  end
end

-------------------------------------
-- Prints an inactive button.
-- @param x1. Which place to print button to.
-- @author Erik/ Marcus
-------------------------------------
function ProfileSelection:inactive(x1)
  if x1 < 5 then
    self.oursurface:clear({ g = 228, r = 187, b = 235 }, { x = (self.hspacing * x1) + self.itemwidth * (x1 - 1), y = self.itemy, w = self.itemwidth, h = self.itemheight })
    --if x1 < (#self.images + 1) then
    --  self.oursurface:copyfrom(self.images[x1], nil, { x = (self.hspacing * x1) + self.itemwidth * (x1 - 1) + self.oursurface:get_width() * 0.025, y = self.itemy + self.oursurface:get_height() * 0.045, w = self.image1:get_width() * 0.6, h = self.image1:get_height() * 0.6 }, true)
    --end
  else
    self.oursurface:clear({ g = 228, r = 187, b = 235 }, { x = 0, y = self.addprofiley, w = self.oursurface:get_width(), h = self.addprofileheight })
    self.addprofileplus:draw_over_surface(self.oursurface, "+")
    self.addprofilename:draw_over_surface(self.oursurface, "ADD A PROFILE")
  end
end

-------------------------------------
-- Print usernames to self.oursurface.
-- @author Erik/ Marcus
-------------------------------------
function ProfileSelection:printnames()
  for i in pairs(self.usernames) do
    local username = sys.new_freetype({ g = 255, r = 255, b = 255 }, self.oursurface:get_height() * 0.05, { x = (self.hspacing * i) + self.itemwidth * (i - 1), y = self.itemy + self.itemheight * 1.05 }, script_path .. 'data/Chalkduster.ttf')
    username:draw_over_surface(self.oursurface, self.usernames[i])
  end
end

function ProfileSelection:updatescreen()
  screen = self.oursurface
end

function ProfileSelection:remove()
  self.oursurface:destroy()
end


return ProfileSelection
