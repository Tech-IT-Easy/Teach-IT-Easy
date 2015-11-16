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
    o.inputArea = "queue"
    return BuildArea:init(o)
end

function BuildArea:load()
end

-------------------------------------
-- Sets the active input area
-- @param inputArea. The active input area.
-- @author Tobias Lundell
-------------------------------------
function BuildArea:setInputArea(inputArea)
    self.inputArea = inputArea
end

function BuildArea:show()

    self.drawBuildArea:EmptySlots(self.availableSlots, self.inputArea)

    if self.buildType == "P1" then
        --self.drawBuildArea:EmptySlots(self.availableSlots)
        self.drawBuildArea:Icons(self.p1Queue, self.images)
    elseif self.buildType == "P2" then
       -- self.drawBuildArea:EmptySlots(self.availableSlots)
        self.drawBuildArea:Icons(self.p2Queue, self.images)
    elseif self.buildType == "loop" then
       -- self.drawBuildArea:EmptySlots(self.availableSlots)
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