--
-- Created by IntelliJ IDEA.
-- User: Mikael
-- Date: 11/16/2015
-- Time: 1:41 PM
-- To change this template use File | Settings | File Templates.
--

local Object = require("toolkit.Object")
local DrawBuildArea = extends(Object)
skin = require('games.Progg.progg_skin')

function DrawBuildArea:new(maxCommands)
    local o = DrawBuildArea:super()
    o.maxCommands = maxCommands
    o.rowLength = 8
    return DrawBuildArea:init(o)
end

------------------------------------
-- Draw all empty command slots for procedure/loop.
-- @param maxCommands, inputArea. How many commands slots that are available to the player and the active input area.
-- @author Mikael Ögren
-------------------------------------
function DrawBuildArea:emptySlots(inputArea, active)

    for i=1, self.maxCommands[inputArea] do
        self:singleEmptySlot(i, inputArea, active)
    end
end

-------------------------------------
-- Draws a single empty command slot
-- @param boxNmb, inputArea. The number of the box being drawn and the active input area.
-- @author Mikael Ögren
-------------------------------------
function DrawBuildArea:singleEmptySlot(boxNmb, inputArea, active)
    if (active == false) then
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
function DrawBuildArea:icons(queue, inputArea)
    if queue ~= nil then
        if #queue > self.maxCommands[inputArea] then
            return;
        end
        if queue[#queue] ~= nil then
            self.image = gfx.loadpng(self:getFileName(queue[#queue]))
            if #queue <= 8 then
                screen:clear({r = 255, g = 255, b = 251 }, { x = screen:get_width()*(0.538 + (#queue-1)*0.055), y = screen:get_height()*0.7435, w = screen:get_width()*0.039, h = screen:get_height()*0.068 })
                screen:copyfrom(self.image, nil, { x = screen:get_width()*(0.538 + (#queue-1)*0.055), y = screen:get_height()*0.744, w=screen:get_width()*0.038, h = screen:get_height()*0.066 }, true)
            else
                screen:clear({r = 255, g = 255, b = 251 }, { x = screen:get_width()*(0.538 + (#queue-9)*0.055), y = screen:get_height()*0.8435, w = screen:get_width()*0.039, h = screen:get_height()*0.068 })
                screen:copyfrom(self.image, nil, { x = screen:get_width()*(0.538 + (#queue-9)*0.055), y = screen:get_height()*0.844, w=screen:get_width()*0.038, h = screen:get_height()*0.066 }, true)
            end
            self.image:destroy()
            collectgarbage()
        end
    end
end

-----------------------------------
-- Draws icons for all the commands in the queue.
-- @param queue:Queue. The queue of commands. An array of strings.
-- @author Tobias Lundell
-----------------------------------
function DrawBuildArea:allIcons(queue, inputArea)
    if queue ~= nil then
        if #queue > self.maxCommands[inputArea] then
            return;
        end
        for i=1, #queue do
            if queue[i] ~= nil then
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
    end
end

------
--Highlights an icon
--
----------
function DrawBuildArea:highlightIcon(position,prevPos, queue, posToBeMoved)
    if position < 17 or queue == nil then
        return;
    end
    self.pos = position - 16
    if queue[self.pos] ~= nil then
        self.image = gfx.loadpng(self:getFileName(queue[self.pos]))
                if self.pos <= self.rowLength then
                    if (posToBeMoved == position) then
                        screen:clear({r = 255, g = 0, b = 0}, {x = screen:get_width()*(0.538 + (self.pos-1)*0.055) - highlight_border_thickness, y = screen:get_height()*0.7435 - highlight_border_thickness, w = 2*highlight_border_thickness + screen:get_width()*0.039, h = 2*highlight_border_thickness + screen:get_height()*0.068 })
                    else
                        screen:clear({r = 255, g = 192, b = 0}, {x = screen:get_width()*(0.538 + (self.pos-1)*0.055) - highlight_border_thickness, y = screen:get_height()*0.7435 - highlight_border_thickness, w = 2*highlight_border_thickness + screen:get_width()*0.039, h = 2*highlight_border_thickness + screen:get_height()*0.068 })
                    end
                    screen:clear({r = 255, g = 255, b = 251 }, { x = screen:get_width()*(0.538 + (self.pos-1)*0.055), y = screen:get_height()*0.7435, w = screen:get_width()*0.039, h = screen:get_height()*0.068 })
                    screen:copyfrom(self.image, nil, { x = screen:get_width()*(0.538 + (self.pos-1)*0.055), y = screen:get_height()*0.744, w=screen:get_width()*0.038, h = screen:get_height()*0.066 }, true)
                else
                    if (posToBeMoved == position) then
                        screen:clear({r = 255, g = 0, b = 0}, {x = screen:get_width()*(0.538 + (self.pos-1)*0.055) - highlight_border_thickness, y = screen:get_height()*0.7435 - highlight_border_thickness, w = 2*highlight_border_thickness + screen:get_width()*0.039, h = 2*highlight_border_thickness + screen:get_height()*0.068 })
                    else
                        screen:clear({r = 255, g = 192, b = 0}, {x = screen:get_width()*(0.538 + (self.pos-self.rowLength -1)*0.055) - highlight_border_thickness, y = screen:get_height()*0.8435 - highlight_border_thickness, w = screen:get_width()*0.039, w = 2*highlight_border_thickness + screen:get_width()*0.039, h = 2*highlight_border_thickness + screen:get_height()*0.068 })
                    end
                    screen:clear({r = 255, g = 255, b = 251}, { x = screen:get_width()*(0.538 + (self.pos-self.rowLength -1)*0.055), y = screen:get_height()*0.8435, w = screen:get_width()*0.039, h = screen:get_height()*0.068 })
                    screen:copyfrom(self.image, nil, { x = screen:get_width()*(0.538 + (self.pos-self.rowLength -1)*0.055), y = screen:get_height()*0.844, w=screen:get_width()*0.038, h = screen:get_height()*0.066 }, true)
                end
                self.image:destroy()
                collectgarbage()
            else
                if self.pos <= self.rowLength then
                    screen:clear({r = 255, g = 192, b = 0}, {x = screen:get_width()*(0.538 + (self.pos-1)*0.055) - highlight_border_thickness, y = screen:get_height()*0.7435 - highlight_border_thickness, w = 2*highlight_border_thickness + screen:get_width()*0.039, h = 2*highlight_border_thickness + screen:get_height()*0.068 })
                    screen:clear({r = 78, g = 113, b = 215  }, { x = screen:get_width()*(0.538 + (self.pos-1)*0.055), y = screen:get_height()*0.7435, w = screen:get_width()*0.039, h = screen:get_height()*0.068 })
                else
                    screen:clear({r = 255, g = 192, b = 0}, {x = screen:get_width()*(0.538 + (self.pos-self.rowLength -1)*0.055) - highlight_border_thickness, y = screen:get_height()*0.8435 - highlight_border_thickness, w = screen:get_width()*0.039, w = 2*highlight_border_thickness + screen:get_width()*0.039, h = 2*highlight_border_thickness + screen:get_height()*0.068 })
                    screen:clear({r = 78, g = 113, b = 215}, { x = screen:get_width()*(0.538 + (self.pos-self.rowLength -1)*0.055), y = screen:get_height()*0.8435, w = screen:get_width()*0.039, h = screen:get_height()*0.068 })
                end
            end

    if prevPos ~= nil then
        self:clearPos(prevPos, queue, posToBeMoved)
    end
end

--------------------
--- Clears a highlight from a position1
---
---------------------
function DrawBuildArea:clearPos(pos, queue, posToBeMoved)
    if pos < 17 or pos == posToBeMoved then
        return;
    end
    self.pos = pos - 16
    if queue[self.pos] ~= nil then
        self.image = gfx.loadpng(self:getFileName(queue[self.pos]))
        if self.pos <= 8 then
            screen:clear({r = 255, g = 255, b = 251 }, { x = screen:get_width()*(0.538 + (self.pos-1)*0.055) - highlight_border_thickness, y = screen:get_height()*0.7435 - highlight_border_thickness, w = screen:get_width()*0.039, w = 2*highlight_border_thickness + screen:get_width()*0.039, h = 2*highlight_border_thickness + screen:get_height()*0.068})
            --screen:clear({r = 255, g = 255, b = 251 }, { x = screen:get_width()*(0.538 + (self.pos-1)*0.055), y = screen:get_height()*0.7435, w = screen:get_width()*0.039, h = screen:get_height()*0.068 })
            screen:copyfrom(self.image, nil, { x = screen:get_width()*(0.538 + (self.pos-1)*0.055), y = screen:get_height()*0.744, w=screen:get_width()*0.038, h = screen:get_height()*0.066 }, true)
        else
            screen:clear({r = 255, g = 255, b = 251 }, { x = screen:get_width()*(0.538 + (self.pos-9)*0.055) - highlight_border_thickness, y = screen:get_height()*0.8435 - highlight_border_thickness, w = screen:get_width()*0.039, w = 2*highlight_border_thickness + screen:get_width()*0.039, h = 2*highlight_border_thickness + screen:get_height()*0.068  })
            --screen:clear({r = 255, g = 255, b = 251 }, { x = screen:get_width()*(0.538 + (self.pos-9)*0.055), y = screen:get_height()*0.8435, w = screen:get_width()*0.039, h = screen:get_height()*0.068 })
            screen:copyfrom(self.image, nil, { x = screen:get_width()*(0.538 + (self.pos-9)*0.055), y = screen:get_height()*0.844, w=screen:get_width()*0.038, h = screen:get_height()*0.066 }, true)
        end
        self.image:destroy()
        collectgarbage()
    else
        if self.pos <= 8 then
            screen:clear({r = 78, g = 113, b = 215 }, { x = screen:get_width()*(0.538 + (self.pos-1)*0.055) - highlight_border_thickness, y = screen:get_height()*0.7435 - highlight_border_thickness, w = screen:get_width()*0.039, w = 2*highlight_border_thickness + screen:get_width()*0.039, h = 2*highlight_border_thickness + screen:get_height()*0.068 })
            --screen:clear({r = 78, g = 113, b = 215}, { x = screen:get_width()*(0.538 + (self.pos-1)*0.055), y = screen:get_height()*0.7435, w = screen:get_width()*0.039, h = screen:get_height()*0.068 })
        else
            screen:clear({r = 78, g = 113, b = 215 }, { x = screen:get_width()*(0.538 + (self.pos-9)*0.055) - highlight_border_thickness, y = screen:get_height()*0.8435 - highlight_border_thickness, w = screen:get_width()*0.039, w = 2*highlight_border_thickness + screen:get_width()*0.039, h = 2*highlight_border_thickness + screen:get_height()*0.068 })
            --screen:clear({r = 78, g = 113, b = 215 }, { x = screen:get_width()*(0.538 + (self.pos-9)*0.055), y = screen:get_height()*0.8435, w = screen:get_width()*0.039, h = screen:get_height()*0.068 })
        end
    end
end

-------------------------------------
-- Draws headline for the right build area in the bottom menu.
-- @param buildType:String, inputArea:String. The active build type and the active input area.
-- @author Mikael Ögren; Tobias Lundell
-------------------------------------
function DrawBuildArea:headLine(buildType, inputArea)

    if buildType ~= nil then
        right_buildarea_headline:draw_over_surface(screen, buildType)
        collectgarbage()
    end
end

--------------------------------------
-- Draws the loop counter over the build area for build type loop.
-- @param counter:Integer. The loop counter.
-- @author Tobias Lundell
--------------------------------------
function DrawBuildArea:drawLoopCounter(counter)
    if counter ~= nil and counter ~= 999 then
        screen:clear({r = 255, g = 255, b = 251 }, { x = screen:get_width()*(0.87), y = screen:get_height()*0.65, w = screen:get_width()*0.040, h = screen:get_height()*0.060 })
        right_buildarea_loopcounter:draw_over_surface(screen, counter)
    elseif counter == 999 then
        self.image = gfx.loadpng(self:getFileName("infinity-loop"))
        screen:copyfrom(self.image, nil, { x = screen:get_width()*(0.869), y =screen:get_height()*0.65, w=screen:get_width()*0.040, h = screen:get_height()*0.060 }, true)
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
    elseif action =="infinity-loop" then
        return "data/progg_game_icons/infinity_loop.png"
        
    elseif action == "fix" then
        return "data/progg_game_icons/action.png"
    end
end


return DrawBuildArea
