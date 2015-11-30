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

-------------------------------------
-- Creates the TrophyRoom menu.
-- @return self The created menu-object.
-- @author Erik
-------------------------------------
function TrophyRoom:new()
    local o = TrophyRoom:super()
    o.totalTrophies = 5
    return TrophyRoom:init(o)
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
    --[[if event.key == Event.KEY_RIGHT and self.pos == 0 then
        self.pos = 1
        ]]
    if event.key == Event.KEY_DOWN and self.pos > 0 and self.pos < 3 then
        self.pos = self.pos + 1
    elseif event.key == Event.KEY_UP and self.pos > 1 and self.pos < 4 then
        self.pos = self.pos - 1
        --[[ elseif event.key == Event.KEY_LEFT and self.pos > 0 and self.pos < 4 then
             self.pos = 0
             ]]
    elseif event.key == Event.KEY_BACK then
        return { "main" }
    end
    return { " " }
end

-------------------------------------
-- Updates the view
-- @author Erik
-------------------------------------
function TrophyRoom:update()
    self:sidebuttoninactive(self.lastpos)
    self:sidebuttonactive(self.pos)
    self:printAchievementBox()
end


-------------------------------------
-- Loads the view to the screen.
-- @author Erik
-------------------------------------
function TrophyRoom:loadview(input)

    self.pos = 1
    self.lastpos = self.pos
    --[[
    self.sidebuttons = { "Trophy room", "Wardrobe", "Settings" }

    --self:printbackground()

    ]]
    self.usernamestring = platformContext.profile.name
    self:loadProgress("progg")
    self:renderui()
end

-------------------------------------
-- Prints content on screen.
-- @author Erik
-------------------------------------
function TrophyRoom:renderui()
    self:printTopPanel()
    self:printProgressionBar()
    self:loadButtons()
    self:printAchievementBox()

    --screen:clear({ g = 230, r = 230, b = 230 }, { x = screen:get_width() * 0.803, y = screen:get_height() * 0.0845, w = screen:get_width() * 0.0455, h = screen:get_height() * 0.0308 })



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

-------------------------------------
-- Prints box with info about marked achievement.
-- @author Erik
-------------------------------------
function TrophyRoom:printAchievementBox()
    screen:clear({ g = 131, r = 0, b = 143 }, { x = screen:get_width() * 0.57, y = self.starty, w = screen:get_width() * 0.35, h = screen:get_height() * 0.40 })
    screen:clear({ g = 255, r = 255, b = 255 }, { x = (screen:get_width() * 0.57) + self.boxpadding, y = self.starty + self.boxpadding, w = (screen:get_width() * 0.35) - self.boxpadding * 2, h = (screen:get_height() * 0.40) - self.boxpadding * 2 })
end

-------------------------------------
-- Loads the progress.
-- @param game. The game to be showed.
-- @author Erik
-------------------------------------
function TrophyRoom:loadProgress(game)
    self.achievementButtons = {}
    self.lockedachievements = {}
    if (game == "progg") then
        if (platformContext.profile.gameprogress.progress["games.Progg.ProggGame"].proggGameLoopLevel) then
            table.insert(self.achievementButtons, { "Loop", "Loop is completed" })
        else
            table.insert(self.lockedachievements, { "Loop", "Unlock loop levels" })
        end
        if (platformContext.profile.gameprogress.progress["games.Progg.ProggGame"].proggGameProcLevel) then
            table.insert(self.achievementButtons, { "Procedure", "Procedure is completed" })
        else
            table.insert(self.lockedachievements, { "Procedure", "Unlock proceure levels" })
        end
        if (platformContext.profile.gameprogress.progress["games.Progg.ProggGame"].proggGameIfLevel) then
            table.insert(self.achievementButtons, { "If statement", "If statement is completed" })
        else
            table.insert(self.lockedachievements, { "Procedure", "Unlock if statement" })
        end
    elseif (game == "reading") then
    end
end

