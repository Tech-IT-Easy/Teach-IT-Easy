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
-- Menu class that represents the menu
-- for choosing profile name when
-- creating a new profile.
-------------------------------------

local Super = require('menus.InputName')
local CreateProfile = extends(Super)

local Event = require('toolkit.Event')
local ProfileSelection = require('menus.ProfileSelection')

-------------------------------------
-- Creates the Create profile-menu.
-- @return self:CreateProfile The created menu-object.
-- @author Erik/ Marcus
-------------------------------------

-- Must use ".self" otherwise it crashes in simulator when
-- trying to create profile, unknown reason why.. // Adam
function CreateProfile:new()
  local o = CreateProfile:super()
  --Profile name
  self.profilename = ""

  --Keyboard
  self.letters = { 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'DONE', '<--' }

  return self
end

-------------------------------------
-- Handles the button-click sent from main.
-- @param key. Represent which button was pressed.
-- @return string. Either " " as standard or a string representing view to be changed to.
-- @author Erik/ Marcus
-------------------------------------
function CreateProfile:handleinput(event)
  collectgarbage()
  self.lastpos = self.pos
  if event.key == Event.KEY_RIGHT and self.pos < #self.letters then
    self.pos = self.pos + 1
  elseif event.key == Event.KEY_LEFT and self.pos > 1 then
    self.pos = self.pos - 1
  elseif event.key == Event.KEY_DOWN and self.pos <= 18 then
    self.pos = self.pos + 10
  elseif event.key == Event.KEY_UP and self.pos >= 11 then
    self.pos = self.pos - 10
  elseif event.key == Event.KEY_OK and self.pos < 27 then
    if string.len(self.profilename) ~= 10 then
      self.profilename = self.profilename .. self.letters[self.pos] self:updatetext()
    end
  elseif event.key == Event.KEY_OK and self.pos == 27 then
    if string.len(self.profilename) ~= 0 then
      return { "chooseavatar" }
    end
  elseif event.key == Event.KEY_OK and self.pos == 28 then
    self.profilename = string.sub(self.profilename, 1, -2)
    self:updatetext()
  elseif event.key == Event.KEY_BACK then
    return { "profilesel"}
  end
  return { " " }
end

return CreateProfile
