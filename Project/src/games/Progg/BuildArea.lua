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

    self.drawBuildArea:emptySlots(self.availableSlots, self.inputArea)

    if self.buildType == "P1" then
        self.drawBuildArea:icons(self.p1Queue)
    elseif self.buildType == "P2" then
        self.drawBuildArea:icons(self.p2Queue)
    elseif self.buildType == "loop" then
        self.drawBuildArea:icons(self.loopQueue)
    end
    self.drawBuildArea:headLine(self.buildType)
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