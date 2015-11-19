-----------------------------------------------------------
-- This class keeps track of the images and position of the
-- commands in the bottom menu based on how they're
-- organized in the queue.
--
-- @Author:Created by Mikael Ögren, Nov 04, 2015
-- @Author:Updated by Tobias Lundell, Nov 12, 2015
-- @Author:Updated by Chuck Chu, Nov 12, 2015 fit to new structure
-- @Author:Updated by Mikael Ögren, Nov 16, 2015 Moved draw functions to DrawBottomMenu
-- @Author:Updated by Chuck Chu, Nov 16,2015 for removing GameInputHandler
-----------------------------------------------------------

local Object = require("toolkit.Object")
local Controllable = require("toolkit.Controllable")
local EventHandler = require('toolkit.EventHandler')
local Event = require('toolkit.Event')
local Commands = require('games.Progg.Commands')
local buildArea = require('games.Progg.BuildArea')
local Character = require('games.Progg.Character')
local Queue = require('games.Progg.Queue')

local Position = require('games.Progg.Position')

local BottomMenu = extends(Controllable)
local newDrawBottomMenu = require("games.Progg.DrawBottomMenu")

--Constructor method
function BottomMenu:new(maxCommands,gameContext)
    local o = BottomMenu:super()
    o.selectingLoopCounter = false;
    o.inputArea = "queue"
    o.prevInputArea = "queue"
    o.maxCommands = maxCommands
    o.position = 1
    o.prevPosition = nil
    context = gameContext
    o.buildArea = buildArea:new(maxCommands, o.position)
    o.drawBottomMenu = newDrawBottomMenu:new(maxCommands)
    o.character = Character:new(Position:new(1,5))
    o.queue = Queue:new(o, o.buildArea)
    return BottomMenu:init(o)
end

--------------------------------------------
-- Loads the bottom menu with the two input areas
-- @author Mikael Ögren; Tobias Lundell
--------------------------------------------
function BottomMenu:load()
    self.drawBottomMenu:background(self.inputArea)
    self.drawBottomMenu:emptySlots(self.inputArea)
    self.drawBottomMenu:headline("Main")
    self.buildArea:load(self.inputArea)
end

--------------------------------------------
-- Updates the input areas in the bottom menu. Used on update.
-- @ author Mikael Ögren; Tobias Lundell
--------------------------------------------
function BottomMenu:show()
    if (self.prevInputArea ~= self.inputArea) then
        self:updateInputArea()
        self.prevInputArea = self.inputArea
    end
    if (self.inputArea ~= "queue") then
        self.buildArea:show(self.queue)
    else
        self.drawBottomMenu:icons(self.queue.actions)
        self.drawBottomMenu:highlightIcon(self.position, self.prevPosition, self.queue.actions)
    end
end

--------------------------------------------
-- Changes color of the background and icons in the input areas when changing active.
-- @author Tobias Lundell
--------------------------------------------
function BottomMenu:updateInputArea()
    self:load()
    self.drawBottomMenu:allIcons(self.queue.actions)
end

-------------------------------------
-- Set the queue for this class.
-- @param queue. The queue that this class should use.
-- @author Mikael Ögren
-------------------------------------
function BottomMenu:setQueue(queue)
    self.queue = queue
end

-------------------------------------
-- Execute the queue with commands.
-- @author Mikal Ögren
-------------------------------------
function BottomMenu:executeQueue()
    self.character:startExecution(self.queue)

end


--Subscribing the eventHandler to all events.
bottomMenuEventHandler = EventHandler:new()
bottomMenuEventHandler.events = {[Event.KEY_ONE] = 1,[Event.KEY_TWO] = 1,[Event.KEY_THREE]=1,[Event.KEY_FOUR]=1,[Event.KEY_FIVE]=1,[Event.KEY_SIX]=1,[Event.KEY_SEVEN]=1,[Event.KEY_EIGHT]=1,[Event.KEY_NINE]=1
    ,[Event.KEY_ZERO]=1,[Event.KEY_UP]=1,[Event.KEY_DOWN]=1 ,[Event.KEY_LEFT]=1,[Event.KEY_RIGHT]=1, [Event.KEY_OK]=1 }

