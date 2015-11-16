-----------------------------------------------------------
-- This class contains methods for interacting with the
-- right-hand menu
--
-- @Author:Created by Mikael Ögren, Nov 04,2015
-- @Author:Updated by Vilhelm Granath, Nov 16, 2015 Moved draw functions to DrawRightMenu
-----------------------------------------------------------

local Object = require("toolkit.Object")
local Controllable = require("toolkit.Controllable")
local RightMenu = extends(Controllable)
skin = require('games/Progg/progg_skin')
local Commands = require('games.Progg.Commands')
local Event = require('toolkit.Event')
local EventHandler = require('toolkit.EventHandler')
local drawRightMenu = require('games/Progg/DrawRightMenu')

-- Variale to keep track of a highlighted command
local highlight = nil

-- Available commands
commands = {"move","turn-left","turn-right","action","if-wall","loop","P1","P2"}

-------------------------------------
-- Creates the Right-hand screen in the programming game
-- @return self. The created object.
-- @author Vilhelm
-------------------------------------
function RightMenu:new()
    local o = RightMenu:super()
    --Draw right-hand side
    screen:clear({ r = 92, g = 128, b = 149 }, { x = screen:get_width() * 0.75, y = 0, w = screen:get_width() * 0.25, h = screen:get_height()*0.65 })
    o.draw = drawRightMenu:new()
    return RightMenu:init(o)
end

-------------------------------------
-- Load function
-- @author Vilhelm
-------------------------------------
function RightMenu:load()

end

-------------------------------------
-- Shows all elements in the menu
-- Currently also used to test certain commands
-- @author Vilhelm
-------------------------------------
function RightMenu:show()
    self:standardLayout()
    --self:highlight("action")
    --self:highlight("P2")
    --self:play()
    --self:loopLayout()
    --self:buildLayout()
end


-------------------------------------
-- Highlights the command in the
-- specified position.
--
-- Needs to implement a timed call to remove
-- the highlight again
--
-- @params command: command to be highlighted
-- @author Vilhelm
-------------------------------------
function RightMenu:highlight(command)
    if highlight ~= nil then
        self:removeHighlight(highlight)
    end
    print(command)
    self.draw:drawHighlight(command)

    highlight = command

end

-------------------------------------
-- Removes the highlight on the command in the
-- specified position.
--
-- @params command: command to be un-highlighted
-- @author Vilhelm
-------------------------------------
function RightMenu:removeHighlight(command)
    self.draw:drawRemoveHighlight(command)

    highlight = nil
end

-------------------------------------
-- Changes the play-button to a stop-button when
-- the play-button is pressed
-- Also removes any highlight on the commands
--
-- Needs to stop the timer if there is one
--
-- @author Vilhelm
-------------------------------------
function RightMenu:play()
    if highlight ~= nill then
        self:removeHighlight(highlight)
    end

    self.draw:drawFullRow(4,245,45,120)
    command_play:draw_over_surface(screen, "0  Stop!")
end

-------------------------------------
-- Changes the stop-button to a play-button when
-- the stop-button is pressed
-- @author Vilhelm
-------------------------------------
function RightMenu:stop()
    self.draw:drawFullRow(4,78,113,215)
    command_play:draw_over_surface(screen, "0  Play!")
end

-------------------------------------
-- Called to write the standard layout
-- @author Vilhelm
-------------------------------------
function RightMenu:standardLayout()
    self.draw:drawRow(1)
    self.draw:drawRow(2)
    self.draw:drawRow(3)
    self.draw:drawFullRow(4,78,113,215)
    self.draw:addNumbers()
    self.draw:addPlay()
    self.draw:addImages()
end

-------------------------------------
-- Called to replace buttons for loops
-- @author Vilhelm
-------------------------------------
function RightMenu:loopLayout()
    self.draw:drawRow(1)
    self.draw:drawRow(2)
    self.draw:drawRow(3)
    -- add numbers in boxes
    self.draw:drawFullRow(4,78,113,215)
    self.draw:addNumbers()
    nr_1:draw_over_surface(screen, "1")
    nr_2:draw_over_surface(screen, "2")
    nr_3:draw_over_surface(screen, "3")
    nr_4:draw_over_surface(screen, "4")
    nr_5:draw_over_surface(screen, "5")
    nr_6:draw_over_surface(screen, "6")
    nr_7:draw_over_surface(screen, "7")
    nr_8:draw_over_surface(screen, "8")
    nr_9:draw_over_surface(screen, "9")
    command_play:draw_over_surface(screen, "0")

    self.image = gfx.loadpng('data/progg_game_icons/infinity_loop.png')
    screen:copyfrom(self.image, nil, { x = first_column+(command_width+row_spacing)+6,
        y = first_row+3*(command_height+col_spacing)+6, w=command_width-12, h = command_height-12 }, true)
    self.image:destroy()
end

-------------------------------------
-- Called to replace buttons for
-- use in the build area
-- @author Vilhelm
-------------------------------------
function RightMenu:buildLayout()
    self.draw:drawTwoBoxRow(4,78,113,215)
    self.draw:addPlayAndBack()
end

return RightMenu