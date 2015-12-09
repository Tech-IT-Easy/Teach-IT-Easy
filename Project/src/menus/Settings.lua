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
------------------------------------
-- Menu class representing the settings
-- menu page.
------------------------------------

-- MainMenu = {} --MenuView:new()
-- Changed to extending empty super-menu
local Super = require('toolkit.MenuSuperClass')
local Settings = extends(Super)

local Event = require('toolkit.Event')
local LOCALE = require('i18n.main')
-------------------------------------
-- Creates the Main menu.
-- @return self. The created menu-object.
-- @author Vilhelm
-------------------------------------
function Settings:new()
    local o = Settings:super()
    o.buttonfonts = { settings_buttontext1, settings_buttontext2, settings_buttontext3 }
    return Settings:init(o)
end

-------------------------------------
-- Handles the button-click sent from main.
-- @param key. Represent which button was pressed.
-- @return string. Either " " as standard or a string representing view to be changed to.
-- @author Vilhelm
-------------------------------------
function Settings:handleinput(event)

    collectgarbage()
    self.lastpos = self.pos

    if event.key == Event.KEY_DOWN and self.pos < 2 then
        self.pos = self.pos + 1
    elseif event.key == Event.KEY_UP and self.pos > 0 then
        self.pos = self.pos - 1
    elseif event.key == Event.KEY_OK and self.pos == 0 then
        return { "updatename" }
    elseif event.key == Event.KEY_OK and self.pos == 1 then
        return { "updateavatar"}
    elseif event.key == Event.KEY_OK and self.pos == 2 then

        local function table_invert(t)
           local s={}
           for k,v in pairs(t) do
             s[v]=k
           end
           return s
        end
        local profIndex = table_invert(profiles)[platformContext.profile]
        profiles[profIndex] = nil

        local function CleanNils(t)
          local ans = {}
          for _,v in pairs(t) do
            ans[ #ans+1 ] = v
          end
          return ans
        end

        profiles = CleanNils(profiles)



        collectgarbage()
        --return { "delete", self.usernamestring }
        return { "profilesel" }
    elseif event.key == Event.KEY_BACK then
        return { "main" }
    end

    return { " " }
end

-------------------------------------
-- Updates the view
-- @author Vilhelm
-------------------------------------
function Settings:update()
    self:inactive(self.lastpos)
    self:active(self.pos)
end


-------------------------------------
-- Loads the view to the screen.
-- @param input:String the username
-- @author Vilhelm
-------------------------------------
function Settings:loadview()
    self.pos = 0
    self.lastpos = self.pos
    self.buttons = { LOCALE.EDIT_NAME, LOCALE.EDIT_AVATAR, LOCALE.DELETE_PROFILE }
    self.usernamestring = platformContext.profile.name
    --self:printbackground()
    self:renderui()
end

-------------------------------------
-- Prints background on screen.
-- @author Erik
-------------------------------------
function Settings:printbackground()
    self.background = gfx.loadpng("data/background_h720.png")
    screen:copyfrom(self.background, nil, { x = 0, y = 0, w = screen:get_width(), h = screen:get_height() }, true)
    self.background:destroy()
end


-------------------------------------
-- Prints content on screen.
-- @author Vilhelm
-------------------------------------
function Settings:renderui()

    main_menu_appname:draw_over_surface(screen, LOCALE.APP_NAME)
    settings_menu_pagename:draw_over_surface(screen, LOCALE.SETTINGS_MAIN)
    main_menu_username:draw_over_surface(screen, platformContext.profile.name)

    local avatarImageUrl = platformContext.profile.avatar

    self.avatarImage = gfx.loadpng(avatarImageUrl)
    self.avatarImage:premultiply()

    screen:copyfrom(self.avatarImage, nil, { x = screen:get_width() * 0.08, y = screen:get_height() * 0.09, w = screen:get_width() * 0.06, h = screen:get_height() * 0.1 })

    for i = 0, 2, 1 do
        self:inactive(i)
    end

    screen:clear({ g = 0, r = 0, b = 0 }, { x = screen:get_width() * 0.8, y = screen:get_height() * 0.08, w = screen:get_width() * 0.05, h = screen:get_height() * 0.04 })
    screen:clear({ g = 230, r = 230, b = 230 }, { x = screen:get_width() * 0.803, y = screen:get_height() * 0.0845, w = screen:get_width() * 0.0455, h = screen:get_height() * 0.0308 })
    main_menu_backbutton:draw_over_surface(screen, LOCALE.BACK)
    main_menu_backtext:draw_over_surface(screen, LOCALE.PROFILE_CHANGE)
end

-------------------------------------
-- Prints an active button.
-- @param x1. Which place to print button.
-- @author Vilhelm
-------------------------------------
function Settings:active(x1)
    screen:clear({ g = 131, r = 0, b = 143 }, { x = screen:get_width() * 0.05, y = (screen:get_height() * 0.3) + ((screen:get_height() * 0.2125) * (x1)), w = screen:get_width() * 0.9, h = screen:get_height() * 0.185 })
    screen:clear({ g = 255, r = 255, b = 255 }, { x = screen:get_width() * 0.055, y = (screen:get_height() * 0.309) + ((screen:get_height() * 0.2125) * (x1)), w = (screen:get_width() * 0.890), h = (screen:get_height() * 0.1685) })
    --screen:copyfrom(self.activeImages[x1], nil, { x = screen:get_width() * 0.5475, y = screen:get_height() * 0.33 + ((screen:get_height() * 0.2125) * (x1 - 1)), w = screen:get_width() * 0.090, h = screen:get_height() * 0.125 })

    self.buttonfonts[x1+1]:draw_over_surface(screen, self.buttons[x1+1])
end

-------------------------------------
-- Prints an inactive button.
-- @param x1. Which place to print button.
-- @author Vilhelm
-------------------------------------
function Settings:inactive(x1)
    screen:clear({ g = 228, r = 187, b = 235 }, { x = screen:get_width() * 0.05, y = (screen:get_height() * 0.3) + ((screen:get_height() * 0.2125) * (x1)), w = screen:get_width() * 0.9, h = screen:get_height() * 0.185 })
    --screen:copyfrom(self.inactiveImages[x1], nil, { x = screen:get_width() * 0.5475, y = screen:get_height() *0.33 + ((screen:get_height() * 0.2125) * (x1 - 1)), w = screen:get_width() * 0.090, h = screen:get_height() * 0.125 })

    self.buttonfonts[x1+1]:draw_over_surface(screen, self.buttons[x1+1])
end

return Settings