--Update function on every key input
function bottomMenuEventHandler:update(object,eventListener,event)

    if(event.state==Event.KEY_STATE_DOWN) then
        --Switch for all the input handling to implement
        if event.key == Event.KEY_ONE then
            if(object.inputArea =="loop" and object.selectingLoopCounter==true ) then
                object.queue.loopCounter = 1
                object.selectingLoopCounter=false
            else
                object.queue:push(Commands.MOVE, object.inputArea)
            end

        elseif event.key == Event.KEY_TWO then
            if(object.inputArea =="loop" and object.selectingLoopCounter==true ) then
                object.queue.loopCounter = 2
                object.selectingLoopCounter=false
            else
                object.queue:push(Commands.TURN_LEFT, object.inputArea)
            end

        elseif event.key == Event.KEY_THREE then
            if(object.inputArea =="loop" and object.selectingLoopCounter==true ) then
                object.queue.loopCounter = 3
                object.selectingLoopCounter=false
            else
                object.queue:push(Commands.TURN_RIGHT, object.inputArea)
            end

        elseif event.key == Event.KEY_FOUR then
            if(object.inputArea =="loop" and object.selectingLoopCounter==true ) then
                object.queue.loopCounter = 4
                object.selectingLoopCounter=false
            else
                --queue:push(Commands.TURN_RIGHT, inputArea)
            end

        elseif event.key == Event.KEY_FIVE then
            if(object.inputArea =="loop" and object.selectingLoopCounter==true ) then
                object.queue.loopCounter = 5
                object.selectingLoopCounter=false
            else
                --queue:push(Commands.TURN_RIGHT, inputArea)
            end

        elseif event.key == Event.KEY_SIX then

            if(object.inputArea =="loop" and object.selectingLoopCounter==true ) then
                object.queue.loopCounter = 6
                object.selectingLoopCounter=false
            else
                object.buildArea:setBuildType("loop")
                object.queue:push(Commands.LOOP, object.inputArea)
                object.inputArea = "loop"
                object.selectingLoopCounter=true

                object.prevPosition = object.position
                object.position = 17
                object.buildArea:setPosition(object.position)
                object.drawBottomMenu:clearPos(object.prevPosition, object.queue.actions)
                object.buildArea.drawBuildArea:clearPos(object.buildArea.prevPosition, object.buildArea.loopQueue)
            end


        elseif event.key == Event.KEY_SEVEN then
            if(object.inputArea =="loop" and object.selectingLoopCounter==true ) then
                object.queue.loopCounter = 7
                object.selectingLoopCounter=false
            else
                object.buildArea:setBuildType("P1")
                object.queue:push(Commands.P1, object.inputArea)
                object.inputArea = "P1"

                object.prevPosition = object.position
                object.position = 17
                object.buildArea:setPosition(object.position)
                object.drawBottomMenu:clearPos(object.prevPosition, object.queue.actions)
                object.buildArea.drawBuildArea:clearPos(object.buildArea.prevPosition, object.buildArea.p1Queue)
            end

        elseif event.key == Event.KEY_EIGHT then
            if(object.inputArea =="loop" and object.selectingLoopCounter==true ) then
                object.queue.loopCounter = 8
                object.selectingLoopCounter=false
            else
                object.buildArea:setBuildType("P2")
                object.queue:push(Commands.P2, inputArea)
                object.inputArea = "P2"

                object.prevPosition = object.position
                object.position = 17
                object.buildArea:setPosition(object.position)
                object.drawBottomMenu:clearPos(object.prevPosition, object.queue.actions)
                object.buildArea.drawBuildArea:clearPos(object.buildArea.prevPosition, object.buildArea.p2Queue)
            end
        elseif event.key == Event.KEY_NINE then
            if(inputArea =="loop" and object.selectingLoopCounter==true ) then
                object.queue.loopCounter = 9
                object.selectingLoopCounter=false
            else
                context.platformEventListener:removeChainListener()
                context:createNewMenu()
                context.game = nil
            end

        elseif event.key == Event.KEY_UP then
            if  object:isUpperRow(object.position) == false then
                object:setPosition(-8)
            end
        elseif event.key == Event.KEY_DOWN then
            if  object:isUpperRow(object.position) == true then
                object:setPosition(8)
            end
        elseif event.key == Event.KEY_LEFT then
            if object.position == 17 or object.position == 25 then
            elseif object.position > 1 then
                object:setPosition(-1)
            end
        elseif event.key == Event.KEY_RIGHT then
            if object.position == 8 or object.position == 16 then
            elseif object.position < 32 then
                object:setPosition(1)
            end
        elseif event.key == Event.KEY_ZERO then
            if object.inputArea == "queue"  then
                object:executeQueue()
            else
                object.prevPosition = object.position
                object.position = 1
                object.buildArea:setPosition(object.position)
                object.drawBottomMenu:clearPos(object.prevPosition, object.queue.actions)
                object.buildArea.drawBuildArea:clearPos(object.buildArea.prevPosition, object:getQueue(object.inputArea))
                object.inputArea = "queue"
            end
        elseif event.key == Event.KEY_OK then
            local queuePos = object.position
            if queuePos > 16 then
                queuePos = queuePos - 16 -- Must be done if clicking a command in buildArea to get correct position in queue
            end

            if object:getQueue(object.inputArea)[queuePos] == "P1" or object:getQueue(object.inputArea)[queuePos] == "loop" or object:getQueue(object.inputArea)[queuePos] == "P2" then -- Makes sure you've clicked on a procedure or loop
                object:enterMethod(queuePos)
            elseif object:getQueue(object.inputArea)[queuePos] ~= nil then
                object:deleteAction(object.position, object.inputArea)
            end

            object:updateInputArea()
        end
    end
