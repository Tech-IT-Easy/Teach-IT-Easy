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


--Constructor method
function BottomMenu:new(maxCommands)
    self.availableSlots = maxCommands
    self.queue = {'move', 'turn-right', 'turn-left', 'turn-left', 'turn-right', 'turn-left', 'turn-right', 'turn-left', 'turn-left', 'turn-left', 'turn-left', 'turn-left', 'move'}  -- test Queue
    return self.class()
end

-- Used to load images
function BottomMenu:load()
    move = gfx.loadpng('data/progg_game_icons/arrow_up.png')
    turnLeft = gfx.loadpng('data/progg_game_icons/turn_left.png')
    turnRight = gfx.loadpng('data/progg_game_icons/turn_right.png')
    action = gfx.loadpng('data/progg_game_icons/action.png')
    ifWall = gfx.loadpng('data/progg_game_icons/if_wall.png')
    loopStart = gfx.loadpng('data/progg_game_icons/loop.png')
    p1 = gfx.loadpng('data/progg_game_icons/P1.png')
    p2 = gfx.loadpng('data/progg_game_icons/P2.png')
    images = {["move"]=move, ["turn-left"]=turnLeft, ["turn-right"]=turnRight, ["commandname1"]=action, ["commandname2"]=ifWall, ["commandname3"]=loopStart, ["commandname4"]=p1, ["commandname5"]=p2}
    self:drawBackground()
    self:drawEmptySlots(self.availableSlots)
    self:drawIcons(self.queue)
end

function BottomMenu:show()


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
function BottomMenu:drawSingleEmptySlot(boxNmb)
    if boxNmb <= 8 then
        screen:clear({r = 78, g = 113, b = 215 }, { x = screen:get_width()*(0.035 + (boxNmb-1)*0.055), y = screen:get_height()*0.74, w = screen:get_width()*0.045, h = screen:get_height()*0.075 }) --r = 78, g = 113, b = 215
    else
        screen:clear({r = 78, g = 113, b = 215 }, { x = screen:get_width()*(0.035 + (boxNmb-9)*0.055), y = screen:get_height()*0.84, w = screen:get_width()*0.045, h = screen:get_height()*0.075 })
    end
end

-------------------------------------
-- Draws the background for the bottom left menu
-- @author Mikael Ögren
-------------------------------------
function BottomMenu:drawBackground()
    screen:clear({r = 27, g = 39, b = 53 }, { x = 0, y = screen:get_height() * 0.65, w = screen:get_width(), h = screen:get_height() * 0.35 })
    screen:clear({r = 35, g = 73, b = 120 }, { x = screen:get_width() * 0.03, y = screen:get_height() * 0.6999, w = screen:get_width() * 0.44, h = screen:get_height() * 0.25 })
    screen:clear({r = 209, g = 209, b = 209 }, { x = screen:get_width() * 0.53, y = screen:get_height() * 0.6999, w = screen:get_width() * 0.44, h = screen:get_height() * 0.25 })
end

--Rearranges the positions according to the queue positions
function BottomMenu:rearrage(queue)
    for i, command in queue(command) do
        self.Position[i] = queue[i]
    end
end


-------------------------------------
-- Draws the icons for the bottom left menu.
-- @param queue. The queue of commands. An array of strings.
-- @author Mikael Ögren
-------------------------------------
function BottomMenu:drawIcons(queue)
    for i = 1, #queue do
        if i <= 8 then
            screen:clear({r = 255, g = 255, b = 251 }, { x = screen:get_width()*(0.038 + (i-1)*0.055), y = screen:get_height()*0.7435, w = screen:get_width()*0.039, h = screen:get_height()*0.068 })
            screen:copyfrom(images[queue[i]], nil, { x = screen:get_width()*(0.038 + (i-1)*0.055), y = screen:get_height()*0.744, w=screen:get_width()*0.038, h = screen:get_height()*0.066 }, true)
        else
            screen:clear({r = 255, g = 255, b = 251 }, { x = screen:get_width()*(0.038 + (i-9)*0.055), y = screen:get_height()*0.8435, w = screen:get_width()*0.039, h = screen:get_height()*0.068 })
            screen:copyfrom(images[queue[i]], nil, { x = screen:get_width()*(0.038 + (i-9)*0.055), y = screen:get_height()*0.844, w=screen:get_width()*0.038, h = screen:get_height()*0.066 }, true)
        end
    end
end

return BottomMenu
