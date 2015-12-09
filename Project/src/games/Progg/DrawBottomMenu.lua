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
-- This class holds function for drawing
-- the bottom menu in the programming
-- game.
-- @author Mikael Ögren; Tobias Lundell
------------------------------------

skin = require('menus.skin')
local Object = require("toolkit.Object")
local DrawBottomMenu = extends(Object)

function DrawBottomMenu:new(maxCommands)
    local o = DrawBottomMenu:super()
    o.maxCommands = maxCommands
    o.queue = {}
    o.rowLength = 8
    return DrawBottomMenu:init(o)
end

-------------------------------------
-- Draw all empty command slots for current level.
-- @param maxCommands. How many commands slots that are available to the player.
-- @author Mikael Ögren
-------------------------------------
function DrawBottomMenu:emptySlots(inputArea)
    for i=1, self.maxCommands["queue"] do
        self:singleEmptySlot(i, inputArea)
    end
end

-------------------------------------
-- Draws a single empty command slot
-- @param boxNmb. The number of the box being drawn.
-- @author Mikael Ögren
-------------------------------------
function DrawBottomMenu:singleEmptySlot(boxNmb, inputArea)

    if (inputArea == "queue") then
        if boxNmb <= self.rowLength then
            screen:clear({r = 78, g = 113, b = 215 }, { x = screen:get_width()*(0.035 + (boxNmb-1)*0.055), y = screen:get_height()*0.74, w = screen:get_width()*0.045, h = screen:get_height()*0.075 }) --r = 78, g = 113, b = 215
        else
            screen:clear({r = 78, g = 113, b = 215 }, { x = screen:get_width()*(0.035 + (boxNmb - self.rowLength - 1)*0.055), y = screen:get_height()*0.84, w = screen:get_width()*0.045, h = screen:get_height()*0.075 })
        end
    else
        if boxNmb <= self.rowLength then
            screen:clear({ r = 235, g = 235, b = 235 }, { x = screen:get_width()*(0.035 + (boxNmb-1)*0.055), y = screen:get_height()*0.74, w = screen:get_width()*0.045, h = screen:get_height()*0.075 }) --r = 78, g = 113, b = 215
        else
            screen:clear({ r = 235, g = 235, b = 235 }, { x = screen:get_width()*(0.035 + (boxNmb - self.rowLength - 1)*0.055), y = screen:get_height()*0.84, w = screen:get_width()*0.045, h = screen:get_height()*0.075 })
        end
    end
end


-------------------------------------
-- Draws the background for the bottom left menu
-- @author Mikael Ögren
-------------------------------------
function DrawBottomMenu:background(inputArea)
    screen:clear({r = 27, g = 39, b = 53 }, { x = 0, y = screen:get_height() * 0.65, w = screen:get_width(), h = screen:get_height() * 0.35 })

    if (inputArea == "queue") then
        screen:clear({r = 35, g = 73, b = 120 }, { x = screen:get_width() * 0.03, y = screen:get_height() * 0.6999, w = screen:get_width() * 0.44, h = screen:get_height() * 0.25 })
        screen:clear({r = 209, g = 209, b = 209 }, { x = screen:get_width() * 0.53, y = screen:get_height() * 0.6999, w = screen:get_width() * 0.44, h = screen:get_height() * 0.25 })
    else
        screen:clear({r = 209, g = 209, b = 209 }, { x = screen:get_width() * 0.03, y = screen:get_height() * 0.6999, w = screen:get_width() * 0.44, h = screen:get_height() * 0.25 })
        screen:clear({r = 35, g = 73, b = 120 }, { x = screen:get_width() * 0.53, y = screen:get_height() * 0.6999, w = screen:get_width() * 0.44, h = screen:get_height() * 0.25 })
    end
end


