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
-----------------------------------------------------------
-- This class is for the platform menu which is used
-- to show game choice menu and process some key events
--
-- @Author : C r e a t e d by Chuck, Aug 16,2015
-- @Author : U p d a t e d by Tobias, Nov 02, 2015
-----------------------------------------------------------

local EventHandler = require('toolkit.EventHandler')
local Event = require('toolkit.Event')
local Controllable = require('toolkit.Controllable')

local PlatformMenu = extends(Controllable)

--included classes for menu
local ProfileSelection = require('menus.ProfileSelection')
local MainMenu = require('menus.MainMenu')
local CreateProfile = require('menus.CreateProfile')
local Games = require('menus.Games')
skin = require('menus.skin')
local background = gfx.loadpng("data/background_h720.png")
local ChooseAvatar = require('menus.ChooseAvatar')
local TrophyRoom = require('menus.TrophyRoom')
local Instructions = require('menus.Instructions')
local SelectLevel = require('menus.SelectLevel')
local UpdateAvatar = require('menus.UpdateAvatar')
local UpdateName = require('menus.UpdateName')
local Settings = require('menus.Settings')
local Profile = require('platform.Profile')

profiles = {}
table.insert(profiles, Profile:new("Knatte", 'data/avatar/cute_robot/DOWN.png', "/cute_robot/"))
table.insert(profiles, Profile:new("Fnatte", 'data/avatar/insect_robot/DOWN.png', "/insect_robot/"))
table.insert(profiles, Profile:new("Tjatte", 'data/avatar/strong_robot/DOWN.png', "/strong_robot/"))


-----------------------------------------------------------
-- Constructor method
-- @return :PlatformMenu a new instance of PlatformMenu
-- @author Chuck
-----------------------------------------------------------
function PlatformMenu:new()
    local o = PlatformMenu:super()
    -- example code
    -- self.position = {x=1,y=2 }
    self:loadviews()

    return PlatformMenu:init(o)
end

-----------------------------------------------------------
-- Loads the current view to the screen
-- @author Chuck
-----------------------------------------------------------
function PlatformMenu:show()
    -- example code
    screen:copyfrom(background, nil, { x = 0, y = 0, w = screen:get_width(), h = screen:get_height() }, true)
    self.currentview:loadview()
    --screen:clear({g=15, r=15, b=220}, {x=self.position.x*100,y=self.position.y*100,width=100,height=100})
end

function PlatformMenu:update()
    -- example code
    self.currentview:update()
    --screen:clear({g=15, r=15, b=220}, {x=self.position.x*100,y=self.position.y*100,width=100,height=100})
end

-------------------------------------
-- Creates the menu-views un startup.
-- @author Erik/ Marcus
-------------------------------------
function PlatformMenu:loadviews()
    -- @member currentview:MenuSuperClass
    self.currentview = ProfileSelection:new()
    self.views = {
        profilesel = ProfileSelection,
        main = MainMenu,
        create = CreateProfile,
        games = Games,
        chooseavatar = ChooseAvatar,
        trophy = TrophyRoom,
        instructions = Instructions,
        selectlevel = SelectLevel,
        settings = Settings,
        updatename = UpdateName,
        updateavatar = UpdateAvatar
    }
    collectgarbage()
end

-------------------------------------
-- Changes the current view and loads it.
-- @param newview. String that represents the new view.
-- @author Erik/ Marcus
-------------------------------------
function PlatformMenu:changeview(newview)
    self.currentview = self.views[newview[1]]:new()
    screen:copyfrom(background, nil, { x = 0, y = 0, w = screen:get_width(), h = screen:get_height() }, true)
    self.currentview:loadview()
    collectgarbage()
end

-----------------------------------------------------------
-- Menu event handler for some keyboard input, when creating 
-- a handler, you need to do a few the steps as follow
-- @param object:PlatformMenu which will be operated, usually it is
-- the class that contain this handler, here is menu
-- @param event:Event which is event currently happening
-----------------------------------------------------------

-- create a event delegate for menu
menuEventHandler = EventHandler:new()

-- register interesting events, listener will only notify these events
menuEventHandler.events = { [Event.KEY_UP] = Event.KEY_STATE_DOWN, [Event.KEY_DOWN] = Event.KEY_STATE_DOWN, [Event.KEY_RIGHT] = Event.KEY_STATE_DOWN, [Event.KEY_LEFT] = Event.KEY_STATE_DOWN, [Event.KEY_ONE] = Event.KEY_STATE_DOWN, [Event.KEY_TWO] = Event.KEY_STATE_DOWN, [Event.KEY_OK] = Event.KEY_STATE_DOWN, [Event.KEY_BACK] = Event.KEY_STATE_DOWN }

-- override specific update method to response keyboard events, 
function menuEventHandler:update(object, eventListener, event)
    -- if key == 'exit' then
    -- sys.stop()
    --end
    if event.state == Event.KEY_STATE_DOWN then
        local temp = object.currentview:handleinput(event)
        if temp[1] ~= " " then object:changeview(temp) end
        collectgarbage()
    end
end

-- Make handler useful to PlatformMenu
PlatformMenu.eventHandler = menuEventHandler

return PlatformMenu