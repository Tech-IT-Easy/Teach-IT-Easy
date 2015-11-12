-----------------------------------------------------------
--This class draws the build area and handles the building
--of procedures and loops
--
-- @Author:Created by Mikael Ögren, Nov 11,2015
-- @Author:Updated by author,date
-----------------------------------------------------------

local Object = require("toolkit.Object")
local BuildArea = extends(Object.class())

function BuildArea:new(maxCommands)
    self.availableSlots = maxCommands
    self.loopQueue = {}
    self.p1Queue = {}
    self.p2Queue = {}
    return self.class()
end

function BuildArea:load()
 self.move = gfx.loadpng('data/progg_game_icons/arrow_up.png')
    self.turnLeft = gfx.loadpng('data/progg_game_icons/turn_left.png')
    self.turnRight = gfx.loadpng('data/progg_game_icons/turn_right.png')
    self.action = gfx.loadpng('data/progg_game_icons/action.png')
    self.ifWall = gfx.loadpng('data/progg_game_icons/if_wall.png')
    self.loop = gfx.loadpng('data/progg_game_icons/loop.png')
    self.p1 = gfx.loadpng('data/progg_game_icons/P1.png')
    self.p2 = gfx.loadpng('data/progg_game_icons/P2.png')
    self.images = {["move"]=self.move, ["turn-left"]=self.turnLeft, ["turn-right"]=self.turnRight,
        ["commandname1"]=self.action, ["commandname2"]=self.ifWall, ["loop"]=self.loop, ["P1"]=self.p1, ["P2"]=self.p2}
end

function BuildArea:setBuildType(buildType)
    self.buildType = buildType
end

function BuildArea:setQueue(queue, queueType)
    if queueType == "loop" then
        self.loopQueue = queue
    elseif queueType == "P1" then
        self.p1Queue = queue
    elseif queueType == "P2" then
        self.p2Queue = queue
    end
end

function BuildArea:show()
    if self.buildType == "P1" then
        self:drawEmptySlots(self.availableSlots)
        self:drawIcons(self.p1Queue)
    elseif self.buildType == "loop" then
        self:drawEmptySlots(self.availableSlots)
        self:drawIcons(self.loopQueue)
        self:drawTimesLooped()
    end
end

-------------------------------------
-- Draw all empty command slots for procedure/loop.
-- @param maxCommands. How many commands slots that are available to the player.
-- @author Mikael Ögren
-------------------------------------
function BuildArea:drawEmptySlots(maxCommands)
    for i=1, maxCommands do
            self:drawSingleEmptySlot(i)
    end
end

-------------------------------------
-- Draws a single empty command slot
-- @param boxNmb. The number of the box being drawn.
-- @author Mikael Ögren
-------------------------------------
function BuildArea:drawSingleEmptySlot(boxNmb)
    if boxNmb <= 8 then
        screen:clear({r = 235, g = 235, b = 235 }, { x = screen:get_width()*(0.535 + (boxNmb-1)*0.055), y = screen:get_height()*0.74, w = screen:get_width()*0.045, h = screen:get_height()*0.075 }) --r = 78, g = 113, b = 215
    else
        screen:clear({r = 235, g = 235, b = 235 }, { x = screen:get_width()*(0.535 + (boxNmb-9)*0.055), y = screen:get_height()*0.84, w = screen:get_width()*0.045, h = screen:get_height()*0.075 })
    end
end

-------------------------------------
-- Draws the icons for the bottom right menu.
-- @param queue. The queue of commands. An array of strings.
-- @author Mikael Ögren
-------------------------------------
function BuildArea:drawIcons(queue)
    for i = 1, #queue do
        if i <= 8 then
            screen:clear({r = 255, g = 255, b = 251 }, { x = screen:get_width()*(0.538 + (i-1)*0.055), y = screen:get_height()*0.7435, w = screen:get_width()*0.039, h = screen:get_height()*0.068 })
            screen:copyfrom(self.images[queue[i]], nil, { x = screen:get_width()*(0.538 + (i-1)*0.055), y = screen:get_height()*0.744, w=screen:get_width()*0.038, h = screen:get_height()*0.066 }, true)
        else
            screen:clear({r = 255, g = 255, b = 251 }, { x = screen:get_width()*(0.538 + (i-9)*0.055), y = screen:get_height()*0.8435, w = screen:get_width()*0.039, h = screen:get_height()*0.068 })
            screen:copyfrom(self.images[queue[i]], nil, { x = screen:get_width()*(0.538 + (i-9)*0.055), y = screen:get_height()*0.844, w=screen:get_width()*0.038, h = screen:get_height()*0.066 }, true)
        end
    end
end

function BuildArea:drawTimesLooped()
    screen:clear({r = 255, g = 255, b = 251 }, { x = screen:get_width()*(0.87), y = screen:get_height()*0.66, w = screen:get_width()*0.080, h = screen:get_height()*0.060 })
end

return BuildArea