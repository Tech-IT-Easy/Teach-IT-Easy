--[[TEACH IT EASY, an educational games platform
    Copyright (C) 2015  Linköping University

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.


    MIT LICENSE:
    Copyright (c) 2015 Zenterio AB

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:



    The above copyright notice and this permission notice shall be included in
    all copies or substantial portions of the Software.


    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
    THE SOFTWARE.


    ]]
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
     o.image:premultiply()
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
    if #profiles ~= 4 then
    self.pos = 5
    end

  elseif event.key == Event.KEY_UP and self.pos == 5 and #profiles ~= 0 then

    self.pos = 1

  elseif event.key == Event.KEY_OK and self.pos < 5 then
      PlatformContext.profile = profiles[self.pos]
    return { "main"}

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
