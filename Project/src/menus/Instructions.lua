--
-- Created by IntelliJ IDEA.
-- User: Mikael
-- Date: 11/29/2015
-- Time: 8:49 PM
-- To change this template use File | Settings | File Templates.
--

local Super = require('toolkit.MenuSuperClass')
Instructions = extends(Super)

local Event = require('toolkit.Event')
local LOCALE = require('i18n.main')


-------------------------------------
-- Creates the Instructions menu.
-- @return self The created menu-object.
-- @author Erik
-------------------------------------
function Instructions:new()
    self.page = 1
    self.maxPage = 7
    return self
end

-------------------------------------
-- Handles the button-click sent from main.
-- @param key. Represent which button was pressed.
-- @return string. Either " " as standard or a string representing view to be changed to.
-- @author Erik
-------------------------------------
function Instructions:handleinput(event)
    collectgarbage()
    self.lastpos = self.pos
    if event.key == Event.KEY_BACK then
            return { "main"}
    elseif event.key == Event.KEY_RIGHT then
        if self.page < self.maxPage then
            self.page = self.page + 1
        end
    elseif event.key == Event.KEY_LEFT then
        if self.page > 1 then
            self.page = self.page - 1
        end
    end
    return { " " }

end

-------------------------------------
-- Updates the view
-- @author Erik
-------------------------------------
function Instructions:update()
    self:renderui()
end


-------------------------------------
-- Loads the view to the screen.
-- @author Erik
-------------------------------------
function Instructions:loadview()
    self.usernamestring = platformContext.profile.name
    self:renderui()
end