end

--------------------------------------
-- Sets the position in the build area
-- @ param change:Integer. The change in position.
-- @author Mikael Ögren
-------------------------------------
function BottomMenu:setPosition(change)
    self.prevPosition = self.position
    self.position = self.position + change
    self.buildArea:setPosition(self.position)
end

function BottomMenu:enterMethod(queuePos)
    self.buildArea:setBuildType(self:getQueue(self.inputArea)[queuePos]) --object:getQueue(object.inputArea)[queuePos] is the command you clicked on
    self.inputArea = self:getQueue(self.inputArea)[queuePos]
    self.prevPosition = self.position
    self.position = 17
    self.buildArea:setPosition(self.position)
    self.drawBottomMenu:clearPos(self.prevPosition, self.queue.actions)
    self.buildArea.drawBuildArea:clearPos(self.buildArea.prevPosition, self:getQueue(self.inputArea))
end
--------------------------------------
-- Check if the current position is in the upper row.
-- @ param change:Integer. The change in position.
-- @author Mikael Ögren
-------------------------------------
function BottomMenu:isUpperRow(pos)
    if (pos > 8 and pos <= 16) or (24 < pos and pos <= 32) then
        return false
    else
        return true
    end
end

-----------------------------------
-- Deletes the action that is currently selected.
-- @param position:Integer. Integer representing the current position of marker in the bottom menu.
-- @param inputArea:String. The current inputArea.
--@author Mikael Ögren
-----------------------------------
function BottomMenu:deleteAction(position, inputArea)
    local queuePos = position
    if queuePos > 16 then
        queuePos = queuePos - 16 -- Must be done if clicking a command in buildArea to get correct position in queue
    end

    if self:getQueue(inputArea)[queuePos] ~= nil then
        for i=queuePos, (#self:getQueue(inputArea)) do
            self:getQueue(inputArea)[i] = self:getQueue(inputArea)[i + 1]
        end
    end
end
-----------------------------------
-- Returns the queue corresponding to the inputArea
-- @param inputArea:String. String containing the active input area.
--@author Mikael Ögren
-----------------------------------
function BottomMenu:getQueue(inputArea)
    if inputArea == "queue" then
        return self.queue.actions
    elseif inputArea == "loop" then
        return self.queue.loopActions
    elseif inputArea == "P1" then
        return self.queue.p1Actions
    elseif inputArea == "P2" then
        return self.queue.p2Actions
    end
end

BottomMenu.eventHandler = bottomMenuEventHandler

return BottomMenu
