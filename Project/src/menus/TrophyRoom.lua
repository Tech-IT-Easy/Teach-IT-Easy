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
local LOCALE = require('i18n.main')

-------------------------------------
-- Creates the TrophyRoom menu.
-- @return self The created menu-object.
-- @author Erik
-------------------------------------
function TrophyRoom:new()
    local o = TrophyRoom:super()
    --o.totalTrophies = 5
    o.sidebuttonfonts = { trophyroom_sidebuttontext1, trophyroom_sidebuttontext2, trophyroom_sidebuttontext3 }
    o.inactivesidebuttonfonts = { trophyroom_inactive_sidebuttontext1, trophyroom_inactive_sidebuttontext2, trophyroom_inactive_sidebuttontext3 }
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
    self.lastcontent = self.content
    if event.key == Event.KEY_RIGHT then
        self.currentGame = "reading"
        self:scrollGames()
    elseif event.key == Event.KEY_DOWN and self.pos > 0 and self.pos < 3 then
        self.pos = self.pos + 1
        self.content = self.content + 1
    elseif event.key == Event.KEY_DOWN and self.pos == 3 and self.content ~= #self.achievementButtons then
        self.content = self.content + 1
        self:scrollButtons(self.pos, self.content)

    elseif event.key == Event.KEY_UP and self.pos > 1 and self.pos < 4 then
        self.pos = self.pos - 1
        self.content = self.content - 1
    elseif event.key == Event.KEY_UP and self.pos == 1 and self.content ~= 1 then
        self.content = self.content - 1
        self:scrollButtons(self.pos, self.content)
    elseif event.key == Event.KEY_LEFT then
        self.currentGame = "progg"
        self:scrollGames()
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
    self:sidebuttoninactive(self.lastpos, self.lastcontent)
    self:sidebuttonactive(self.pos, self.content)
    self:printAchievementBox()
end


-------------------------------------
-- Loads the view to the screen.
-- @author Erik
-------------------------------------
function TrophyRoom:loadview()

    self:setPosition()
    self.games = { progg = 1, reading = 2 }
    self.currentGame = "progg"
    self.usernamestring = platformContext.profile.name
    self:loadProgress(self.currentGame)
    self:renderui()
end

-------------------------------------
-- Sets position to start
-- @author Erik
-------------------------------------
function TrophyRoom:setPosition()
    self.pos = 1
    self.lastpos = self.pos
    self.content = 1
    self.lastcontent = self.content
end

-------------------------------------
-- Prints content on screen.
-- @author Erik
-------------------------------------
function TrophyRoom:renderui()
    self:printProgressionBar()
    self:loadButtons()
    self:printAchievementBox()
    self:loadButtonContent()
    self:printTopPanel()
end

-------------------------------------
-- Prints box with info about marked achievement.
-- @author Erik
-------------------------------------
function TrophyRoom:printAchievementBox()
    screen:clear({ g = 131, r = 0, b = 143 }, { x = self.boxwidth + self.boxmargin * 2, y = self.starty, w = self.boxwidth, h = screen:get_height() * 0.40 })
    screen:clear({ g = 255, r = 255, b = 255 }, { x = self.boxwidth + self.boxmargin * 2 + self.boxpadding, y = self.starty + self.boxpadding, w = self.boxwidth - self.boxpadding * 2, h = (screen:get_height() * 0.40) - self.boxpadding * 2 })
    trophyroom_contentheader:draw_over_surface(screen, self.achievementButtons[self.content][1])
    trophyroom_boxcontent:draw_over_surface(screen, self.achievementButtons[self.content][2])

    if (self.done[tostring(tostring(self.content))] ~= true) then
        trophyroom_boxcontentrequirement:draw_over_surface(screen, self.achievementButtons[self.content][3])
    end
end

