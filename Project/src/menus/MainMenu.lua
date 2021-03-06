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
-- Menu class that represents the main
-- menu that is shown after selecting
-- profile.
------------------------------------

local Super = require('toolkit.MenuSuperClass')
local MainMenu = extends(Super)
local Event = require('toolkit.Event')
local LOCALE = require('i18n.main')

-------------------------------------
-- Creates the Main menu.
-- @return self. The created menu-object.
-- @author Erik
-------------------------------------
function MainMenu:new()
    local o = MainMenu:super()
    o.sidebuttonfonts = { main_menu_sidebuttontext1, main_menu_sidebuttontext2, main_menu_sidebuttontext3 }
    return MainMenu:init(o)
end

-------------------------------------
-- Handles the button-click sent from main.
-- @param key. Represent which button was pressed.
-- @return string. Either " " as standard or a string representing view to be changed to.
-- @author Erik
-------------------------------------
function MainMenu:handleinput(event)

    collectgarbage()
    self.lastpos = self.pos

    if event.key == Event.KEY_RIGHT and self.pos == 0 then
        self.pos = 1
    elseif event.key == Event.KEY_DOWN and self.pos > 0 and self.pos < 3 then
        self.pos = self.pos + 1
    elseif event.key == Event.KEY_UP and self.pos > 1 and self.pos < 4 then
        self.pos = self.pos - 1
    elseif event.key == Event.KEY_LEFT and self.pos > 0 and self.pos < 4 then
        self.pos = 0
    elseif event.key == Event.KEY_OK and self.pos == 0 then
        return { "games" }
    elseif event.key == Event.KEY_OK and self.pos == 1 then
        return { "trophy" }
    elseif event.key == Event.KEY_OK and self.pos == 2 then
        return { "instructions"}
    elseif event.key == Event.KEY_OK and self.pos == 3 then
        return { "settings"}

    elseif event.key == Event.KEY_BACK then
        return { "profilesel" }
    end

    return { " " }
end

-------------------------------------
-- Updates the view
-- @author Erik
-------------------------------------
function MainMenu:update()
    if self.lastpos == 0 then
        self:gamebuttoninactive()
    else
        self:sidebuttoninactive(self.lastpos)
    end
    if self.pos == 0 then
        self:gamebuttonactive()
    else
        self:sidebuttonactive(self.pos)
    end
end


-------------------------------------
-- Loads the view to the screen.
-- @param input:String the username
-- @author Erik
-------------------------------------
function MainMenu:loadview()
    self.pos = 0
    self.lastpos = self.pos
    self.sidebuttons = { LOCALE.MENU_MAIN_TROPHY_ROOM, LOCALE.MENU_MAIN_INSTRUCTIONS, LOCALE.MENU_MAIN_SETTINGS}
    self.usernamestring = platformContext.profile.name
    --self:printbackground()
    self:renderui()
end

-------------------------------------
-- Prints background on screen.
-- @author Erik
-------------------------------------
function MainMenu:printbackground()
    self.background = gfx.loadpng("data/background_h720.png")
    screen:copyfrom(self.background, nil, { x = 0, y = 0, w = screen:get_width(), h = screen:get_height() }, true)
    self.background:destroy()
end


-------------------------------------
-- Prints content on screen.
-- @author Erik, Adam
-------------------------------------
function MainMenu:renderui()

    main_menu_appname:draw_over_surface(screen, LOCALE.APP_NAME)
    main_menu_pagename:draw_over_surface(screen, LOCALE.MENU_MAIN)
    main_menu_username:draw_over_surface(screen, platformContext.profile.name)

    local avatarImageUrl = platformContext.profile.avatar

    local trophyRoomImageActive="data/trophy_active.png"
    local trophyRoomImageInactive="data/trophyinactive.png"
    local SettingsMenuImageActive="data/settings_active.png"
    local SettingsMenuImageInactive="data/settings_inactive.png"
    local InstructionsMenuImageActive="data/instructions_active.png"
    local InstructionsMenuImageInactive="data/instructions_inactive.png"

    self.avatarImage = gfx.loadpng(avatarImageUrl)

    local TrophyRoomImageActiveImage = gfx.loadpng(trophyRoomImageActive)
    local TrophyRoomImageInactiveImage = gfx.loadpng(trophyRoomImageInactive)
    local SettingsMenuImageActiveImage = gfx.loadpng(SettingsMenuImageActive)
    local SettingsMenuImageInactiveImage = gfx.loadpng(SettingsMenuImageInactive)

    local InstructionsActiveImage = gfx.loadpng(InstructionsMenuImageActive)
    local InstructionsInactiveImage = gfx.loadpng(InstructionsMenuImageInactive)
    self.avatarImage:premultiply()

    TrophyRoomImageActiveImage = gfx.loadpng(trophyRoomImageActive)
    TrophyRoomImageActiveImage:premultiply()
    TrophyRoomImageInactiveImage = gfx.loadpng(trophyRoomImageInactive)
    TrophyRoomImageInactiveImage:premultiply()
    SettingsMenuImageActiveImage = gfx.loadpng(SettingsMenuImageActive)
    SettingsMenuImageActiveImage:premultiply()
    SettingsMenuImageInactiveImage = gfx.loadpng(SettingsMenuImageInactive)
    SettingsMenuImageInactiveImage:premultiply()
    InstructionsActiveImage = gfx.loadpng(InstructionsMenuImageActive)
    InstructionsActiveImage:premultiply()
    InstructionsInactiveImage = gfx.loadpng(InstructionsMenuImageInactive)
    InstructionsInactiveImage:premultiply()

    self.inactiveImages = {
        TrophyRoomImageInactiveImage,
        InstructionsInactiveImage,
        SettingsMenuImageInactiveImage
    }

    self.activeImages = {
        TrophyRoomImageActiveImage,
        InstructionsActiveImage,
        SettingsMenuImageActiveImage
    }


    screen:copyfrom(self.avatarImage, nil, { x = screen:get_width() * 0.08, y = screen:get_height() * 0.09, w = screen:get_width() * 0.06, h = screen:get_height() * 0.1 })

    self:gamebuttonactive()
    for i = 1, 3, 1 do
        self:sidebuttoninactive(i)
    end
    screen:clear({ g = 0, r = 0, b = 0 }, { x = screen:get_width() * 0.8, y = screen:get_height() * 0.08, w = screen:get_width() * 0.05, h = screen:get_height() * 0.04 })
    screen:clear({ g = 230, r = 230, b = 230 }, { x = screen:get_width() * 0.803, y = screen:get_height() * 0.0845, w = screen:get_width() * 0.0455, h = screen:get_height() * 0.0308 })
    main_menu_backbutton:draw_over_surface(screen, LOCALE.BACK)
    main_menu_backtext:draw_over_surface(screen, LOCALE.PROFILE_CHANGE)
