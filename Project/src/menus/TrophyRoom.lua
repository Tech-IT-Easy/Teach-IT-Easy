--
-- Created by IntelliJ IDEA.
-- User: Erik
-- Date: 2015-11-19
-- Time: 16:22
-- To change this template use File | Settings | File Templates.
--

local Super = require('toolkit.MenuSuperClass')
TrophyRoom = extends(Super)

local Event = require('toolkit.Event')
--added to test game

-------------------------------------
-- Creates the TrophyRoom menu.
-- @return self The created menu-object.
-- @author Erik
-------------------------------------
function TrophyRoom:new()

    return self
end

-------------------------------------
-- Handles the button-click sent from main.
-- @param key. Represent which button was pressed.
-- @return string. Either " " as standard or a string representing view to be changed to.
-- @author Erik
-------------------------------------
function TrophyRoom:handleinput(event)

    collectgarbage()
    self.lastpos = self.pos
    --[[
        if event.key == Event.KEY_RIGHT and self.pos == 0 then
            self.pos = 1
        elseif event.key == Event.KEY_DOWN and self.pos > 0 and self.pos < 3 then
            self.pos = self.pos + 1
        elseif event.key == Event.KEY_UP and self.pos > 1 and self.pos < 4 then
            self.pos = self.pos - 1
        elseif event.key == Event.KEY_LEFT and self.pos > 0 and self.pos < 4 then
            self.pos = 0
        elseif event.key == Event.KEY_BACK then
            return { "main" }
        end
        ]]
    if event.key == Event.KEY_BACK then
        return { "main", self.usernamestring }
    end
    return { " " }
end

-------------------------------------
-- Updates the view
-- @author Erik
-------------------------------------
function TrophyRoom:update()
    --[[
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
    ]]
end


-------------------------------------
-- Loads the view to the screen.
-- @author Erik
-------------------------------------
function TrophyRoom:loadview(input)
    --[[
    self.pos = 0
    self.lastpos = self.pos
    self.sidebuttons = { "Trophy room", "Wardrobe", "Settings" }

    --self:printbackground()

    ]]
    self.usernamestring = input
    self:renderui()
end

-------------------------------------
-- Prints content on screen.
-- @author Erik
-------------------------------------
function TrophyRoom:renderui()

    main_menu_appname:draw_over_surface(screen, "TEACH IT EASY")
    trophy_room_pagename:draw_over_surface(screen, "Programming game trophies")

    games_username:draw_over_surface(screen, self.usernamestring)
    screen:clear({ g = 228, r = 187, b = 235 }, { x = screen:get_width() * 0.08, y = screen:get_height() * 0.09, w = screen:get_width() * 0.06, h = screen:get_height() * 0.1 })

    trophy_room_progress:draw_over_surface(screen, "TEST")
    screen:clear({ g = 0, r = 0, b = 0 }, { x = screen:get_width() * 0.8, y = screen:get_height() * 0.08, w = screen:get_width() * 0.05, h = screen:get_height() * 0.04 })
    screen:clear({ g = 230, r = 230, b = 230 }, { x = screen:get_width() * 0.803, y = screen:get_height() * 0.0845, w = screen:get_width() * 0.0455, h = screen:get_height() * 0.0308 })
    games_backbutton:draw_over_surface(screen, "BACK")
    games_backtext:draw_over_surface(screen, "Go back")

    --[[

    main_menu_username:draw_over_surface(screen, self.usernamestring)
    screen:clear({ g = 228, r = 187, b = 235 }, { x = screen:get_width() * 0.08, y = screen:get_height() * 0.09, w = screen:get_width() * 0.06, h = screen:get_height() * 0.1 })
    self:gamebuttonactive()
    for i = 1, 3, 1 do
        self:sidebuttoninactive(i)
    end
    screen:clear({ g = 0, r = 0, b = 0 }, { x = screen:get_width() * 0.8, y = screen:get_height() * 0.08, w = screen:get_width() * 0.05, h = screen:get_height() * 0.04 })
    screen:clear({ g = 230, r = 230, b = 230 }, { x = screen:get_width() * 0.803, y = screen:get_height() * 0.0845, w = screen:get_width() * 0.0455, h = screen:get_height() * 0.0308 })
    main_menu_backbutton:draw_over_surface(screen, "BACK")
    main_menu_backtext:draw_over_surface(screen, "Change profile")
    ]]
end

return TrophyRoom