-------------------------------------
-- Loads the progress.
-- @param game. The game to be showed.
-- @author Erik
-------------------------------------
function TrophyRoom:loadProgress(game)
    self.achievementButtons = {}
    self.done = {}
    if (game == "progg") then
        self.totalLevels = 8
        if (platformContext.profile.gameprogress.progress["games.Progg.ProggGame"].proggGameBasicLevel) then
            table.insert(self.achievementButtons, { "Basic Actions", "Basic Actions is completed" })
            self.done["1"] = true
        else
            table.insert(self.achievementButtons, { "Basic Actions", "Unlocks procedure levels", "Finish level 3" })
        end
        if (platformContext.profile.gameprogress.progress["games.Progg.ProggGame"].proggGameProcLevel) then
            table.insert(self.achievementButtons, { "Procedure", "Procedure is completed" })
            self.done["2"] = true
        else
            table.insert(self.achievementButtons, { "Procedure", "Unlocks loop levels", "Finish level 4" })
        end
        if (platformContext.profile.gameprogress.progress["games.Progg.ProggGame"].proggGameLoopLevel) then
            table.insert(self.achievementButtons, { "Loop", "Loop level completed" })
            self.done["3"] = true
        else
            table.insert(self.achievementButtons, { "Loop", "Unlocks mixed levels", "Finish level 5" })
        end
        if (platformContext.profile.gameprogress.progress["games.Progg.ProggGame"].proggGameMaster) then
            table.insert(self.achievementButtons, { "Programming master", "You are awesome" })
            self.done["4"] = true
        else
            table.insert(self.achievementButtons, { "Programming master", "Master of programming", "Finish all levels" })
        end
        -- progGameMasterProc = false
    elseif (game == "reading") then
        self.totalLevels = 8
        if (platformContext.profile.gameprogress.progress["games.Catch.Catch"].catchABC) then
            table.insert(self.achievementButtons, { "ABC", "You have completed level 2" })
            self.done["1"] = true
        else
            table.insert(self.achievementButtons, { "ABC", "Learn the alphabet", "Finish level 2" })
        end
        if (platformContext.profile.gameprogress.progress["games.Catch.Catch"].catchKindergarten) then
            table.insert(self.achievementButtons, { "Kindergarten", "Level 4 is completed" })
            self.done["2"] = true
        else
            table.insert(self.achievementButtons, { "Kindergarten", "Can you read?", "Finish level 4" })
        end
        if (platformContext.profile.gameprogress.progress["games.Catch.Catch"].catchElementary) then
            table.insert(self.achievementButtons, { "Elementary School", "Level 6 completed" })
            self.done["3"] = true
        else
            table.insert(self.achievementButtons, { "Elementary School", "This needs skill", "Finish level 4" })
        end
        if (platformContext.profile.gameprogress.progress["games.Catch.Catch"].catchPhd) then
            table.insert(self.achievementButtons, { "Phd", "You are awesome" })
            self.done["4"] = true
        else
            table.insert(self.achievementButtons, { "Phd", "Master of programming", "Finish all levels" })
        end
        self.achievementButtons = {
            { "ABC", "Learn the alphabet", "Finish level 1" },
            { "Kindergarten", "Can you read?", "Finish level 2" },
            {
                "Elementary School", "This needs skill",
                "Finish level 4"
            }, { "Phd", "Some serious stuff", "Complete all Levels" }
        }
    end
end

-------------------------------------
-- Loads information about the buttons.
-- @author Erik
-------------------------------------
function TrophyRoom:loadButtons()
    self.boxheight = screen:get_height() * 0.1
    self.boxwidth = screen:get_width() * 0.38
    local freespace = screen:get_width() - (self.boxwidth * 2)
    self.boxmargin = freespace / 3
    self.starty = screen:get_height() * 0.45
    self.boxpadding = 5
    self.innerboxheight = self.boxheight - self.boxpadding * 2
    self.innerboxwidth = self.boxwidth - self.boxpadding * 2
end

