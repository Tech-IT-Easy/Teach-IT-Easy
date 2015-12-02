local Super = require('toolkit.MenuSuperClass')
local Profile = require('platform.Profile')
local ProfileSelection = extends(Super)
local Event = require('toolkit.Event')
local LOCALE = require('i18n.main')

-- profiles

-- images
--[[local image1 = gfx.loadpng(profiles[1].avatar)
image1:premultiply()
local image2 = gfx.loadpng(profiles[2].avatar)
image2:premultiply()
local image3 = gfx.loadpng(profiles[3].avatar)
image3:premultiply()

images = { image1, image2, image3}]]

-------------------------------------
-- Creates the Profile selection-menu.
-- @return self. The created menu-object.
-- @author Erik/ Marcus
-------------------------------------
function ProfileSelection:new()
  local o = ProfileSelection:super()
  o.appnamebaseline = screen:get_height() * 0.08
  o.pagenamebaseline = screen:get_height() * 0.15

  o.images = {}

   for i in pairs(profiles) do
     o.image = gfx.loadpng(profiles[i].avatar)
     table.insert(o.images, o.image)
  end

  return ProfileSelection:init(o)
end

-------------------------------------
-- Handles the button-click sent from main.
-- @param key. Represent which button was pressed.
-- @return string. Either " " as standard or a string representing view to be changed to.
-- @author Erik/ Marcus
-------------------------------------
function ProfileSelection:handleinput(event)
  collectgarbage()
  self.lastpos = self.pos
  if event.key == Event.KEY_RIGHT and self.pos < #profiles then
    self.lastpos = self.pos
    self.pos = self.pos + 1

  elseif event.key == Event.KEY_LEFT and self.pos > 1 and self.pos < #profiles + 1 then

    self.pos = self.pos - 1
  elseif event.key == Event.KEY_DOWN then

    self.pos = 5

  elseif event.key == Event.KEY_UP and self.pos == 5 and #profiles ~= 0 then

    self.pos = 1

  elseif event.key == Event.KEY_OK and self.pos < 5 then
      PlatformContext.profile = profiles[self.pos]
    return { "main", profiles[self.pos].name}

  elseif event.key == Event.KEY_OK and self.pos == 5 and #profiles <4 then
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
  if #profiles ~= 0 then
    self.pos = 1
    self.lastpos = 1
  else
    self.pos = 5
    self.lastpos = 5
   end
  self:renderui()
end

-------------------------------------
-- Prints content on screen.
-- @author Erik/ Marcus
-------------------------------------
function ProfileSelection:renderui()
  prof_sel_appname:draw_over_surface(screen, LOCALE.APP_NAME)
  prof_sel_pagename:draw_over_surface(screen, LOCALE.PROFILE_SELECT)
  if #profiles ~=0 then
    self:active(1)
  else
    self:inactive(1)
  end
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
      screen:copyfrom(self.images[x1], nil, { x = (prof_sel_hspacing * x1) + prof_sel_itemwidth * (x1 - 1) + screen:get_width() * 0.01, y = prof_sel_itemy + screen:get_height() * 0.02, w = self.images[x1]:get_width() * 0.6, h = self.images[x1]:get_height() * 0.6 }, true)
    end
  else
    screen:clear({ g = 131, r = 0, b = 143 }, { x = 0, y = prof_sel_addprofiley, w = screen:get_width(), h = prof_sel_addprofileheight })
    screen:clear({ g = 255, r = 255, b = 255 }, { x = 0, y = prof_sel_activeaddprofiley, w = screen:get_width(), h = prof_sel_activeaddprofileheight })
    prof_sel_addprofileplus:draw_over_surface(screen, "+")
    prof_sel_addprofilename:draw_over_surface(screen, LOCALE.PROFILE_ADD)
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
      screen:copyfrom(self.images[x1], nil, { x = (prof_sel_hspacing * x1) + prof_sel_itemwidth * (x1 - 1) + screen:get_width() * 0.01, y = prof_sel_itemy + screen:get_height() * 0.02, w = self.images[x1]:get_width() * 0.6, h = self.images[x1]:get_height() * 0.6 }, true)
    end
  else
    screen:clear({ g = 228, r = 187, b = 235 }, { x = 0, y = prof_sel_addprofiley, w = screen:get_width(), h = prof_sel_addprofileheight })
    prof_sel_addprofileplus:draw_over_surface(screen, "+")
    prof_sel_addprofilename:draw_over_surface(screen, LOCALE.PROFILE_ADD)
  end
end

-------------------------------------
-- Print usernames to screen.
-- @author Erik/ Marcus
-------------------------------------
function ProfileSelection:printnames()
  local j = 1
  for i in pairs(profiles) do
    prof_sel_usernamefonts[j]:draw_over_surface(screen, profiles[i].name)
    print (profiles[i])
    j = j+1
  end

end

return ProfileSelection
