-----------------------------------------------------------
--This class draws the build area and handles the building
--of procedures and loops
--
-- @Author:Created by Mikael Ögren, Nov 11,2015
-- @Author:Updated by author,date
-----------------------------------------------------------

local Object = require("toolkit.Object")
local BuildArea = extends(Object)
local newDrawBuildArea = require("games.Progg.DrawBuildArea")

function BuildArea:new(maxCommands)
    local o = BuildArea:super()
    o.availableSlots = maxCommands
    o.loopQueue = {}
    o.p1Queue = {}
    o.p2Queue = {}
    o.drawBuildArea = newDrawBuildArea:new()
    return BuildArea:init(o)
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

function BuildArea:show()
    if self.buildType == "P1" then
        self.drawBuildArea:EmptySlots(self.availableSlots)
        self.drawBuildArea:Icons(self.p1Queue, self.images)

    elseif self.buildType == "P2" then
        self.drawBuildArea:EmptySlots(self.availableSlots)
        self.drawBuildArea:Icons(self.p2Queue, self.images)
    elseif self.buildType == "loop" then
        self.drawBuildArea:EmptySlots(self.availableSlots)
        self.drawBuildArea:Icons(self.loopQueue, self.images)
    end
    self.drawBuildArea:HeadLine(self.images, self.buildType)
end

-------------------------------------
-- Sets the buildType which keeps track of which build area is to be drawn
-- loop, P1 or P2,
-- @author Mikael Ögren
-------------------------------------
function BuildArea:setBuildType(buildType)
    self.buildType = buildType
end

-------------------------------------
-- Sets the different queues.
-- @param queue. An array of commands that are to be set as queue.
-- @param queueType. Which queue is to be set, loop, P1 or P2.
-- @author Mikael Ögren
-------------------------------------
function BuildArea:setQueue(queue, queueType)
    if queueType == "loop" then
        self.loopQueue = queue
    elseif queueType == "P1" then
        self.p1Queue = queue
    elseif queueType == "P2" then
        self.p2Queue = queue
    end
end


return BuildArea