CreateProfile = {} --MenuView:new()


function CreateProfile:new()

  -- text placing
  --[[
  create_prof_appnamebaseline = screen:get_height() * 0.08
  create_prof_pagenamebaseline = screen:get_height() * 0.15

  -- images
  --create_prof_background = gfx.loadpng("data/background_h720.png")

  --Keys
  create_prof_itemy = screen:get_height() * 0.6
  create_prof_itemheight = screen:get_height() * 0.14
  create_prof_itemwidth = screen:get_width() * 0.09
  create_prof_activeheight = create_prof_itemheight * 0.48
  create_prof_activey = create_prof_itemy + ((create_prof_itemheight - create_prof_activeheight) / 2)
  create_prof_activewidth = create_prof_itemwidth * 0.48
  create_prof_hspacing = screen:get_width() * 0.048
  
  -- fonts
  -- Needs to be changed to absolute path on STB, or implement solution
  create_prof_appname = sys.new_freetype({g=255, r=255, b=255, a=255}, screen:get_height()*0.04, {x= screen:get_width()*0.43, y=create_prof_appnamebaseline}, script_path..'data/BlackoutMidnight.ttf')
  create_prof_pagename = sys.new_freetype({g=255, r=255, b=255, a=255}, screen:get_height()*0.07, {x= screen:get_width()*0.275, y=create_prof_pagenamebaseline}, script_path..'data/Chalkduster.ttf')
  
  create_prof_keyletter1 = sys.new_freetype({g=131, r=0, b=143, a=255}, screen:get_height()*0.04, {x = (create_prof_hspacing) + screen:get_width() * 0.025, y=create_prof_itemy + screen:get_height() * 0.01}, script_path..'data/BlackoutMidnight.ttf')
  create_prof_keyletter2 = sys.new_freetype({g=131, r=0, b=143, a=255}, screen:get_height()*0.04, {x = (create_prof_hspacing * 2) + create_prof_itemwidth + screen:get_width() * 0.025, y=create_prof_itemy + screen:get_height() * 0.01}, script_path..'data/BlackoutMidnight.ttf')
  create_prof_keyletter3 = sys.new_freetype({g=131, r=0, b=143, a=255}, screen:get_height()*0.04, {x = (create_prof_hspacing * 3) + create_prof_itemwidth * 2 + screen:get_width() * 0.025, y=create_prof_itemy + screen:get_height() * 0.01}, script_path..'data/BlackoutMidnight.ttf')
  create_prof_keyletter4 = sys.new_freetype({g=131, r=0, b=143, a=255}, screen:get_height()*0.04, {x = (create_prof_hspacing * 4) + create_prof_itemwidth * 3 + screen:get_width() * 0.025, y=create_prof_itemy + screen:get_height() * 0.01}, script_path..'data/BlackoutMidnight.ttf')
  
  create_prof_keyletters = {create_prof_keyletter1, create_prof_keyletter2, create_prof_keyletter3, create_prof_keyletter4}
  
  create_prof_typed = sys.new_freetype({g=131, r=0, b=143, a=255}, screen:get_height()*0.1 , {x = screen:get_width() * 0.11, y=screen:get_height() * 0.3 * 1.2}, script_path..'data/BlackoutMidnight.ttf')
  ]]
  
  --Profile name
  self.profilename = ""

  --Keyboard
  self.letters = { 'A', 'B', 'C', 'DONE' }

  return self
end

function CreateProfile:handleinput(key)
  collectgarbage()
  -- if key == 'right' and create_prof_pos < #create_prof_letters then self:inactive(create_prof_pos) create_prof_pos = create_prof_pos + 1 self:active(create_prof_pos) end
  if key == 'right' and self.pos < #self.letters then
    self:inactive(self.pos) self.pos = self.pos + 1 self:active(self.pos)
  elseif key == 'left' and self.pos > 1 then
    self:inactive(self.pos) self.pos = self.pos - 1 self:active(self.pos)
  elseif key == '1' and self.pos < 4 then
    self.profilename = self.profilename .. self.letters[self.pos] self:updatetext()
  elseif key == '1' and self.pos == 4 then
    self:chooseavatar()
  elseif key == '2' then
    return { "profilesel", " " }
  end
  return { " " }
end

--load view
function CreateProfile:loadview()
  self.pos = 1
  --self:printbackground()
  self:renderui()
end