-------------------------------------
-- Prints content on screen.
-- @author Mikael
-------------------------------------
function Instructions:renderui()

    main_menu_appname:draw_over_surface(screen, LOCALE.APP_NAME)
    instructions_pagename:draw_over_surface(screen, LOCALE.INSTRUCTIONS)

    screen:clear({ g = 228, r = 187, b = 235 }, { x = screen:get_width() * 0.05, y = screen:get_height() * 0.19, w = screen:get_width() * 0.18, h = screen:get_height() * 0.08})
    page_txt:draw_over_surface(screen, "Page "..self.page.." of "..self.maxPage)
    if self.page == 1 then
        screen:clear({ g = 228, r = 187, b = 235 }, { x = screen:get_width() * 0.41, y = screen:get_height() * 0.22, w = screen:get_width() * 0.22, h = screen:get_height() * 0.05})
        instructions_subpagename:draw_over_surface(screen, LOCALE.INSTRUCTIONS_MENU_NAVIGATION)
        screen:clear({ g = 228, r = 187, b = 235 }, { x = screen:get_width() * 0.01, y = screen:get_height() * 0.28, w = screen:get_width() * 0.98, h = screen:get_height() * 0.62})
        row_1:draw_over_surface(screen,LOCALE.INSTRUCTIONS_MENU_NAVIGATION_ROW1)
        row_2:draw_over_surface(screen,LOCALE.INSTRUCTIONS_MENU_NAVIGATION_ROW2)
        row_3:draw_over_surface(screen,LOCALE.INSTRUCTIONS_MENU_NAVIGATION_ROW3)
        row_4:draw_over_surface(screen,LOCALE.INSTRUCTIONS_MENU_NAVIGATION_ROW4)
        row_5:draw_over_surface(screen,LOCALE.INSTRUCTIONS_MENU_NAVIGATION_ROW5)
        row_6:draw_over_surface(screen,LOCALE.INSTRUCTIONS_MENU_NAVIGATION_ROW6)
        row_7:draw_over_surface(screen,LOCALE.INSTRUCTIONS_MENU_NAVIGATION_ROW7)
        row_8:draw_over_surface(screen,LOCALE.INSTRUCTIONS_MENU_NAVIGATION_ROW8)
        row_9:draw_over_surface(screen,LOCALE.INSTRUCTIONS_MENU_NAVIGATION_ROW9)
        row_10:draw_over_surface(screen,LOCALE.INSTRUCTIONS_MENU_NAVIGATION_ROW10)
        row_11:draw_over_surface(screen,LOCALE.INSTRUCTIONS_MENU_NAVIGATION_ROW11)
        row_12:draw_over_surface(screen,LOCALE.INSTRUCTIONS_MENU_NAVIGATION_ROW12)
    elseif self.page == 2  then
        screen:clear({ g = 228, r = 187, b = 235 }, { x = screen:get_width() * 0.41, y = screen:get_height() * 0.22, w = screen:get_width() * 0.22, h = screen:get_height() * 0.05})
        instructions_subpagename:draw_over_surface(screen, LOCALE.INSTRUCTIONS_PROGRAMMING_GAME)
        screen:clear({ g = 228, r = 187, b = 235 }, { x = screen:get_width() * 0.01, y = screen:get_height() * 0.28, w = screen:get_width() * 0.98, h = screen:get_height() * 0.62})
        row_1:draw_over_surface(screen,LOCALE.INSTRUCTIONS_PROGRAMMING_GAME1_ROW1)
        row_2:draw_over_surface(screen,LOCALE.INSTRUCTIONS_PROGRAMMING_GAME1_ROW2)
        row_3:draw_over_surface(screen,LOCALE.INSTRUCTIONS_PROGRAMMING_GAME1_ROW3)
        row_4:draw_over_surface(screen,LOCALE.INSTRUCTIONS_PROGRAMMING_GAME1_ROW4)
        row_5:draw_over_surface(screen,LOCALE.INSTRUCTIONS_PROGRAMMING_GAME1_ROW5)
        row_6:draw_over_surface(screen,LOCALE.INSTRUCTIONS_PROGRAMMING_GAME1_ROW6)
        row_7:draw_over_surface(screen,LOCALE.INSTRUCTIONS_PROGRAMMING_GAME1_ROW7)
        row_8:draw_over_surface(screen,LOCALE.INSTRUCTIONS_PROGRAMMING_GAME1_ROW8)
        row_9:draw_over_surface(screen,LOCALE.INSTRUCTIONS_PROGRAMMING_GAME1_ROW9)
        row_10:draw_over_surface(screen,LOCALE.INSTRUCTIONS_PROGRAMMING_GAME1_ROW10)
        row_11:draw_over_surface(screen,LOCALE.INSTRUCTIONS_PROGRAMMING_GAME1_ROW11)
        row_12:draw_over_surface(screen,LOCALE.INSTRUCTIONS_PROGRAMMING_GAME1_ROW12)
    elseif self.page == 3  then
        screen:clear({ g = 228, r = 187, b = 235 }, { x = screen:get_width() * 0.41, y = screen:get_height() * 0.22, w = screen:get_width() * 0.22, h = screen:get_height() * 0.05})
        instructions_subpagename:draw_over_surface(screen, LOCALE.INSTRUCTIONS_PROGRAMMING_GAME)
        screen:clear({ g = 228, r = 187, b = 235 }, { x = screen:get_width() * 0.01, y = screen:get_height() * 0.28, w = screen:get_width() * 0.98, h = screen:get_height() * 0.62})
        row_1:draw_over_surface(screen,LOCALE.INSTRUCTIONS_PROGRAMMING_GAME2_ROW1)
        row_2:draw_over_surface(screen,LOCALE.INSTRUCTIONS_PROGRAMMING_GAME2_ROW2)
        row_3:draw_over_surface(screen,LOCALE.INSTRUCTIONS_PROGRAMMING_GAME2_ROW3)
        row_4:draw_over_surface(screen,LOCALE.INSTRUCTIONS_PROGRAMMING_GAME2_ROW4)
        row_5:draw_over_surface(screen,LOCALE.INSTRUCTIONS_PROGRAMMING_GAME2_ROW5)
        row_6:draw_over_surface(screen,LOCALE.INSTRUCTIONS_PROGRAMMING_GAME2_ROW6)
        row_7:draw_over_surface(screen,LOCALE.INSTRUCTIONS_PROGRAMMING_GAME2_ROW7)
        row_8:draw_over_surface(screen,LOCALE.INSTRUCTIONS_PROGRAMMING_GAME2_ROW8)
        row_9:draw_over_surface(screen,LOCALE.INSTRUCTIONS_PROGRAMMING_GAME2_ROW9)
        row_10:draw_over_surface(screen,LOCALE.INSTRUCTIONS_PROGRAMMING_GAME2_ROW10)
        row_11:draw_over_surface(screen,LOCALE.INSTRUCTIONS_PROGRAMMING_GAME2_ROW11)
        row_12:draw_over_surface(screen,LOCALE.INSTRUCTIONS_PROGRAMMING_GAME2_ROW12)
    elseif self.page == 4  then
        screen:clear({ g = 228, r = 187, b = 235 }, { x = screen:get_width() * 0.41, y = screen:get_height() * 0.22, w = screen:get_width() * 0.22, h = screen:get_height() * 0.05})
        instructions_subpagename:draw_over_surface(screen, LOCALE.INSTRUCTIONS_PROGRAMMING_GAME)
        screen:clear({ g = 228, r = 187, b = 235 }, { x = screen:get_width() * 0.01, y = screen:get_height() * 0.28, w = screen:get_width() * 0.98, h = screen:get_height() * 0.62})
        row_1:draw_over_surface(screen,LOCALE.INSTRUCTIONS_PROGRAMMING_GAME3_ROW1)
        row_2:draw_over_surface(screen,LOCALE.INSTRUCTIONS_PROGRAMMING_GAME3_ROW2)
        row_3:draw_over_surface(screen,LOCALE.INSTRUCTIONS_PROGRAMMING_GAME3_ROW3)
        row_4:draw_over_surface(screen,LOCALE.INSTRUCTIONS_PROGRAMMING_GAME3_ROW4)
        row_5:draw_over_surface(screen,LOCALE.INSTRUCTIONS_PROGRAMMING_GAME3_ROW5)
        row_6:draw_over_surface(screen,LOCALE.INSTRUCTIONS_PROGRAMMING_GAME3_ROW6)
        row_7:draw_over_surface(screen,LOCALE.INSTRUCTIONS_PROGRAMMING_GAME3_ROW7)
        row_8:draw_over_surface(screen,LOCALE.INSTRUCTIONS_PROGRAMMING_GAME3_ROW8)
        row_9:draw_over_surface(screen,LOCALE.INSTRUCTIONS_PROGRAMMING_GAME3_ROW9)
        row_10:draw_over_surface(screen,LOCALE.INSTRUCTIONS_PROGRAMMING_GAME3_ROW10)
        row_11:draw_over_surface(screen,LOCALE.INSTRUCTIONS_PROGRAMMING_GAME3_ROW11)
        row_12:draw_over_surface(screen,LOCALE.INSTRUCTIONS_PROGRAMMING_GAME3_ROW12)
    elseif self.page == 5  then
        screen:clear({ g = 228, r = 187, b = 235 }, { x = screen:get_width() * 0.41, y = screen:get_height() * 0.22, w = screen:get_width() * 0.22, h = screen:get_height() * 0.05})
        instructions_subpagename:draw_over_surface(screen, LOCALE.INSTRUCTIONS_PROGRAMMING_GAME)
        screen:clear({ g = 228, r = 187, b = 235 }, { x = screen:get_width() * 0.01, y = screen:get_height() * 0.28, w = screen:get_width() * 0.98, h = screen:get_height() * 0.62})
        row_1:draw_over_surface(screen,LOCALE.INSTRUCTIONS_PROGRAMMING_GAME4_ROW1)
        row_2:draw_over_surface(screen,LOCALE.INSTRUCTIONS_PROGRAMMING_GAME4_ROW2)
        row_3:draw_over_surface(screen,LOCALE.INSTRUCTIONS_PROGRAMMING_GAME4_ROW3)
        row_4:draw_over_surface(screen,LOCALE.INSTRUCTIONS_PROGRAMMING_GAME4_ROW4)
        row_5:draw_over_surface(screen,LOCALE.INSTRUCTIONS_PROGRAMMING_GAME4_ROW5)
        row_6:draw_over_surface(screen,LOCALE.INSTRUCTIONS_PROGRAMMING_GAME4_ROW6)
        row_7:draw_over_surface(screen,LOCALE.INSTRUCTIONS_PROGRAMMING_GAME4_ROW7)
        row_8:draw_over_surface(screen,LOCALE.INSTRUCTIONS_PROGRAMMING_GAME4_ROW8)
        row_9:draw_over_surface(screen,LOCALE.INSTRUCTIONS_PROGRAMMING_GAME4_ROW9)
        row_10:draw_over_surface(screen,LOCALE.INSTRUCTIONS_PROGRAMMING_GAME4_ROW10)
        row_11:draw_over_surface(screen,LOCALE.INSTRUCTIONS_PROGRAMMING_GAME4_ROW11)
        row_12:draw_over_surface(screen,LOCALE.INSTRUCTIONS_PROGRAMMING_GAME4_ROW12)
    elseif self.page == 6  then
        screen:clear({ g = 228, r = 187, b = 235 }, { x = screen:get_width() * 0.41, y = screen:get_height() * 0.22, w = screen:get_width() * 0.22, h = screen:get_height() * 0.05})
        instructions_subpagename:draw_over_surface(screen, LOCALE.INSTRUCTIONS_PROGRAMMING_GAME)
        screen:clear({ g = 228, r = 187, b = 235 }, { x = screen:get_width() * 0.01, y = screen:get_height() * 0.28, w = screen:get_width() * 0.98, h = screen:get_height() * 0.62})
        row_1:draw_over_surface(screen,LOCALE.INSTRUCTIONS_PROGRAMMING_GAME5_ROW1)
        row_2:draw_over_surface(screen,LOCALE.INSTRUCTIONS_PROGRAMMING_GAME5_ROW2)
        row_3:draw_over_surface(screen,LOCALE.INSTRUCTIONS_PROGRAMMING_GAME5_ROW3)
        row_4:draw_over_surface(screen,LOCALE.INSTRUCTIONS_PROGRAMMING_GAME5_ROW4)
        row_5:draw_over_surface(screen,LOCALE.INSTRUCTIONS_PROGRAMMING_GAME5_ROW5)
        row_6:draw_over_surface(screen,LOCALE.INSTRUCTIONS_PROGRAMMING_GAME5_ROW6)
        row_7:draw_over_surface(screen,LOCALE.INSTRUCTIONS_PROGRAMMING_GAME5_ROW7)
        row_8:draw_over_surface(screen,LOCALE.INSTRUCTIONS_PROGRAMMING_GAME5_ROW8)
        row_9:draw_over_surface(screen,LOCALE.INSTRUCTIONS_PROGRAMMING_GAME5_ROW9)
        row_10:draw_over_surface(screen,LOCALE.INSTRUCTIONS_PROGRAMMING_GAME5_ROW10)
        row_11:draw_over_surface(screen,LOCALE.INSTRUCTIONS_PROGRAMMING_GAME5_ROW11)
        row_12:draw_over_surface(screen,LOCALE.INSTRUCTIONS_PROGRAMMING_GAME5_ROW12)
    elseif self.page == 7  then
        screen:clear({ g = 228, r = 187, b = 235 }, { x = screen:get_width() * 0.41, y = screen:get_height() * 0.22, w = screen:get_width() * 0.22, h = screen:get_height() * 0.05})
        instructions_subpagename:draw_over_surface(screen, LOCALE.INSTRUCTIONS_TROPHY_ROOM)
        screen:clear({ g = 228, r = 187, b = 235 }, { x = screen:get_width() * 0.01, y = screen:get_height() * 0.28, w = screen:get_width() * 0.98, h = screen:get_height() * 0.62})
        row_1:draw_over_surface(screen,LOCALE.INSTRUCTIONS_TROPHY_ROOM_ROW1)
        row_2:draw_over_surface(screen,LOCALE.INSTRUCTIONS_TROPHY_ROOM_ROW2)
        row_3:draw_over_surface(screen,LOCALE.INSTRUCTIONS_TROPHY_ROOM_ROW3)
        row_4:draw_over_surface(screen,LOCALE.INSTRUCTIONS_TROPHY_ROOM_ROW4)
        row_5:draw_over_surface(screen,LOCALE.INSTRUCTIONS_TROPHY_ROOM_ROW5)
        row_6:draw_over_surface(screen,LOCALE.INSTRUCTIONS_TROPHY_ROOM_ROW6)
        row_7:draw_over_surface(screen,LOCALE.INSTRUCTIONS_TROPHY_ROOM_ROW7)
        row_8:draw_over_surface(screen,LOCALE.INSTRUCTIONS_TROPHY_ROOM_ROW8)
        row_9:draw_over_surface(screen,LOCALE.INSTRUCTIONS_TROPHY_ROOM_ROW9)
        row_10:draw_over_surface(screen,LOCALE.INSTRUCTIONS_TROPHY_ROOM_ROW10)
        row_11:draw_over_surface(screen,LOCALE.INSTRUCTIONS_TROPHY_ROOM_ROW11)
        row_12:draw_over_surface(screen,LOCALE.INSTRUCTIONS_TROPHY_ROOM_ROW12)
    end
end

return Instructions