-------------------------------------
-- Loads the current information to the buttons.
-- @author Erik
-------------------------------------
function TrophyRoom:loadButtonContent()
    self:sidebuttonactive(1, 1)
    for i = 2, 3, 1 do
        self:sidebuttoninactive(i, i)
    end
end



function TrophyRoom:scrollGames()
    local background = gfx.loadpng("data/background_h720.png")
    screen:copyfrom(background, nil, { x = 0, y = 0, w = screen:get_width(), h = screen:get_height() }, true)
    background:destroy()
    self:setPosition()
    self:loadProgress(self.currentGame)



    self:printProgressionBar()
    self:loadButtons()
    self:printAchievementBox()
    self:loadButtonContent()
    self:printTopPanel()
end

-------------------------------------
-- Called to scroll content of achievement buttons
-- @author Erik
-------------------------------------
function TrophyRoom:scrollButtons(active, content)
    if active == 3 then
        self:sidebuttonactive(active, content)
        self:sidebuttoninactive(2, content - 1)
        self:sidebuttoninactive(1, content - 2)
    elseif active == 1 then
        self:sidebuttonactive(active, content)
        self:sidebuttoninactive(2, content + 1)
        self:sidebuttoninactive(3, content + 2)
    end
end

-------------------------------------
-- Prints an active button.
-- @param x1. Which place to print button.
-- @author Erik
-------------------------------------
function TrophyRoom:sidebuttonactive(x1, content)
    screen:clear({ g = 131, r = 0, b = 143 }, { x = screen:get_width() * 0.08, y = self.starty + ((x1 - 1) * self.boxheight * 1.5), w = self.boxwidth, h = self.boxheight })
    screen:clear({ g = 255, r = 255, b = 255 }, { x = screen:get_width() * 0.08 + self.boxpadding, y = (self.starty + ((x1 - 1) * self.boxheight * 1.5)) + self.boxpadding, w = self.innerboxwidth, h = self.innerboxheight })

    --get info from tables
    --local text = gfx.new_surface(self.boxwidth, self.boxheight)
    --text:premultiply()
    if (self.done[tostring(content)]) then
        --- trophyroom_sidebuttontext:draw_over_surface(text, self.achievementButtons[content][1])
        -- screen:copyfrom(text, nil, { x = screen:get_width() * 0.15 + self.boxpadding, y = (self.starty + ((x1 - 1) * self.boxheight * 1.5)) + self.boxpadding * 3, w = self.boxwidth, h = self.boxheight })

        self.sidebuttonfonts[x1]:draw_over_surface(screen, self.achievementButtons[content][1])
    else
        --trophyroom_inactive_sidebuttontext:draw_over_surface(text, self.achievementButtons[content][1])
        --screen:copyfrom(text, nil, { x = screen:get_width() * 0.15 + self.boxpadding, y = (self.starty + ((x1 - 1) * self.boxheight * 1.5)) + self.boxpadding * 3, w = self.boxwidth, h = self.boxheight })


        self.inactivesidebuttonfonts[x1]:draw_over_surface(screen, self.achievementButtons[content][1])
    end
    --text:destroy()
end

-------------------------------------
-- Prints an inactive button.
-- @param x1. Which place to print button.
-- @author Erik
-------------------------------------
function TrophyRoom:sidebuttoninactive(x1, content)
    screen:clear({ g = 228, r = 187, b = 235 }, { x = screen:get_width() * 0.08, y = self.starty + ((x1 - 1) * self.boxheight * 1.5), w = self.boxwidth, h = self.boxheight })

    -- text = gfx.new_surface(self.boxwidth, self.boxheight)
    --text:premultiply()
    --get info from tables
    if (self.done[tostring(content)]) then
        -- trophyroom_sidebuttontext:draw_over_surface(text, self.achievementButtons[content][1])
        --screen:copyfrom(text, nil, { x = screen:get_width() * 0.15 + self.boxpadding, y = (self.starty + ((x1 - 1) * self.boxheight * 1.5)) + self.boxpadding * 3, w = self.boxwidth, h = self.boxheight })


        self.sidebuttonfonts[x1]:draw_over_surface(screen, self.achievementButtons[content][1])
    else

        --trophyroom_inactive_sidebuttontext:draw_over_surface(text, self.achievementButtons[content][1])
        --screen:copyfrom(text, nil, { x = screen:get_width() * 0.15 + self.boxpadding, y = (self.starty + ((x1 - 1) * self.boxheight * 1.5)) + self.boxpadding * 3, w = self.boxwidth, h = self.boxheight })

        self.inactivesidebuttonfonts[x1]:draw_over_surface(screen, self.achievementButtons[content][1])
    end
    --text:destroy()