end

-------------------------------------
-- Prints an active gamebutton.
-- @author Erik
-------------------------------------
function MainMenu:gamebuttonactive()
    screen:clear({ g = 131, r = 0, b = 143 }, { x = screen:get_width() * 0.05, y = screen:get_height() * 0.3, w = screen:get_width() * 0.42, h = screen:get_height() * 0.61 })
    screen:clear({ g = 255, r = 255, b = 255 }, { x = screen:get_width() * 0.055, y = (screen:get_height() * 0.309), w = (screen:get_width() * 0.41), h = (screen:get_height() * 0.593) })
    screen:copyfrom(self.avatarImage, nil, { x = screen:get_width() * 0.10, y = screen:get_height() * 0.32 , w = screen:get_width() * 0.30, h = screen:get_height() * 0.45 })
    main_menu_games:draw_over_surface(screen, LOCALE.GAMES)
end

-------------------------------------
-- Prints an inactive gamebutton.
-- @author Erik
-------------------------------------
function MainMenu:gamebuttoninactive()
    screen:clear({ g = 228, r = 187, b = 235 }, { x = screen:get_width() * 0.05, y = screen:get_height() * 0.3, w = screen:get_width() * 0.42, h = screen:get_height() * 0.61 })
    screen:copyfrom(self.avatarImage, nil, { x = screen:get_width() * 0.10, y = screen:get_height() * 0.32 , w = screen:get_width() * 0.30, h = screen:get_height() * 0.45 })
    main_menu_games:draw_over_surface(screen, LOCALE.GAMES)
end

-------------------------------------
-- Prints an active sidebutton.
-- @param x1. Which place to print button.
-- @author Erik
-------------------------------------
function MainMenu:sidebuttonactive(x1)
    screen:clear({ g = 131, r = 0, b = 143 }, { x = screen:get_width() * 0.5375, y = (screen:get_height() * 0.3) + ((screen:get_height() * 0.2125) * (x1 - 1)), w = screen:get_width() * 0.425, h = screen:get_height() * 0.185 })
    screen:clear({ g = 255, r = 255, b = 255 }, { x = screen:get_width() * 0.5425, y = (screen:get_height() * 0.309) + ((screen:get_height() * 0.2125) * (x1 - 1)), w = (screen:get_width() * 0.415), h = (screen:get_height() * 0.1685) })
    screen:copyfrom(self.activeImages[x1], nil, { x = screen:get_width() * 0.5475, y = screen:get_height() * 0.33 + ((screen:get_height() * 0.2125) * (x1 - 1)), w = screen:get_width() * 0.090, h = screen:get_height() * 0.125 })

    self.sidebuttonfonts[x1]:draw_over_surface(screen, self.sidebuttons[x1])
end

-------------------------------------
-- Prints an inactive sidebutton.
-- @param x1. Which place to print button.
-- @author Erik
-------------------------------------
function MainMenu:sidebuttoninactive(x1)
    screen:clear({ g = 228, r = 187, b = 235 }, { x = screen:get_width() * 0.5375, y = (screen:get_height() * 0.3) + ((screen:get_height() * 0.2125) * (x1 - 1)), w = screen:get_width() * 0.425, h = screen:get_height() * 0.185 })
      screen:copyfrom(self.inactiveImages[x1], nil, { x = screen:get_width() * 0.5475, y = screen:get_height() *0.33 + ((screen:get_height() * 0.2125) * (x1 - 1)), w = screen:get_width() * 0.090, h = screen:get_height() * 0.125 })

    self.sidebuttonfonts[x1]:draw_over_surface(screen, self.sidebuttons[x1])
end

return MainMenu