function CreateProfile:printbackground()
  self.background = gfx.loadpng("data/background_h720.png")
  screen:copyfrom(self.background, nil, { x = 0, y = 0, w = screen:get_width(), h = screen:get_height() }, true)
  self.background:destroy()
end



function CreateProfile:renderui()

  create_prof_appname:draw_over_surface(screen, "TEACH IT EASY")
  create_prof_pagename:draw_over_surface(screen, "TYPE IN YOUR NAME")
  screen:clear({ g = 255, r = 255, b = 255 }, { x = screen:get_width() * 0.1, y = screen:get_height() * 0.25 * 1.2, w = screen:get_width() * 0.8, h = screen:get_height() * 0.3 * 0.6 })
  screen:clear({ g = 131, r = 0, b = 143 }, { x = 0, y = screen:get_height() * 0.55, w = screen:get_width(), h = screen:get_height() * 0.45 })
  --create_prof_keyletter:draw_over_surface(screen, create_prof_letters[1])
  self:active(1)
  for i = 2, 4, 1 do
    self:inactive(i)
  end
end

function CreateProfile:active(x1)
  screen:clear({ g = 255, r = 255, b = 255 }, { x = (create_prof_hspacing * x1) + create_prof_itemwidth * (x1 - 1), y = create_prof_itemy, w = create_prof_itemwidth, h = create_prof_itemheight })
  screen:clear({ g = 255, r = 255, b = 255 }, { x = (create_prof_hspacing * x1) + create_prof_itemwidth * (x1 - 1) + create_prof_itemwidth * 0.02, y = create_prof_activey, w = create_prof_activewidth, h = create_prof_activeheight })

  --create_prof_keyletter = sys.new_freetype({g=131, r=0, b=143, a=255}, screen:get_height()*0.04, {x = (create_prof_hspacing * x1) + create_prof_itemwidth * (x1 - 1) + screen:get_width() * 0.025, y=create_prof_itemy + screen:get_height() * 0.01}, script_path..'data/BlackoutMidnight.ttf')
  --screen:copyfrom(create_prof_images[x1], nil, { x = (create_prof_hspacing * x1) + create_prof_itemwidth * (x1 - 1) + screen:get_width() * 0.025, y = create_prof_itemy + screen:get_height() * 0.01, w = create_prof_image1:get_width() * 0.6, h = create_prof_image1:get_height() * 0.6 }, true)
  create_prof_keyletters[x1]:draw_over_surface(screen, self.letters[x1])
end

function CreateProfile:inactive(x1)
  screen:clear({ g = 228, r = 187, b = 235 }, { x = (create_prof_hspacing * x1) + create_prof_itemwidth * (x1 - 1), y = create_prof_itemy, w = create_prof_itemwidth, h = create_prof_itemheight })
  if x1 < (#self.letters + 1) then
    --create_prof_keyletter = sys.new_freetype({g=131, r=0, b=143, a=255}, screen:get_height()*0.04, {x = (create_prof_hspacing * x1) + create_prof_itemwidth * (x1 - 1) + screen:get_width() * 0.025, y=create_prof_itemy + screen:get_height() * 0.01}, script_path..'data/BlackoutMidnight.ttf')
    --screen:copyfrom(create_prof_images[x1], nil, { x = (create_prof_hspacing * x1) + create_prof_itemwidth * (x1 - 1) + screen:get_width() * 0.025, y = create_prof_itemy + screen:get_height() * 0.01, w = create_prof_image1:get_width() * 0.6, h = create_prof_image1:get_height() * 0.6 }, true)
    create_prof_keyletters[x1]:draw_over_surface(screen, self.letters[x1])
  end
end

function CreateProfile:updatetext()
  screen:clear({ g = 255, r = 255, b = 255 }, { x = screen:get_width() * 0.1, y = screen:get_height() * 0.25 * 1.2, w = screen:get_width() * 0.8, h = screen:get_height() * 0.3 * 0.6 })
  --create_prof_typed = sys.new_freetype({g=131, r=0, b=143, a=255}, screen:get_height()*0.1 , {x = screen:get_width() * 0.11, y=screen:get_height() * 0.3 * 1.2}, script_path..'data/BlackoutMidnight.ttf')
  create_prof_typed:draw_over_surface(screen, self.profilename)
end

function CreateProfile:chooseavatar()
  self:printbackground()
  --create_prof_appname:draw_over_surface(screen, "TEACH IT EASY")
  --create_prof_pagename:draw_over_surface(screen, "CHOOSE YOUR AVATAR")
end

return CreateProfile