-------------------------------------
-- Draws the icon for the last added action in the queue for the bottom left menu.
-- @param queue. The queue of commands. An array of strings.
-- @author Mikael Ögren
-------------------------------------
function DrawBottomMenu:icons(queue)

    if #queue > self.maxCommands["queue"] then
        return;
    end
    if queue[#queue] ~= nil then
        self.image = gfx.loadpng(self:getFileName(queue[#queue]))
        if #queue <= self.rowLength then
            screen:clear({r = 255, g = 255, b = 251 }, { x = screen:get_width()*(0.038 + (#queue-1)*0.055), y = screen:get_height()*0.7435, w = screen:get_width()*0.039, h = screen:get_height()*0.068 })
            screen:copyfrom(self.image, nil, { x = screen:get_width()*(0.038 + (#queue-1)*0.055), y = screen:get_height()*0.744, w=screen:get_width()*0.038, h = screen:get_height()*0.066 }, true)
        else
            screen:clear({r = 255, g = 255, b = 251 }, { x = screen:get_width()*(0.038 + (#queue-9)*0.055), y = screen:get_height()*0.8435, w = screen:get_width()*0.039, h = screen:get_height()*0.068 })
            screen:copyfrom(self.image, nil, { x = screen:get_width()*(0.038 + (#queue-9)*0.055), y = screen:get_height()*0.844, w=screen:get_width()*0.038, h = screen:get_height()*0.066 }, true)
        end
        self.image:destroy()
        collectgarbage()
    end
end

----------------------------------------
-- Draws the icons for all the actions in the queue for the bottom left menu.
-- @param queue:Queue. The queue of commands. An array of strings.
-- @author Tobias Lundell
----------------------------------------
function DrawBottomMenu:allIcons(queue)
    for i=1, #queue do
        if i > self.maxCommands["queue"] then
            return;
        end
        if queue[i] ~= nil then
            self.image = gfx.loadpng(self:getFileName(queue[i]))
            if i <= self.rowLength then
                screen:clear({r = 255, g = 255, b = 251 }, { x = screen:get_width()*(0.038 + (i-1)*0.055), y = screen:get_height()*0.7435, w = screen:get_width()*0.039, h = screen:get_height()*0.068 })
                screen:copyfrom(self.image, nil, { x = screen:get_width()*(0.038 + (i-1)*0.055), y = screen:get_height()*0.744, w=screen:get_width()*0.038, h = screen:get_height()*0.066 }, true)
            else
                screen:clear({r = 255, g = 255, b = 251 }, { x = screen:get_width()*(0.038 + (i-9)*0.055), y = screen:get_height()*0.8435, w = screen:get_width()*0.039, h = screen:get_height()*0.068 })
                screen:copyfrom(self.image, nil, { x = screen:get_width()*(0.038 + (i-9)*0.055), y = screen:get_height()*0.844, w=screen:get_width()*0.038, h = screen:get_height()*0.066 }, true)
            end
            self.image:destroy()
            collectgarbage()
        end
    end
end

----------------------------------------
-- Highlights the active icon in the bottom menu.
--@param pos:Integer, prevPos:Integer, queue:Queue.
-- @author Mikael Ögren
----------------------------------------
function DrawBottomMenu:highlightIcon(pos, prevPos, queue, posToBeMoved)
    if pos > 2*self.rowLength then
        return;
    end
    if queue[pos] ~= nil then
        self.image = gfx.loadpng(self:getFileName(queue[pos]))
        if pos <= self.rowLength then
            if (posToBeMoved == pos) then
                screen:clear({r = 255, g = 0, b = 0}, {x = screen:get_width()*(0.038 + (pos-1)*0.055) - highlight_border_thickness, y = screen:get_height()*0.7435 - highlight_border_thickness, w = 2*highlight_border_thickness + screen:get_width()*0.039, h = 2*highlight_border_thickness + screen:get_height()*0.068 })
            else
                screen:clear({r = 255, g = 192, b = 0}, {x = screen:get_width()*(0.038 + (pos-1)*0.055) - highlight_border_thickness, y = screen:get_height()*0.7435 - highlight_border_thickness, w = 2*highlight_border_thickness + screen:get_width()*0.039, h = 2*highlight_border_thickness + screen:get_height()*0.068 })
            end
            screen:clear({r = 255, g = 255, b = 251 }, { x = screen:get_width()*(0.038 + (pos-1)*0.055), y = screen:get_height()*0.7435, w = screen:get_width()*0.039, h = screen:get_height()*0.068 })
            screen:copyfrom(self.image, nil, { x = screen:get_width()*(0.038 + (pos-1)*0.055), y = screen:get_height()*0.744, w=screen:get_width()*0.038, h = screen:get_height()*0.066 }, true)
        else
            if (posToBeMoved == pos) then
                screen:clear({r = 255, g = 0, b = 0}, {x = screen:get_width()*(0.038 + (pos-1)*0.055) - highlight_border_thickness, y = screen:get_height()*0.7435 - highlight_border_thickness, w = 2*highlight_border_thickness + screen:get_width()*0.039, h = 2*highlight_border_thickness + screen:get_height()*0.068 })
            else
                screen:clear({r = 255, g = 192, b = 0}, {x = screen:get_width()*(0.038 + (pos-self.rowLength -1)*0.055) - highlight_border_thickness, y = screen:get_height()*0.8435 - highlight_border_thickness, w = screen:get_width()*0.039, w = 2*highlight_border_thickness + screen:get_width()*0.039, h = 2*highlight_border_thickness + screen:get_height()*0.068 })
            end
            screen:clear({r = 255, g = 255, b = 251}, { x = screen:get_width()*(0.038 + (pos-self.rowLength -1)*0.055), y = screen:get_height()*0.8435, w = screen:get_width()*0.039, h = screen:get_height()*0.068 })
            screen:copyfrom(self.image, nil, { x = screen:get_width()*(0.038 + (pos-self.rowLength -1)*0.055), y = screen:get_height()*0.844, w=screen:get_width()*0.038, h = screen:get_height()*0.066 }, true)
        end
        self.image:destroy()
        collectgarbage()
    else
        if pos <= self.rowLength then
            screen:clear({r = 255, g = 192, b = 0}, {x = screen:get_width()*(0.038 + (pos-1)*0.055) - highlight_border_thickness, y = screen:get_height()*0.7435 - highlight_border_thickness, w = 2*highlight_border_thickness + screen:get_width()*0.039, h = 2*highlight_border_thickness + screen:get_height()*0.068 })
            screen:clear({r = 78, g = 113, b = 215  }, { x = screen:get_width()*(0.038 + (pos-1)*0.055), y = screen:get_height()*0.7435, w = screen:get_width()*0.039, h = screen:get_height()*0.068 })
        else
            screen:clear({r = 255, g = 192, b = 0}, {x = screen:get_width()*(0.038 + (pos-self.rowLength -1)*0.055) - highlight_border_thickness, y = screen:get_height()*0.8435 - highlight_border_thickness, w = screen:get_width()*0.039, w = 2*highlight_border_thickness + screen:get_width()*0.039, h = 2*highlight_border_thickness + screen:get_height()*0.068 })
            screen:clear({r = 78, g = 113, b = 215}, { x = screen:get_width()*(0.038 + (pos-self.rowLength -1)*0.055), y = screen:get_height()*0.8435, w = screen:get_width()*0.039, h = screen:get_height()*0.068 })
        end
    end

    if prevPos ~= nil then
        self:clearPos(prevPos, queue, posToBeMoved)
    end
end

---------------------------------------------
-- Clears the previous position for highlighting.
-- @param pos:Integer, queue:Queue. The position to be cleared and the queue of commands.
---------------------------------------------
function DrawBottomMenu:clearPos(pos, queue, posToBeMoved)
    if (pos ~= posToBeMoved) then
        print (pos)
        if pos > 2*self.rowLength then
            return;
        end
        if queue[pos] ~= nil then
            self.image = gfx.loadpng(self:getFileName(queue[pos]))
            if pos <= self.rowLength then
                screen:clear({r = 255, g = 255, b = 251 }, { x = screen:get_width()*(0.038 + (pos-1)*0.055) - highlight_border_thickness, y = screen:get_height()*0.7435 - highlight_border_thickness, w = screen:get_width()*0.039, w = 2*highlight_border_thickness + screen:get_width()*0.039, h = 2*highlight_border_thickness + screen:get_height()*0.068})
                screen:copyfrom(self.image, nil, { x = screen:get_width()*(0.038 + (pos-1)*0.055), y = screen:get_height()*0.744, w=screen:get_width()*0.038, h = screen:get_height()*0.066 }, true)
            else
                screen:clear({r = 255, g = 255, b = 251 }, { x = screen:get_width()*(0.038 + (pos - self.rowLength - 1)*0.055) - highlight_border_thickness, y = screen:get_height()*0.8435 - highlight_border_thickness, w = screen:get_width()*0.039, w = 2*highlight_border_thickness + screen:get_width()*0.039, h = 2*highlight_border_thickness + screen:get_height()*0.068  })
                screen:copyfrom(self.image, nil, { x = screen:get_width()*(0.038 + (pos - self.rowLength - 1)*0.055), y = screen:get_height()*0.844, w=screen:get_width()*0.038, h = screen:get_height()*0.066 }, true)
            end
            self.image:destroy()
            collectgarbage()
        else
            if pos <= self.rowLength then
                screen:clear({r = 78, g = 113, b = 215 }, { x = screen:get_width()*(0.038 + (pos-1)*0.055) - highlight_border_thickness, y = screen:get_height()*0.7435 - highlight_border_thickness, w = screen:get_width()*0.039, w = 2*highlight_border_thickness + screen:get_width()*0.039, h = 2*highlight_border_thickness + screen:get_height()*0.068 })
            else
                screen:clear({r = 78, g = 113, b = 215 }, { x = screen:get_width()*(0.038 + (pos - self.rowLength - 1)*0.055) - highlight_border_thickness, y = screen:get_height()*0.8435 - highlight_border_thickness, w = screen:get_width()*0.039, w = 2*highlight_border_thickness + screen:get_width()*0.039, h = 2*highlight_border_thickness + screen:get_height()*0.068 })
            end
        end
    end
end

----------------------------------------
-- Draws a exit confirmation pop up on the screen.
--@ author Tobias Lundell
----------------------------------------
function DrawBottomMenu:exitPopUp()
    screen:clear({  r = 255,g = 255, b = 255}, { x = screen:get_width()*0.05 , y = screen:get_height()*0.1, w = screen:get_width()*0.65, h = screen:get_height()*0.46 })
    screen:clear({ r = 78, g = 113, b = 215  }, { x = screen:get_width()*0.07 , y = screen:get_height()*0.13, w = screen:get_width()*0.61, h = screen:get_height()*0.4 })
    exit_1:draw_over_surface(screen, "Are you sure that")
    exit_2:draw_over_surface(screen, "you want to exit?")
    exit_3:draw_over_surface(screen, "Press OK to confirm and")
    exit_4:draw_over_surface(screen, "BACK to return to game")
    collectgarbage()
end

-----------------------------------------
-- Draws a headline for the left input area in the bottom menu
-- @param name. The string that should be drawn as headline.
-- @author Tobias Lundell
-----------------------------------------
function DrawBottomMenu:headline(name)
    left_buildarea_headline:draw_over_surface(screen, name)
end

function DrawBottomMenu:getFileName(action)
    if action == "move" then
        return "data/progg_game_icons/arrow_up.png"

    elseif action == "turn-left" then
        return "data/progg_game_icons/turn_left.png"

    elseif action == "turn-right" then
        return "data/progg_game_icons/turn_right.png"

    elseif action == "action" then
        return "data/progg_game_icons/action.png"

    elseif action == "if-wall" then
        return "data/progg_game_icons/if_wall.png"

    elseif action == "loop" then
        return "data/progg_game_icons/loop.png"

    elseif action == "P1" then
        return "data/progg_game_icons/P1.png"

    elseif action == "P2" then
        return "data/progg_game_icons/P2.png"

    elseif action == "fix" then
        return "data/progg_game_icons/action.png"

    end
end


return DrawBottomMenu
