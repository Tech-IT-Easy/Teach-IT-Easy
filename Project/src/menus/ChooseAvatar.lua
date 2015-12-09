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
-- Menu class that represents the
-- menu for choosing avatar when creating
-- a new profile.
-- @author Marcus Fridén
-------------------------------------

-- Changed to extending empty super-menu
local Super = require('menus.AvatarSelection')
local ChooseAvatar = extends(Super)

local Profile = require('platform.Profile')

local Event = require('toolkit.Event')
local CreateProfile = require('menus.CreateProfile')

-------------------------------------
-- Creates a new menu
-- @return self:ChooseAvatar The created menu
-- @author Erik; Marcus
-------------------------------------
function ChooseAvatar:new()
  local o = ChooseAvatar:super()
  return ChooseAvatar:init(o)
end

-------------------------------------
-- Handles the input from the user
-- @param event The key pressed by the user
-- @return menu:String to navigate to or empty string
-- @author Erik; Marcus; Adam
-------------------------------------
function ChooseAvatar:handleinput(event)
  collectgarbage()

  self.imagestrings = {'data/avatar/cute_robot/DOWN.png',
    'data/avatar/insect_robot/DOWN.png',
    'data/avatar/strong_robot/DOWN.png',
    'data/avatar/fourth_robot/DOWN.png' }

  self.folderimagestrings = {"/cute_robot/", "/insect_robot/", "/strong_robot/", "/fourth_robot/" }


  self.lastpos = self.pos
  if event.key == Event.KEY_RIGHT and self.pos < #self.myimages then
    self.pos = self.pos + 1
  elseif event.key == Event.KEY_LEFT and self.pos > 1 then
    self.pos = self.pos - 1
  elseif (event.key == Event.KEY_OK) then

    self.image4 = self.myimages[self.pos]
    local profile = Profile:new(CreateProfile.profilename, self.imagestrings[self.pos], self.folderimagestrings[self.pos])
    table.insert(profiles, profile)
    PlatformContext.profile = profile

    collectgarbage()
    return { "main" }
  elseif (event.key == Event.KEY_BACK) then
    CreateProfile.profilename = ""
    return { "create" }
  end
  return {" "}
end

return ChooseAvatar
