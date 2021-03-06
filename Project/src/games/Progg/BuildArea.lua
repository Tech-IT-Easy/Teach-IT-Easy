--[[TEACH IT EASY, an educational games platform
    Copyright (C) 2015  Linköping University

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.


    MIT LICENSE:
    Copyright (c) 2015 Zenterio AB

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:



    The above copyright notice and this permission notice shall be included in
    all copies or substantial portions of the Software.


    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
    THE SOFTWARE.


    ]]
-----------------------------------------------------------
--This class draws the build area and handles the building
--of procedures and loops
--
-- @Author:Created by Mikael Ögren, Nov 11,2015
-- @Author:Updated by Tobias Lundell, Nov 16, 2015
-- @Author:Updaten by Tobias Lundell, Nov 26, 2015 for functionality for adding if-statements to the build area.
-----------------------------------------------------------

local Object = require("toolkit.Object")
local BuildArea = extends(Object)
local newDrawBuildArea = require("games.Progg.DrawBuildArea")

function BuildArea:new(maxCommands, pos)
    local o = BuildArea:super()
    o.maxCommands = maxCommands
    o.position = pos
    o.prevPosition = nil
    o.loopQueue = {}
    o.p1Queue = {}
    o.p2Queue = {}
    o.ifTrueQueue = {}
    o.ifFalseQueue = {}
    o.drawBuildArea = newDrawBuildArea:new(o.maxCommands)
    --   o.inputArea = nil
    return BuildArea:init(o)
end

-------------------------------------------------------------
-- Load the the build area
-- @param inputArea:String. The active input area.
-- @author Tobias Lundell
-------------------------------------------------------------
function BuildArea:load(inputArea, active)
    self.drawBuildArea:emptySlots(inputArea, active)
    self.drawBuildArea:headLine(self.buildType, inputArea)
    if self.buildType == "P1" then
        self.drawBuildArea:allIcons(self.p1Queue, inputArea)
    elseif self.buildType == "P2" then
        self.drawBuildArea:allIcons(self.p2Queue, inputArea)
    elseif self.buildType == "loop" then
        self.drawBuildArea:allIcons(self.loopQueue, inputArea)
    elseif self.buildType == "if-wall" then
        self.drawBuildArea:allIcons(self.ifTrueQueue, inputArea)
    elseif self.buildType == "if-not-wall" then
        self.drawBuildArea:allIcons(self.ifFalseQueue, inputArea)
    end
end

-----------------------------------------------------
-- Updates the build area. Called when changed.
-- @param queue:Queue. The queue containing the actions to be drawn.
-- @author Tobias Lundell
-----------------------------------------------------
function BuildArea:show(queue, inputArea, posToBeMoved)
    if self.buildType == "P1" then
        self.drawBuildArea:icons(self.p1Queue, inputArea)
        self.drawBuildArea:highlightIcon(self.position, self.prevPosition, self.p1Queue, posToBeMoved)
    elseif self.buildType == "P2" then
        self.drawBuildArea:icons(self.p2Queue, inputArea)
        self.drawBuildArea:highlightIcon(self.position, self.prevPosition, self.p2Queue, posToBeMoved)
    elseif self.buildType == "loop" then
        self.drawBuildArea:icons(self.loopQueue, inputArea)
        self.drawBuildArea:highlightIcon(self.position, self.prevPosition, self.loopQueue, posToBeMoved)
        self.drawBuildArea:drawLoopCounter(queue.loopCounter[queue.loopPointer])
    elseif self.buildType == "if-wall" then
        self.drawBuildArea:icons(self.ifTrueQueue, inputArea)
        self.drawBuildArea:highlightIcon(self.position, self.prevPosition, self.ifTrueQueue, posToBeMoved)
    elseif self.buildType == "if-not-wall" then
        self.drawBuildArea:icons(self.ifFalseQueue, inputArea)
        self.drawBuildArea:highlightIcon(self.position, self.prevPosition, self.ifFalseQueue, posToBeMoved)
    end
end

-------------------------------------
-- Sets the buildType which keeps track of which build area is to be drawn
-- loop, P1, P2, if-wall or if-not-wall
-- @author Mikael Ögren
-------------------------------------
function BuildArea:setBuildType(buildType)
    self.buildType = buildType
end

-------------------------------------
-- Sets the active position in the build area
-- @param pos:Integer. The new position.
-- @author Mikael Ögren
-------------------------------------
function BuildArea:setPosition(pos)
    self.prevPosition = self.position
    self.position = pos
end

--------------------------------------
-- Sets the inputArea variable to the active input area.
-- queue, P1, P2, loop, if-wall or if-not-wall
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
-- @author Mikael Ögren; Tobias Lundell
-------------------------------------
function BuildArea:setQueue(queue, queueType)
    if queueType == "loop" then
        self.loopQueue = queue
    elseif queueType == "P1" then
        self.p1Queue = queue
    elseif queueType == "P2" then
        self.p2Queue = queue
    elseif queueType == "if-wall" then
        self.ifTrueQueue = queue
    elseif queueType == "if-not-wall" then
        self.ifFalseQueue = queue
    elseif queueType == "all" then --specifically used by Queue when clearing all actions, it sends empty table
        self.loopQueue = queue
        self.p1Queue = queue
        self.p2Queue = queue
        self.ifTrueQueue = queue
        self.ifFalseQueue = queue
    end
end


return BuildArea