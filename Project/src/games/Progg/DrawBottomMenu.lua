--
-- Created by IntelliJ IDEA.
-- User: Mikael
-- Date: 11/16/2015
-- Time: 11:08 AM
-- To change this template use File | Settings | File Templates.
--

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
function DrawBottomMenu:icons(queue, inputArea)

    if #queue > self.maxCommands[inputArea] then
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
function DrawBottomMenu:allIcons(queue, inputArea)
    for i=1, #queue do
        if i > self.maxCommands[inputArea] then
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
function DrawBottomMenu:highlightIcon(pos, prevPos, queue)
    if pos > 2*self.rowLength then
        return;
    end
    if queue[pos] ~= nil then
        self.image = gfx.loadpng(self:getFileName(queue[pos]))
        if pos <= self.rowLength then
            screen:clear({r = 255, g = 192, b = 0}, {x = screen:get_width()*(0.038 + (pos-1)*0.055) - 3, y = screen:get_height()*0.7435 - 3, w = 6 + screen:get_width()*0.039, h = 6 + screen:get_height()*0.068 })
            screen:clear({r = 255, g = 255, b = 251 }, { x = screen:get_width()*(0.038 + (pos-1)*0.055), y = screen:get_height()*0.7435, w = screen:get_width()*0.039, h = screen:get_height()*0.068 })
            screen:copyfrom(self.image, nil, { x = screen:get_width()*(0.038 + (pos-1)*0.055), y = screen:get_height()*0.744, w=screen:get_width()*0.038, h = screen:get_height()*0.066 }, true)
        else
            screen:clear({r = 255, g = 192, b = 0}, {x = screen:get_width()*(0.038 + (pos-self.rowLength -1)*0.055) - 3, y = screen:get_height()*0.8435 - 3, w = screen:get_width()*0.039, w = 6 + screen:get_width()*0.039, h = 6 + screen:get_height()*0.068 })
            screen:clear({r = 255, g = 255, b = 251}, { x = screen:get_width()*(0.038 + (pos-self.rowLength -1)*0.055), y = screen:get_height()*0.8435, w = screen:get_width()*0.039, h = screen:get_height()*0.068 })
            screen:copyfrom(self.image, nil, { x = screen:get_width()*(0.038 + (pos-self.rowLength -1)*0.055), y = screen:get_height()*0.844, w=screen:get_width()*0.038, h = screen:get_height()*0.066 }, true)
        end
        self.image:destroy()
        collectgarbage()
    else
        if pos <= self.rowLength then
            screen:clear({r = 255, g = 192, b = 0}, {x = screen:get_width()*(0.038 + (pos-1)*0.055) - 3, y = screen:get_height()*0.7435 - 3, w = 6 + screen:get_width()*0.039, h = 6 + screen:get_height()*0.068 })
            screen:clear({r = 78, g = 113, b = 215  }, { x = screen:get_width()*(0.038 + (pos-1)*0.055), y = screen:get_height()*0.7435, w = screen:get_width()*0.039, h = screen:get_height()*0.068 })
        else
            screen:clear({r = 255, g = 192, b = 0}, {x = screen:get_width()*(0.038 + (pos-self.rowLength -1)*0.055) - 3, y = screen:get_height()*0.8435 - 3, w = screen:get_width()*0.039, w = 6 + screen:get_width()*0.039, h = 6 + screen:get_height()*0.068 })
            screen:clear({r = 78, g = 113, b = 215}, { x = screen:get_width()*(0.038 + (pos-self.rowLength -1)*0.055), y = screen:get_height()*0.8435, w = screen:get_width()*0.039, h = screen:get_height()*0.068 })
        end
    end

    if prevPos ~= nil then
        self:clearPos(prevPos, queue)
    end
end

---------------------------------------------
-- Clears the previous position.
-- @param pos:Integer, queue:Queue. The position to be cleared and the queue of commands.
---------------------------------------------
function DrawBottomMenu:clearPos(pos, queue)
    if pos > 2*self.rowLength then
        return;
    end
    if queue[pos] ~= nil then
        self.image = gfx.loadpng(self:getFileName(queue[pos]))
        if pos <= self.rowLength then
            screen:clear({r = 255, g = 255, b = 251 }, { x = screen:get_width()*(0.038 + (pos-1)*0.055) - 3, y = screen:get_height()*0.7435 - 3, w = screen:get_width()*0.039, w = 6 + screen:get_width()*0.039, h = 6 + screen:get_height()*0.068})
            screen:copyfrom(self.image, nil, { x = screen:get_width()*(0.038 + (pos-1)*0.055), y = screen:get_height()*0.744, w=screen:get_width()*0.038, h = screen:get_height()*0.066 }, true)
        else
            screen:clear({r = 255, g = 255, b = 251 }, { x = screen:get_width()*(0.038 + (pos - self.rowLength - 1)*0.055) - 3, y = screen:get_height()*0.8435 - 3, w = screen:get_width()*0.039, w = 6 + screen:get_width()*0.039, h = 6 + screen:get_height()*0.068  })
            screen:copyfrom(self.image, nil, { x = screen:get_width()*(0.038 + (pos - self.rowLength - 1)*0.055), y = screen:get_height()*0.844, w=screen:get_width()*0.038, h = screen:get_height()*0.066 }, true)
        end
        self.image:destroy()
        collectgarbage()
    else
        if pos <= self.rowLength then
            screen:clear({r = 78, g = 113, b = 215 }, { x = screen:get_width()*(0.038 + (pos-1)*0.055) - 3, y = screen:get_height()*0.7435 - 3, w = screen:get_width()*0.039, w = 6 + screen:get_width()*0.039, h = 6 + screen:get_height()*0.068 })
        else
            screen:clear({r = 78, g = 113, b = 215 }, { x = screen:get_width()*(0.038 + (pos - self.rowLength - 1)*0.055) - 3, y = screen:get_height()*0.8435 - 3, w = screen:get_width()*0.039, w = 6 + screen:get_width()*0.039, h = 6 + screen:get_height()*0.068 })
        end
    end
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
    end
end


return DrawBottomMenu
