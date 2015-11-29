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


-------------------------------------
-- Creates the Instructions menu.
-- @return self The created menu-object.
-- @author Erik
-------------------------------------
function Instructions:new()
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
            return { "main", self.usernamestring}
        end
    return { " " }
end

-------------------------------------
-- Updates the view
-- @author Erik
-------------------------------------
function Instructions:update()
end


-------------------------------------
-- Loads the view to the screen.
-- @author Erik
-------------------------------------
function Instructions:loadview(input)
    self.usernamestring = input
    self:renderui()
end

-------------------------------------
-- Prints content on screen.
-- @author Mikael
-------------------------------------
function Instructions:renderui()

    main_menu_appname:draw_over_surface(screen, "TEACH IT EASY")
    trophy_room_pagename:draw_over_surface(screen, "INSTRUCTIONS")
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
end

return Instructions
