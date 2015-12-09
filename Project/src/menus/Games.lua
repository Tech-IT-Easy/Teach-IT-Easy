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
-- showing the different games.
-------------------------------------

local Super = require('toolkit.MenuSuperClass')
local Games = extends(Super)
local Event = require('toolkit.Event')
local GameFactory = require('games.GameFactory')
local LOCALE = require('i18n.main')

-------------------------------------
-- Creates the Games menu.
-- @return self The created menu-object.
-- @author Erik
-------------------------------------
function Games:new()
  local o = Games:super()
  o.gameFactory = GameFactory:new()
  o.games = o.gameFactory.gameMatrix
  return Games:init(o)
end

-------------------------------------
-- Handles the button-click sent from main.
-- @param key. Represent which button was pressed.
-- @return string. Either " " as standard or a string representing view to be changed to.
-- @author Erik
-------------------------------------
function Games:handleinput(event)
  collectgarbage()
  self.lastpos = self.pos
  if event.key == Event.KEY_RIGHT and self.pos < #self.games then
     self.pos = self.pos + 1
  elseif event.key == Event.KEY_LEFT and self.pos > 1 then
    self.pos = self.pos - 1
  elseif event.key == Event.KEY_BACK then
    return { "main" }
  elseif event.key == Event.KEY_OK and self.pos == 1 then
    return{"selectlevel"}
  elseif event.key == Event.KEY_OK then
    platformContext.game = self.gameFactory:getGame(self.games[self.pos][1],platformContext)
    if platformContext.game ~= nil then
      platformContext.game:start()
      platformContext.platformEventListener:remove(platformContext.platformMenu)
      platformContext.platformMenu = nil
    end
    collectgarbage()
  end
  return { " " }
end


function Games:update()
  self:buttoninactive(self.lastpos)
  self:buttonactive(self.pos)
end
-------------------------------------
-- Loads the view to the screen.
-- @author Erik
-------------------------------------
function Games:loadview()
    self.pos = 1
    self.lastpos = 1
    self.usernamestring = platformContext.profile.name
    self:renderui()
end

-------------------------------------
-- Prints content on screen.
-- @author Erik
-------------------------------------
function Games:renderui()

  local avatarImageUrl = platformContext.profile.avatar
  self.avatarImage = gfx.loadpng(avatarImageUrl)
  self.avatarImage:premultiply()
  local proggGameURL = "data/tie24_prog.png"
  self.proggGameImage = gfx.loadpng(proggGameURL)
  self.proggGameImage:premultiply()

  local anotherGameURL = "data/tie24_reading.png"
  self.anotherGameImage = gfx.loadpng(anotherGameURL)
  self.anotherGameImage:premultiply()

self.gameLogos = {self.proggGameImage,
    self.anotherGameImage
}

    screen:copyfrom(self.avatarImage, nil, { x = screen:get_width() * 0.08, y = screen:get_height() *0.09, w = screen:get_width() * 0.06, h = screen:get_height() * 0.1 })

    local image1 = gfx.loadpng(platformContext.profile.avatar)
    image1:premultiply()

    games_appname:draw_over_surface(screen, LOCALE.APP_NAME)
    games_pagename:draw_over_surface(screen, LOCALE.GAME_CHOOSE)
    games_username:draw_over_surface(screen, PlatformContext.profile.name)

    --screen:copyfrom(image1, nil, { x = screen:get_width() * 0.08, y = screen:get_height() * 0.09, w = screen:get_width() * 0.06, h = screen:get_height() * 0.1 })

    self:buttonactive(1)
    for i = 2, #self.games, 1 do
        self:buttoninactive(i)
    end
    screen:clear({ g = 0, r = 0, b = 0 }, { x = screen:get_width() * 0.8, y = screen:get_height() * 0.08, w = screen:get_width() * 0.05, h = screen:get_height() * 0.04 })
    screen:clear({ g = 230, r = 230, b = 230 }, { x = screen:get_width() * 0.803, y = screen:get_height() * 0.0845, w = screen:get_width() * 0.0455, h = screen:get_height() * 0.0308 })
    games_backbutton:draw_over_surface(screen, LOCALE.BACK)
    games_backtext:draw_over_surface(screen, LOCALE.BACK_HELP)
end

-------------------------------------
-- Prints an active gamebutton.
-- @param x. Which place to print button at.
-- @author Erik
-------------------------------------
function Games:buttonactive(x1)
  screen:clear({ g = 255, r = 255, b = 255 }, { x = screen:get_width() * 0.08 + (screen:get_width() * 0.22) * (x1 - 1), y = (screen:get_height() * 0.28), w = screen:get_width() * 0.18, h = screen:get_height() * 0.45 })
  screen:copyfrom(self.gameLogos[x1], nil, { x = screen:get_width() * 0.095 + (screen:get_width() * 0.22) * (x1 - 1),  y = (screen:get_height() * 0.32), w = screen:get_width() * 0.15,  h = screen:get_height() * 0.25 })
  games_gamesfonts[x1]:draw_over_surface(screen, self.games[x1][1])
  games_trophiesfonts[x1]:draw_over_surface(screen, LOCALE.PROGRESS .. ": " .. platformContext.profile.gameprogress:getprogressStart(self.games[x1][2]))
end

-------------------------------------
-- Prints an inactive gamebutton.
-- @param x. Which place to print button at.
-- @author Erik
-------------------------------------
function Games:buttoninactive(x1)
  screen:clear({ g = 228, r = 187, b = 235 }, { x = screen:get_width() * 0.08 + (screen:get_width() * 0.22) * (x1 - 1), y = (screen:get_height() * 0.28), w = screen:get_width() * 0.18, h = screen:get_height() * 0.45 })
  screen:copyfrom(self.gameLogos[x1], nil, { x = screen:get_width() * 0.095 + (screen:get_width() * 0.22) * (x1 - 1),  y = (screen:get_height() * 0.32), w = screen:get_width() * 0.15,  h = screen:get_height() * 0.25 })
  games_gamesfonts[x1]:draw_over_surface(screen, self.games[x1][1])
  games_trophiesfonts[x1]:draw_over_surface(screen, LOCALE.PROGRESS .. ": " .. platformContext.profile.gameprogress:getprogressStart(self.games[x1][2]))
end

return Games
