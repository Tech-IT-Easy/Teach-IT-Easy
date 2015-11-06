-----------------------------------------------------------
-- This class keeps track of the images and position of the
-- commands in the bottom menu based on how they're
-- organized in the queue.
--
-- @Author:Created by Mikael Ögren, Nov 04,2015
-- @Author:Updated by author,date
-----------------------------------------------------------

local Object = require("toolkit.Object")
local BottomMenu = extends(Object.class())
BottomMenu.ImageArray={}
BottomMenu.Position={}


--Constructor method
function BottomMenu:new(maxCommands)
    self.availableSlots = maxCommands
    return self.class()
end

-- Used to load images
function BottomMenu:load()

end

--
-------------------------------------
-- Draw all empty command slots for current level.
-- @param maxCommands. How many commands slots that are available to the player.
-- @author Mikael Ögren
-------------------------------------
function BottomMenu:drawEmptySlots(maxCommands)
    for i=1, maxCommands do
            self:drawSingleEmptySlot(i)
    end
end

-------------------------------------
-- Draws a single empty command slot
-- @param boxNmb. The number of the box being drawn.
-- @author Mikael Ögren
-------------------------------------
function CreateProfile:drawSingleEmptySlot(boxNmb)
    if boxNmb <= 8 then
        screen:clear({r = 78, g = 113, b = 215 }, { x = screen:get_width()*(0.035 + (boxNmb-1)*0.055), y = screen:get_height()*0.74, w = screen:get_width()*0.045, h = screen:get_height()*0.075 }) --r = 78, g = 113, b = 215
    else
        screen:clear({r = 78, g = 113, b = 215 }, { x = screen:get_width()*(0.035 + (boxNmb-9)*0.055), y = screen:get_height()*0.84, w = screen:get_width()*0.045, h = screen:get_height()*0.075 })
    end
end

-------------------------------------
-- Draws the background for BottomMenu
-- @author Mikael Ögren
-------------------------------------
function CreateProfile:drawBackground()
    screen:clear({r = 27, g = 39, b = 53 }, { x = 0, y = screen:get_height() * 0.65, w = screen:get_width(), h = screen:get_height() * 0.35 })
    screen:clear({r = 35, g = 73, b = 120 }, { x = screen:get_width() * 0.03, y = screen:get_height() * 0.7, w = screen:get_width() * 0.44, h = screen:get_height() * 0.25 })
    screen:clear({r = 209, g = 209, b = 209 }, { x = screen:get_width() * 0.53, y = screen:get_height() * 0.7, w = screen:get_width() * 0.44, h = screen:get_height() * 0.25 })
end

--Rearranges the positions according to the queue positions
function BottomMenu:rearrage(queue)
    for i, command in queue(command) do
        self.Position[i] = queue[i]
    end
end

return BottomMenu
