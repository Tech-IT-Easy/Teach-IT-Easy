ProfileSelection = {} --MenuView:new()

local Event = require('toolkit.Event')
-------------------------------------
-- Creates the Profile selection-menu.
-- @return self. The created menu-object.
-- @author Erik/ Marcus
-------------------------------------
function ProfileSelection:new()
  -- text placing
  self.appnamebaseline = screen:get_height() * 0.08
  self.pagenamebaseline = screen:get_height() * 0.15

  -- images
  self.image1 = gfx.loadpng('data/bowser.png')
  self.image2 = gfx.loadpng('data/mario.png')
  self.image3 = gfx.loadpng('data/toad.png')
  self.images = { self.image1, self.image2, self.image3 }

  -- usernames
  self.usernames = { "Erik", "Marcus", "Toad" }


  return self
end

-------------------------------------
-- Handles the button-click sent from main.
-- @param key. Represent which button was pressed.
-- @return string. Either " " as standard or a string representing view to be changed to.
-- @author Erik/ Marcus
-------------------------------------
function ProfileSelection:handleinput(event)
  collectgarbage()
  -- each menu will have its own function to handle remote input


  self.lastpos = self.pos
  if event.key == Event.KEY_RIGHT and self.pos < #self.usernames then
    self.lastpos = self.pos
    self.pos = self.pos + 1
  elseif event.key == Event.KEY_LEFT and self.pos > 1 and self.pos < #self.usernames + 1 then

    self.pos = self.pos - 1
  elseif event.key == Event.KEY_DOWN then

    self.pos = 5

  elseif event.key == Event.KEY_UP and self.pos == 5 then

    self.pos = 1

  elseif event.key == Event.KEY_ONE and self.pos < 5 then
    return { "main", self.usernames[self.pos] }

  elseif event.key == Event.KEY_ONE and self.pos == 5 then
    return { "create" }
  end

  return { " " }
end

function ProfileSelection:update()
  self:inactive(self.lastpos)
  self:active(self.pos)
end

-------------------------------------
-- Loads the view to the screen.
-- @author Erik/ Marcus
-------------------------------------
function ProfileSelection:loadview()
  self.pos = 1
  self.lastpos = 1
  --self:printbackground()
  self:renderui()
end

-------------------------------------
-- Prints background on screen.
-- @author Erik/ Marcus
-------------------------------------
function ProfileSelection:printbackground()
  self.background = gfx.loadpng("data/background_h720.png")
  screen:copyfrom(self.background, nil, { x = 0, y = 0, w = screen:get_width(), h = screen:get_height() }, true)
  self.background:destroy()
end

-------------------------------------
-- Prints content on screen.
-- @author Erik/ Marcus
-------------------------------------
function ProfileSelection:renderui()
  prof_sel_appname:draw_over_surface(screen, "TEACH IT EASY")
  prof_sel_pagename:draw_over_surface(screen, "SELECT YOUR PROFILE")
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
    screen:clear({ g = 131, r = 0, b = 143 }, { x = (prof_sel_hspacing * x1) + prof_sel_itemwidth * (x1 - 1), y = prof_sel_itemy, w = prof_sel_itemwidth, h = prof_sel_itemheight })
    screen:clear({ g = 255, r = 255, b = 255 }, { x = (prof_sel_hspacing * x1) + prof_sel_itemwidth * (x1 - 1) + prof_sel_itemwidth * 0.02, y = prof_sel_activey, w = prof_sel_activewidth, h = prof_sel_activeheight })
    if x1 < (#self.images + 1) then
      screen:copyfrom(self.images[x1], nil, { x = (prof_sel_hspacing * x1) + prof_sel_itemwidth * (x1 - 1) + screen:get_width() * 0.025, y = prof_sel_itemy + screen:get_height() * 0.045, w = self.image1:get_width() * 0.6, h = self.image1:get_height() * 0.6 }, true)
    end
  else
    screen:clear({ g = 131, r = 0, b = 143 }, { x = 0, y = prof_sel_addprofiley, w = screen:get_width(), h = prof_sel_addprofileheight })
    screen:clear({ g = 255, r = 255, b = 255 }, { x = 0, y = prof_sel_activeaddprofiley, w = screen:get_width(), h = prof_sel_activeaddprofileheight })
    prof_sel_addprofileplus:draw_over_surface(screen, "+")
    prof_sel_addprofilename:draw_over_surface(screen, "ADD A PROFILE")
  end
end

-------------------------------------
-- Prints an inactive button.
-- @param x1. Which place to print button to.
-- @author Erik/ Marcus
-------------------------------------
function ProfileSelection:inactive(x1)
  if x1 < 5 then
    screen:clear({ g = 228, r = 187, b = 235 }, { x = (prof_sel_hspacing * x1) + prof_sel_itemwidth * (x1 - 1), y = prof_sel_itemy, w = prof_sel_itemwidth, h = prof_sel_itemheight })
    if x1 < (#self.images + 1) then
      screen:copyfrom(self.images[x1], nil, { x = (prof_sel_hspacing * x1) + prof_sel_itemwidth * (x1 - 1) + screen:get_width() * 0.025, y = prof_sel_itemy + screen:get_height() * 0.045, w = self.image1:get_width() * 0.6, h = self.image1:get_height() * 0.6 }, true)
    end
  else
    screen:clear({ g = 228, r = 187, b = 235 }, { x = 0, y = prof_sel_addprofiley, w = screen:get_width(), h = prof_sel_addprofileheight })
    prof_sel_addprofileplus:draw_over_surface(screen, "+")
    prof_sel_addprofilename:draw_over_surface(screen, "ADD A PROFILE")
  end
end

-------------------------------------
-- Print usernames to screen.
-- @author Erik/ Marcus
-------------------------------------
function ProfileSelection:printnames()
  for i in pairs(self.usernames) do
    prof_sel_usernamefonts[i]:draw_over_surface(screen, self.usernames[i])
  end

end

return ProfileSelection
