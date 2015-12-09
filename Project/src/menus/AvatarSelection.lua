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
-------------------------------------
-- Menu class containing methods for
-- choosing avatar.
-- @author Marcus; Vilhelm
-- Date: 2015-11-04
-------------------------------------

-- Changed to extending empty super-menu
local Super = require('toolkit.MenuSuperClass')
local AvatarSelection = extends(Super)

local Profile = require('platform.Profile')

local Event = require('toolkit.Event')
local CreateProfile = require('menus.CreateProfile')
local LOCALE = require('i18n.main')


-------------------------------------
-- Creates a new menu
-- @return self:AvatarSelection The created menu
-- @author Erik; Marcus
-------------------------------------
function AvatarSelection:new()
  local o = AvatarSelection:super()
  return AvatarSelection:init(o)
end

-------------------------------------
-- Update menu when navigated in
-- @author Erik; Marcus
-------------------------------------
function AvatarSelection:update()
  if self.image1 then
    self:inactive(self.lastpos)
    self:active(self.pos)
  end
end

-------------------------------------
-- Loads the menu
-- @param input:String The username
-- @author Erik; Marcus
-------------------------------------
function AvatarSelection:loadview(input)
  self.pos = 1
  self.lastpos = 1
  self.username = input
  self.image1 = gfx.loadpng('data/avatar/cute_robot/DOWN.png')
  self.image1:premultiply()
  self.image2 = gfx.loadpng('data/avatar/insect_robot/DOWN.png')
  self.image2:premultiply()
  self.image3 = gfx.loadpng('data/avatar/strong_robot/DOWN.png')
  self.image3:premultiply()
  self.image4 = gfx.loadpng('data/avatar/fourth_robot/DOWN.png')
  self.image4:premultiply()
  self.myimages = { self.image1, self.image2, self.image3, self.image4 }
  self:renderui()
end

-------------------------------------
-- Prints a button as active
-- @param x1 Position of button
-- @author Erik
-------------------------------------
function AvatarSelection:active(x1)
  screen:clear({ g = 255, r = 255, b = 255 }, { x = screen:get_width() * 0.08 + (screen:get_width() * 0.22) * (x1 - 1), y = 270, w = screen:get_height() * 0.25, h = screen:get_height() * 0.25 })
  screen:copyfrom(self.myimages[x1], nil, { x = (prof_sel_hspacing * x1) + prof_sel_itemwidth * (x1 - 1)*0.90 + screen:get_width() * 0.04, y = 280, w = self.image1:get_width() * 0.45, h = self.image1:get_height() * 0.45 }, true)

end

-------------------------------------
-- Prints an inactive button.
-- @param x1. Which position to print button at.
-- @author Erik
-------------------------------------
function AvatarSelection:inactive(x1)
  screen:clear({ g = 228, r = 187, b = 235 }, { x = screen:get_width() * 0.08 + (screen:get_width() * 0.22) * (x1 - 1), y = 270, w = screen:get_height() * 0.25, h = screen:get_height() * 0.25 })
  screen:copyfrom(self.myimages[x1], nil, { x = (prof_sel_hspacing * x1) + prof_sel_itemwidth * (x1 - 1)*0.90 + screen:get_width() * 0.04, y = 280, w = self.image1:get_width() * 0.45, h = self.image1:get_height() * 0.45 }, true)

end

-------------------------------------
-- Loads initial screen of menu
-- @author Erik; Marcus
-------------------------------------
function AvatarSelection:renderui()
  create_prof_appname:draw_over_surface(screen, LOCALE.APP_NAME)
  create_prof_pagename:draw_over_surface(screen, LOCALE.AVATAR_CHOOSE)

  self:active(1)
  for i = 2, #self.myimages, 1 do
    self:inactive(i)
  end
end


return AvatarSelection
