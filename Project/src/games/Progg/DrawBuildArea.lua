--
-- Created by IntelliJ IDEA.
-- User: Mikael
-- Date: 11/16/2015
-- Time: 1:41 PM
-- To change this template use File | Settings | File Templates.
--

local Object = require("toolkit.Object")
local DrawBuildArea = extends(Object)
skin = require('games/Progg/progg_skin')

function DrawBuildArea:new()
    local o = DrawBuildArea:super()
    return DrawBuildArea:init(o)
end

------------------------------------
-- Draw all empty command slots for procedure/loop.
-- @param maxCommands, inputArea. How many commands slots that are available to the player and the active input area.
-- @author Mikael Ögren
-------------------------------------
function DrawBuildArea:emptySlots(maxCommands, inputArea)
    for i=1, maxCommands do
            self:singleEmptySlot(i, inputArea)
    end
end

-------------------------------------
-- Draws a single empty command slot
-- @param boxNmb, inputArea. The number of the box being drawn and the active input area.
-- @author Mikael Ögren
-------------------------------------
function DrawBuildArea:singleEmptySlot(boxNmb, inputArea)
    if (inputArea == "queue") then
        if boxNmb <= 8 then
            screen:clear({ r = 235, g = 235, b = 235 }, { x = screen:get_width()*(0.535 + (boxNmb-1)*0.055), y = screen:get_height()*0.74, w = screen:get_width()*0.045, h = screen:get_height()*0.075 }) --r = 78, g = 113, b = 215
        else
            screen:clear({ r = 235, g = 235, b = 235 }, { x = screen:get_width()*(0.535 + (boxNmb-9)*0.055), y = screen:get_height()*0.84, w = screen:get_width()*0.045, h = screen:get_height()*0.075 })
        end
    else
        if boxNmb <= 8 then
            screen:clear({ r = 78, g = 113, b = 215 }, { x = screen:get_width()*(0.535 + (boxNmb-1)*0.055), y = screen:get_height()*0.74, w = screen:get_width()*0.045, h = screen:get_height()*0.075 }) --r = 78, g = 113, b = 215
        else
            screen:clear({ r = 78, g = 113, b = 215 }, { x = screen:get_width()*(0.535 + (boxNmb-9)*0.055), y = screen:get_height()*0.84, w = screen:get_width()*0.045, h = screen:get_height()*0.075 })
        end
    end
end
-------------------------------------
-- Draws the icons for the bottom right menu.
-- @param queue. The queue of commands. An array of strings.
-- @author Mikael Ögren
-------------------------------------
function DrawBuildArea:icons(queue)
    for i = 1, #queue do
        self.image = gfx.loadpng(self:getFileName(queue[i]))
        if i <= 8 then
            screen:clear({r = 255, g = 255, b = 251 }, { x = screen:get_width()*(0.538 + (i-1)*0.055), y = screen:get_height()*0.7435, w = screen:get_width()*0.039, h = screen:get_height()*0.068 })
            screen:copyfrom(self.image, nil, { x = screen:get_width()*(0.538 + (i-1)*0.055), y = screen:get_height()*0.744, w=screen:get_width()*0.038, h = screen:get_height()*0.066 }, true)
        else
            screen:clear({r = 255, g = 255, b = 251 }, { x = screen:get_width()*(0.538 + (i-9)*0.055), y = screen:get_height()*0.8435, w = screen:get_width()*0.039, h = screen:get_height()*0.068 })
            screen:copyfrom(self.image, nil, { x = screen:get_width()*(0.538 + (i-9)*0.055), y = screen:get_height()*0.844, w=screen:get_width()*0.038, h = screen:get_height()*0.066 }, true)
        end
        self.image:destroy()
        collectgarbage()
    end
end

-------------------------------------
-- Draws headline dependent of if loop or any of the procedures are shown.
-- @author Mikael Ögren
-------------------------------------
function DrawBuildArea:headLine(buildType)
    if buildType ~= nil then
        self.image = gfx.loadpng(self:getFileName(buildType))
        if buildType == "loop" then
            screen:clear({r = 255, g = 255, b = 251 }, { x = screen:get_width()*(0.87), y = screen:get_height()*0.66, w = screen:get_width()*0.080, h = screen:get_height()*0.060 })
            screen:clear({r = 255, g = 255, b = 251 }, { x = screen:get_width()*(0.55), y = screen:get_height()*0.66, w = screen:get_width()*0.080, h = screen:get_height()*0.060 })
            screen:copyfrom(self.image, nil, { x = screen:get_width()*(0.57), y = screen:get_height()*0.655, w=screen:get_width()*0.04, h = screen:get_height()*0.070 }, true)
            nr_on_loop:draw_over_surface(screen, "3")
        elseif buildType == "P1" then
            screen:clear({r = 255, g = 255, b = 251 }, { x = screen:get_width()*(0.55), y = screen:get_height()*0.66, w = screen:get_width()*0.080, h = screen:get_height()*0.060 })
            screen:copyfrom(self.image, nil, { x = screen:get_width()*(0.57), y = screen:get_height()*0.655, w=screen:get_width()*0.04, h = screen:get_height()*0.070 }, true)
        elseif buildType == "P2" then
            screen:clear({r = 255, g = 255, b = 251 }, { x = screen:get_width()*(0.55), y = screen:get_height()*0.66, w = screen:get_width()*0.080, h = screen:get_height()*0.060 })
            screen:copyfrom(self.image, nil, { x = screen:get_width()*(0.57), y = screen:get_height()*0.655, w=screen:get_width()*0.04, h = screen:get_height()*0.070 }, true)
        end
        self.image:destroy()
        collectgarbage()
    end
end

function DrawBuildArea:getFileName(action)
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

    end
end


return DrawBuildArea
