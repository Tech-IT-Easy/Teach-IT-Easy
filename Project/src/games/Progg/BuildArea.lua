-----------------------------------------------------------
--This class draws the build area and handles the building
--of procedures and loops
--
-- @Author:Created by Mikael Ögren, Nov 11,2015
-- @Author:Updated by Tobias Lundell, Nov 16, 2015
-----------------------------------------------------------

local Object = require("toolkit.Object")
local BuildArea = extends(Object)
local newDrawBuildArea = require("games.Progg.DrawBuildArea")

function BuildArea:new(maxCommands, pos)
    local o = BuildArea:super()
    o.availableSlots = maxCommands
    o.position = pos
    o.prevPosition = nil
    o.loopQueue = {}
    o.p1Queue = {}
    o.p2Queue = {}
    o.drawBuildArea = newDrawBuildArea:new(o.availableSlots)
    o.inputArea = nil
    return BuildArea:init(o)
end

function BuildArea:load()
    self.drawBuildArea:emptySlots(self.availableSlots, inputArea)
end


function BuildArea:show(inputArea, queue)


    if self.buildType == "P1" then
        self.drawBuildArea:icons(self.p1Queue)
        self.drawBuildArea:highlightIcon(self.position, self.prevPosition, self.p1Queue)
    elseif self.buildType == "P2" then
        self.drawBuildArea:icons(self.p2Queue)
        self.drawBuildArea:highlightIcon(self.position, self.prevPosition, self.p2Queue)
    elseif self.buildType == "loop" then
        self.drawBuildArea:icons(self.loopQueue)
        self.drawBuildArea:highlightIcon(self.position, self.prevPosition, self.loopQueue)
        self.drawBuildArea:drawLoopCounter(queue.loopCounter)
    end
    self.drawBuildArea:headLine(self.buildType, inputArea)
end

-------------------------------------
-- Sets the buildType which keeps track of which build area is to be drawn
-- loop, P1 or P2,
-- @author Mikael Ögren
-------------------------------------
function BuildArea:setBuildType(buildType)
    self.buildType = buildType
end

function BuildArea:setPosition(pos)
    self.prevPosition = self.position
    self.position = pos
end

--------------------------------------
-- Sets the inputArea variable to the active input area.
-- queue, P1, P2 or loop
-- @param inputArea. A string with the active input area name.
-- @author Tobias Lundell, Nov 13, 2015
--------------------------------------
function BuildArea:setInputArea(inputArea)
    self.inputArea = inputArea
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