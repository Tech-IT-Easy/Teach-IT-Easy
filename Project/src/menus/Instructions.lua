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
    self.maxPage = 6
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
        screen:clear({ g = 228, r = 187, b = 235 }, { x = screen:get_width() * 0.01, y = screen:get_height() * 0.28, w = screen:get_width() * 0.98, h = screen:get_height() * 0.62})
        row_1:draw_over_surface(screen,"This is instructions for the game which is nice to have. Learn from someone who knows.")
        row_2:draw_over_surface(screen,"This is instructions for the game which is nice to have. Learn from someone who knows.")
        row_3:draw_over_surface(screen,"This is instructions for the game which is nice to have. Learn from someone who knows.")
        row_4:draw_over_surface(screen,"This is instructions for the game which is nice to have. Learn from someone who knows.")
        row_5:draw_over_surface(screen,"This is instructions for the game which is nice to have. Learn from someone who knows.")
        row_6:draw_over_surface(screen,"This is instructions for the game which is nice to have. Learn from someone who knows.")
        row_7:draw_over_surface(screen,"This is instructions for the game which is nice to have. Learn from someone who knows.")
        row_8:draw_over_surface(screen,"This is instructions for the game which is nice to have. Learn from someone who knows.")
        row_9:draw_over_surface(screen,"This is instructions for the game which is nice to have. Learn from someone who knows.")
        row_10:draw_over_surface(screen,"This is instructions for the game which is nice to have. Learn from someone who knows.")
        row_11:draw_over_surface(screen,"This is instructions for the game which is nice to have. Learn from someone who knows.")
        row_12:draw_over_surface(screen, "Det har")
    elseif self.page == 2  then
        screen:clear({ g = 228, r = 187, b = 235 }, { x = screen:get_width() * 0.01, y = screen:get_height() * 0.28, w = screen:get_width() * 0.98, h = screen:get_height() * 0.62})
        row_1:draw_over_surface(screen,"haha")
        row_2:draw_over_surface(screen,"This is instructions for the game which is nice to have. Learn from someone who knows.")
        row_3:draw_over_surface(screen,"This is instructions for the game which is nice to have. Learn from someone who knows.")
        row_4:draw_over_surface(screen,"This is instructions for the game which is nice to have. Learn from someone who knows.")
        row_5:draw_over_surface(screen,"This is instructions for the game which is nice to have. Learn from someone who knows.")
        row_6:draw_over_surface(screen,"This is instructions for the game which is nice to have. Learn from someone who knows.")
        row_7:draw_over_surface(screen,"This is instructions for the game which is nice to have. Learn from someone who knows.")
        row_8:draw_over_surface(screen,"This is instructions for the game which is nice to have. Learn from someone who knows.")
        row_9:draw_over_surface(screen,"This is instructions for the game which is nice to have. Learn from someone who knows.")
        row_10:draw_over_surface(screen,"This is instructions for the game which is nice to have. Learn from someone who knows.")
    elseif self.page == 3  then
        screen:clear({ g = 228, r = 187, b = 235 }, { x = screen:get_width() * 0.01, y = screen:get_height() * 0.28, w = screen:get_width() * 0.98, h = screen:get_height() * 0.62})
        row_1:draw_over_surface(screen,"This is instructions for the game which is nice to have. Learn from someone who knows.")
        row_2:draw_over_surface(screen,"This is instructions for the game which is nice to have. Learn from someone who knows.")
        row_3:draw_over_surface(screen,"This is instructions for the game which is nice to have. Learn from someone who knows.")
        row_4:draw_over_surface(screen,"This is instructions for the game which is nice to have. Learn from someone who knows.")
        row_5:draw_over_surface(screen,"This is instructions for the game which is nice to have. Learn from someone who knows.")
        row_6:draw_over_surface(screen,"This is instructions for the game which is nice to have. Learn from someone who knows.")
        row_7:draw_over_surface(screen,"This is instructions for the game which is nice to have. Learn from someone who knows.")
        row_8:draw_over_surface(screen,"This is instructions for the game which is nice to have. Learn from someone who knows.")
    elseif self.page == 4  then
        screen:clear({ g = 228, r = 187, b = 235 }, { x = screen:get_width() * 0.01, y = screen:get_height() * 0.28, w = screen:get_width() * 0.98, h = screen:get_height() * 0.62})
        row_1:draw_over_surface(screen,"This is instructions for the game which is nice to have. Learn from someone who knows.")
        row_2:draw_over_surface(screen,"This is instructions for the game which is nice to have. Learn from someone who knows.")
        row_3:draw_over_surface(screen,"This is instructions for the game which is nice to have. Learn from someone who knows.")
        row_4:draw_over_surface(screen,"This is instructions for the game which is nice to have. Learn from someone who knows.")
        row_5:draw_over_surface(screen,"This is instructions for the game which is nice to have. Learn from someone who knows.")
        row_6:draw_over_surface(screen,"This is instructions for the game which is nice to have. Learn from someone who knows.")
    elseif self.page == 5  then
        screen:clear({ g = 228, r = 187, b = 235 }, { x = screen:get_width() * 0.01, y = screen:get_height() * 0.28, w = screen:get_width() * 0.98, h = screen:get_height() * 0.62})
        row_1:draw_over_surface(screen,"This is instructions for the game which is nice to have. Learn from someone who knows.")
        row_2:draw_over_surface(screen,"This is instructions for the game which is nice to have. Learn from someone who knows.")
        row_3:draw_over_surface(screen,"This is instructions for the game which is nice to have. Learn from someone who knows.")
        row_4:draw_over_surface(screen,"This is instructions for the game which is nice to have. Learn from someone who knows.")
    elseif self.page == 6  then
        screen:clear({ g = 228, r = 187, b = 235 }, { x = screen:get_width() * 0.01, y = screen:get_height() * 0.28, w = screen:get_width() * 0.98, h = screen:get_height() * 0.62})
        row_1:draw_over_surface(screen,"This is instructions for the game which is nice to have. Learn from someone who knows.")
        row_2:draw_over_surface(screen,"This is instructions for the game which is nice to have. Learn from someone who knows.")
    end
end

return Instructions