end

-------------------------------------
-- Prints the top panel.
-- @author Erik
-------------------------------------
function TrophyRoom:printTopPanel()
    avatarImage = platformContext.profile.avatar
    local image1 = gfx.loadpng(platformContext.profile.avatar)
    image1:premultiply()

    main_menu_appname:draw_over_surface(screen, LOCALE.APP_NAME)
    local pageTitle
    --LOCALE.TROPHY_MENU
    -- name of page
    if self.currentGame == "progg" then
        pageTitle = "Programming game trophies"
    elseif self.currentGame == "reading" then
        pageTitle = "  Reading game trophies"
    end
    trophy_room_pagename:draw_over_surface(screen, pageTitle)

    local count = 0
    for _ in pairs(self.games) do
        count = count + 1
    end
    print(count)

    if self.games[self.currentGame] < count then
        --print right arrow
        print("rightarrow")
        trophy_room_rightarrow:draw_over_surface(screen, "-->")
    end
    if self.games[self.currentGame] > 1 then
        --print left arrow
        trophy_room_leftarrow:draw_over_surface(screen, "<--")
    end

    games_username:draw_over_surface(screen, self.usernamestring)
    screen:copyfrom(image1, nil, { x = screen:get_width() * 0.08, y = screen:get_height() * 0.09, w = screen:get_width() * 0.06, h = screen:get_height() * 0.1 })
    screen:clear({ g = 0, r = 0, b = 0 }, { x = screen:get_width() * 0.8, y = screen:get_height() * 0.08, w = screen:get_width() * 0.05, h = screen:get_height() * 0.04 })
    screen:clear({ g = 230, r = 230, b = 230 }, { x = screen:get_width() * 0.803, y = screen:get_height() * 0.0845, w = screen:get_width() * 0.0455, h = screen:get_height() * 0.0308 })
    games_backbutton:draw_over_surface(screen, LOCALE.BACK)
    games_backtext:draw_over_surface(screen, LOCALE.BACK_HELP)
end

-------------------------------------
-- Prints the progression bar.
-- @author Erik
-------------------------------------
function TrophyRoom:printProgressionBar()
    local finishedLevels
    if self.currentGame == "progg" then
        finishedLevels = platformContext.profile.gameprogress.progress["games.Progg.ProggGame"].level
    else
        finishedLevels = 0
    end
    trophy_room_progress:draw_over_surface(screen, string.format(LOCALE.TROPHY_COMPLETED, finishedLevels, self.totalLevels))
    local padding = (screen:get_width() * 0.16) / 2
    local bar = screen:get_width() - (padding * 2)
    local bluebar = bar * (finishedLevels / self.totalLevels)
    local whitebar = bar - bluebar
    if bluebar > 0 then
        screen:clear({ g = 131, r = 0, b = 143 }, { x = padding, y = screen:get_height() * 0.351, w = bluebar, h = screen:get_height() * 0.0308 })
    end
    if whitebar > 0 then
        screen:clear({ g = 255, r = 255, b = 255 }, { x = padding + bluebar, y = screen:get_height() * 0.351, w = whitebar, h = screen:get_height() * 0.0308 })
    end
end

return TrophyRoom