-------------------------------------
-- Loads information about the buttons.
-- @author Erik
-------------------------------------
function TrophyRoom:loadButtons()
    self.boxheight = screen:get_height() * 0.1
    self.boxwidth = screen:get_width() * 0.3
    -- local padding = (screen:get_width() * 0.75) - (self.boxheight * self.columns)
    -- self.startx = padding / 2
    self.starty = screen:get_height() * 0.45
    self.innerboxheight = self.boxheight - 12
    self.innerboxwidth = self.boxwidth - 12
    self.boxpadding = 6


    self:sidebuttonactive(1)
    for i = 2, 3, 1 do
        self:sidebuttoninactive(i)
    end
end

-------------------------------------
-- Prints an active button.
-- @param x1. Which place to print button.
-- @author Erik
-------------------------------------
function TrophyRoom:sidebuttonactive(x1)
    screen:clear({ g = 131, r = 0, b = 143 }, { x = screen:get_width() * 0.08, y = self.starty + ((x1 - 1) * self.boxheight * 1.5), w = self.boxwidth, h = self.boxheight })
    screen:clear({ g = 255, r = 255, b = 255 }, { x = screen:get_width() * 0.08 + self.boxpadding, y = (self.starty + ((x1 - 1) * self.boxheight * 1.5)) + self.boxpadding, w = self.innerboxwidth, h = self.innerboxheight })

    --self.sidebuttonfonts[x1]:draw_over_surface(screen, self.sidebuttons[x1])
end

-------------------------------------
-- Prints an inactive button.
-- @param x1. Which place to print button.
-- @author Erik
-------------------------------------
function TrophyRoom:sidebuttoninactive(x1)
    screen:clear({ g = 228, r = 187, b = 235 }, { x = screen:get_width() * 0.08, y = self.starty + ((x1 - 1) * self.boxheight * 1.5), w = self.boxwidth, h = self.boxheight })

    --self.sidebuttonfonts[x1]:draw_over_surface(screen, self.sidebuttons[x1])
end

-------------------------------------
-- Prints the top panel.
-- @author Erik
-------------------------------------
function TrophyRoom:printTopPanel()
    avatarImage = platformContext.profile.avatar
    local image1 = gfx.loadpng(platformContext.profile.avatar)
    image1:premultiply()


    main_menu_appname:draw_over_surface(screen, "TEACH IT EASY")
    trophy_room_pagename:draw_over_surface(screen, "Programming game trophies")

    games_username:draw_over_surface(screen, self.usernamestring)
    screen:copyfrom(image1, nil, { x = screen:get_width() * 0.08, y = screen:get_height() * 0.09, w = screen:get_width() * 0.06, h = screen:get_height() * 0.1 })
    screen:clear({ g = 0, r = 0, b = 0 }, { x = screen:get_width() * 0.8, y = screen:get_height() * 0.08, w = screen:get_width() * 0.05, h = screen:get_height() * 0.04 })
    screen:clear({ g = 230, r = 230, b = 230 }, { x = screen:get_width() * 0.803, y = screen:get_height() * 0.0845, w = screen:get_width() * 0.0455, h = screen:get_height() * 0.0308 })
    games_backbutton:draw_over_surface(screen, "BACK")
    games_backtext:draw_over_surface(screen, "Go back")
end

-------------------------------------
-- Prints the progression bar.
-- @author Erik
-------------------------------------
function TrophyRoom:printProgressionBar()

    trophy_room_progress:draw_over_surface(screen, "You have completed " .. platformContext.profile.gameprogress.progress["games.Progg.ProggGame"].level .. " levels out of " .. self.totalTrophies)
    local padding = (screen:get_width() * 0.16) / 2
    local bar = screen:get_width() - (padding * 2)
    local bluebar = bar * (platformContext.profile.gameprogress.progress["games.Progg.ProggGame"].level / self.totalTrophies)
    local whitebar = bar - bluebar

    screen:clear({ g = 131, r = 0, b = 143 }, { x = padding, y = screen:get_height() * 0.351, w = bluebar, h = screen:get_height() * 0.0308 })
    screen:clear({ g = 255, r = 255, b = 255 }, { x = padding + bluebar, y = screen:get_height() * 0.351, w = whitebar, h = screen:get_height() * 0.0308 })
end

return TrophyRoom