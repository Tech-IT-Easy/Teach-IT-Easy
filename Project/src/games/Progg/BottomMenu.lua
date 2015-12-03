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
-- @Author:Updated by Tobias Lundell, Nov 26, 2015 for adding functionality for if-statements
-----------------------------------------------------------

local Object = require("toolkit.Object")
local Controllable = require("toolkit.Controllable")
local EventHandler = require('toolkit.EventHandler')
local Event = require('toolkit.Event')
local Commands = require('games.Progg.Commands')
local buildArea = require('games.Progg.BuildArea')
local Character = require('games.Progg.Character')
local Queue = require('games.Progg.Queue')
local BottomMenu = extends(Controllable)
local newDrawBottomMenu = require("games.Progg.DrawBottomMenu")
local rightMenu = require("games.Progg.RightMenu")

-------------------------------------------------
-- Constructor method for the BottomMenu.
-- @param maxCommands:integer determines how many
--         commands can be drawn at once
-- @param gameContext:PlatformContext as a pointer to the context
--          in which the game exists
-- @return bottomMenu:BottomMenu a new instance of BottomMenu
-- @author Mikael Ögren; Tobias Lundell;
-------------------------------------------------
function BottomMenu:new(levelData,context)
    local o = BottomMenu:super()
    o.clearAllCheck = false
    o.selectingEditAction = nil
    o.isMovingAction = false
    o.posActionToMove = nil
    o.selectingLoopCounter = true
    o.inputArea = "queue"
    o.prevInputArea = "queue"
    o.maxCommands = levelData.maxCommands
    o.position = 1     --Starting position for highlight
    o.rowLength = 8
    o.prevPosition = nil
    -- @member context:PlatformContext
    o.context = context
    -- @member buildArea:BuildArea
    o.buildArea = buildArea:new(o.maxCommands, o.position)
    -- @member drawBottomMenu:DrawBottomMenu
    o.drawBottomMenu = newDrawBottomMenu:new(o.maxCommands)
    -- @member character:Character
    o.queue = Queue:new(o, o.buildArea, o.maxCommands)
    o.rightMenu = rightMenu:new(o.maxCommands)
    o.character = Character:new(1,5,o.rightMenu, levelData, context)
    return BottomMenu:init(o)
end

--------------------------------------------
-- Loads the bottom menu with the two input areas
-- @author Mikael Ögren; Tobias Lundell
--------------------------------------------
function BottomMenu:load(inArea,active)
    self.drawBottomMenu:background(self.inputArea)
    self.drawBottomMenu:emptySlots(self.inputArea)
    self.drawBottomMenu:headline("Main")
    if (inArea ~= nil and inArea ~= "queue") then
        self.buildArea:load(inArea, active)
    end
    self.rightMenu:load()
end

--------------------------------------------
-- Updates the input areas in the bottom menu. Used on update.
-- @ author Mikael Ögren; Tobias Lundell
--------------------------------------------
function BottomMenu:show()
    if (self.prevInputArea ~= self.inputArea) then
        if (self.inputArea == "queue") then
            self:updateInputArea(self.prevInputArea, false)
        else
            self:updateInputArea(self.inputArea, true)
        end
        self.prevInputArea = self.inputArea
    end
    if (self.inputArea ~= "queue") then
        self.buildArea:show(self.queue, self.inputArea)
    else
        self.drawBottomMenu:icons(self.queue.actions, self.inputArea)
        self.drawBottomMenu:highlightIcon(self.position, self.prevPosition, self.queue.actions)
    end
    self.rightMenu:show(self.inputArea)
end

--------------------------------------------
-- Changes color of the background and icons in the input areas when changing active.
-- @param inArea:String. The input area to change color of.
-- @param active:Boolean. True if the input area is active, false if inactive.
-- @author Tobias Lundell
--------------------------------------------
function BottomMenu:updateInputArea(inArea, active)
    self:load(inArea, active)
    self.drawBottomMenu:allIcons(self.queue.actions, self.inputArea)
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

--------------------------------------
-- Quit the game and return to the menu. Right now
-- it goes all the way back to profile selection.
-- It should just go back to the games-menu.
-- @author Ludwig Wikblad
---------------------------------------
function BottomMenu:returnToMenus()
    if self.character.executionTimer ~= nil then
        self.character.executionTimer:stop()
        self.character.executionTimer = nil
    end
    self.context.platformEventListener:removeChainListener()
    self.context:createNewMenu()
    self.context.game = nil
end



--Subscribing the eventHandler to all events.
bottomMenuEventHandler = EventHandler:new()
bottomMenuEventHandler.events = {[Event.KEY_ONE] = 1,[Event.KEY_TWO] = 1,[Event.KEY_THREE]=1,[Event.KEY_FOUR]=1,[Event.KEY_FIVE]=1,[Event.KEY_SIX]=1,[Event.KEY_SEVEN]=1,[Event.KEY_EIGHT]=1,[Event.KEY_NINE]=1
    ,[Event.KEY_ZERO]=1,[Event.KEY_UP]=1,[Event.KEY_DOWN]=1 ,[Event.KEY_LEFT]=1,[Event.KEY_RIGHT]=1, [Event.KEY_OK]=1,[Event.KEY_BACK]=1 }

----------------------------------------
-- Update function on every key input
-- @param object:BottomMenu a pointer to the BottomMenu that "owns" this handler.
-- @param eventListener:EventListener a pointer to the listener that called this function.
-- @param event:Event the event that caused the function to be called
-----------------------------------------
function bottomMenuEventHandler:update(object,eventListener,event)

    if(event.state==Event.KEY_STATE_DOWN) then
        --Switch for all the input handling to implement
        if event.key == Event.KEY_ONE then
            if(object.inputArea =="loop" and object.selectingLoopCounter==true ) then --Handles input when selecting how many times a loop should repeat
                object.queue.loopCounter[object.queue.loopPointer] = 1
                object.selectingLoopCounter=false
                object.rightMenu.inputAreaChanged = true
                object.rightMenu.inputArea = "build"
            elseif object.clearAllCheck == true then  --Handles input when confirming if user wants to clear a queue
                object.queue:clearAll(object.inputArea)
                object.clearAllCheck = false
                object.rightMenu.inputAreaChanged = true
                if object.inputArea == "loop" or object.inputArea == "P1" or object.inputArea == "P2" or object.inputArea == "if-not-wall"  then
                    object.rightMenu.inputArea = "build"
                elseif object.inputArea == "if-wall"  then
                    object.rightMenu.inputArea = "if-wall"
                else
                    object.rightMenu.inputArea = "queue"
                end
            elseif object.selectingActionEdit ~= nil then   --Handles input when a command is selected
                object.isMovingAction = true
                object.posActionToMove = object.position
                object.selectingActionEdit = nil
            elseif object.isMovingAction == true then  -- Handles input while user is moving an action
                print("Not allowed while moving an action")
            else -- Handles input during normal state. Lets user add "move forward" to current queue.
                object.queue:push(Commands.MOVE, object.inputArea)
                object.rightMenu.toHighlight = (Commands.MOVE)
            end

        elseif event.key == Event.KEY_TWO then
            if(object.inputArea =="loop" and object.selectingLoopCounter==true ) then--Handles input when selecting how many times a loop should repeat
                object.queue.loopCounter[object.queue.loopPointer]  = 2
                object.selectingLoopCounter=false
                object.rightMenu.inputAreaChanged = true
                object.rightMenu.inputArea = "build"
            elseif object.clearAllCheck == true then --Handles input when confirming if user wants to clear a queue
                object.clearAllCheck = false
                object.rightMenu.inputAreaChanged = true
                if object.inputArea == "loop" or object.inputArea == "P1" or object.inputArea == "P2" or object.inputArea == "if-not-wall"  then
                    object.rightMenu.inputArea = "build"
                elseif object.inputArea == "if-wall"  then
                    object.rightMenu.inputArea = "if-wall"
                else
                    object.rightMenu.inputArea = "queue"
                end
            elseif object.selectingActionEdit ~= nil then --Handles input when a command is selected
                object:deleteAction(object.position, object.inputArea)
                object:updateInputArea(object.inputArea, true)
                object.selectingActionEdit = nil
                if object.inputArea == "queue" then
                    object.rightMenu.inputAreaChanged = true
                    object.rightMenu.inputArea = object.inputArea
                else
                    object.rightMenu.inputAreaChanged = true
                    object.rightMenu.inputArea = "build"
                end
            elseif object.isMovingAction == true then -- Handles input while user is moving an action
                print("Not allowed while moving an action")
            else -- Handles input during normal state. Lets user add "turn left" to current queue.
                object.queue:push(Commands.TURN_LEFT, object.inputArea)
                object.rightMenu.toHighlight = (Commands.TURN_LEFT)
            end

        elseif event.key == Event.KEY_THREE then
            if(object.inputArea =="loop" and object.selectingLoopCounter==true ) then--Handles input when selecting how many times a loop should repeat
                object.queue.loopCounter[object.queue.loopPointer]  = 3
                object.selectingLoopCounter=false
                object.rightMenu.inputAreaChanged = true
                object.rightMenu.inputArea = "build"
            elseif object.selectingActionEdit == "loop" or object.selectingActionEdit == "P1" or object.selectingActionEdit == "P2" or object.selectingActionEdit == "if"  then -- Handles input while a method is selected. Lets user enter the selected method.
                if(object.selectingActionEdit == "loop")then
                    object.buildArea:setQueue(object.queue.loopActions[object.queue.loopPointer],"loop")
                end
                object:enterMethod()
                object.selectingActionEdit = nil
                object.rightMenu.inputAreaChanged = true
                object.rightMenu.inputArea = "build"
            elseif object.selectingActionEdit == "if-wall"  then -- Handles input while a method is selected. Lets user enter the selected method.
                object:enterMethod()
                object.selectingActionEdit = nil
                object.rightMenu.inputAreaChanged = true
                object.rightMenu.inputArea = "if-wall"
            elseif object.selectingActionEdit ~= nil or object.isMovingAction == true then  --Handles input when a command is selected and it's not a method or input when moving a command
                print("Not allowed while moving an action")
                print("Cannot enter command that is not a loop or procedure")
                --object.selectingActionEdit = nil
            else -- Handles input during normal state. Lets user add "turn right" to current queue.
                object.queue:push(Commands.TURN_RIGHT, object.inputArea)
                object.rightMenu.toHighlight = (Commands.TURN_RIGHT)
            end

        elseif event.key == Event.KEY_FOUR then
            if(object.inputArea =="loop" and object.selectingLoopCounter==true ) then --Handles input when selecting how many times a loop should repeat
                object.queue.loopCounter[object.queue.loopPointer]  = 4
                object.selectingLoopCounter=false
                object.rightMenu.inputAreaChanged = true
                object.rightMenu.inputArea = "build"
            elseif object.selectingActionEdit == "loop" or object.selectingActionEdit == "P1" or object.selectingActionEdit == "P2" or object.selectingActionEdit == "if"  then
                --object:enterMethod()
                object.selectingActionEdit = nil
                object.rightMenu.inputAreaChanged = true
                if object.inputArea == "loop" or object.inputArea == "P1" or object.inputArea == "P2" or object.inputArea == "if"  then
                    object.rightMenu.inputArea = "build"
                else
                    object.rightMenu.inputArea = "queue"
                end
            elseif object.selectingActionEdit ~= nil or object.isMovingAction == true then --Handles input when a command is selected and it's not a method or input when moving a command
                print("Not allowed while moving an action")
                print("Cannot enter command that is not a loop or procedure")
                object.selectingActionEdit = nil
                object.rightMenu.inputAreaChanged = true
                if object.inputArea == "loop" or object.inputArea == "P1" or object.inputArea == "P2" or object.inputArea == "if-wall"  then
                    object.rightMenu.inputArea = "build"
                else
                    object.rightMenu.inputArea = "queue"
                end
            else
                object.queue:push(Commands.FIX, object.inputArea)
                --object.rightMenu.toHighlight = (Commands.FIX)
            end

        elseif event.key == Event.KEY_FIVE then
            if(object.inputArea =="loop" and object.selectingLoopCounter==true ) then --Handles input when selecting how many times a loop should repeat
                object.queue.loopCounter[object.queue.loopPointer]  = 5
                object.selectingLoopCounter=false
                object.rightMenu.inputAreaChanged = true
                object.rightMenu.inputArea = "build"
            elseif object.selectingActionEdit ~= nil or object.isMovingAction == true or object.maxCommands["if-wall"] == 0 then --Handles input when a command is selected, when moving a command or when loop has no available slots
                print("Not allowed")
            else
                if #object.queue.actions<object.maxCommands[object.inputArea] == false then
                    print("Action not allowed")
                    return;
                end
                if object.inputArea == "if-wall" or object.inputArea == "if-not-wall" then
                    print("Action not allowed")
                    return;
                end
                object.rightMenu.inputAreaChanged = true
                object.rightMenu.inputArea = "if-wall"
                object.buildArea:setBuildType("if-wall")
                object.queue:push(Commands.IF, object.inputArea)
                object.inputArea = "if-wall"
                object.prevPosition = object.position
                object.position = 2*object.rowLength + 1
                object.buildArea:setPosition(object.position)
                object.drawBottomMenu:clearPos(object.prevPosition, object.queue.actions)
                object.buildArea.drawBuildArea:clearPos(object.buildArea.prevPosition, object.buildArea.ifTrueQueue)
            end

        elseif event.key == Event.KEY_SIX then
            if(object.inputArea =="loop" and object.selectingLoopCounter==true ) then --Handles input when selecting how many times a loop should repeat
                object.queue.loopCounter[object.queue.loopPointer]  = 6
                object.selectingLoopCounter=false
                object.rightMenu.inputAreaChanged = true
                object.rightMenu.inputArea = "build"

            elseif object:isBuildArea() == true or object.selectingActionEdit ~= nil or object.isMovingAction == true or #object.queue.actions<object.maxCommands[object.inputArea] == false then -- Handles input when an action is selected, user is moving an action, loop has no available slots or (the main queue is full?)
                print("Not allowed while selecting edit or moving action")
            else -- Handles input during normal state. Lets user add loop to main queue.
                if object.maxCommands["loop"] == 0 then
                    print("Action not allowed")
                    return;
                end
                object.rightMenu.inputAreaChanged = true
                object.rightMenu.inputArea = "loop"
                object.buildArea:setBuildType("loop")
                object.queue:push(Commands.LOOP, object.inputArea)
                object.inputArea = "loop"
                object.selectingLoopCounter=true
                object.prevPosition = object.position
                object.position = 2*object.rowLength + 1
                object.buildArea:setPosition(object.position)
                object.drawBottomMenu:clearPos(object.prevPosition, object.queue.actions)
                object.buildArea.drawBuildArea:clearPos(object.buildArea.prevPosition, object.buildArea.loopQueue)
                object.queue.loopPointer = #object.queue.loopActions
                object.buildArea:setQueue(object.queue.loopActions[object.queue.loopPointer],"loop")
            end

        elseif event.key == Event.KEY_SEVEN then
            if(object.inputArea =="loop" and object.selectingLoopCounter==true ) then --Handles input when selecting how many times a loop should repeat
                object.queue.loopCounter[object.queue.loopPointer]  = 7
                object.selectingLoopCounter=false
                object.rightMenu.inputAreaChanged = true
                object.rightMenu.inputArea = "build"
            elseif object.selectingActionEdit ~= nil or object.isMovingAction == true then --Handles input when a command is selected or input when moving a command
                print("Not allowed while selecting edit or moving action")
            else -- Handles input during normal state. Lets user add P1 to main queue.
                if  object.maxCommands["P1"] == 0 or #object.queue.actions<object.maxCommands[object.inputArea] == false then
                    print("Action not allowed")
                    return;
                end
                --object:isBuildArea() == true or
                object.rightMenu.inputAreaChanged = true
                object.rightMenu.inputArea = "build"
                object.buildArea:setBuildType("P1")
                object.queue:push(Commands.P1, object.inputArea)
                object.inputArea = "P1"

                object.prevPosition = object.position
                object.position = 2*object.rowLength + 1
                object.buildArea:setPosition(object.position)
                object.drawBottomMenu:clearPos(object.prevPosition, object.queue.actions)
                object.buildArea.drawBuildArea:clearPos(object.buildArea.prevPosition, object.buildArea.p1Queue)
            end

        elseif event.key == Event.KEY_EIGHT then
            if(object.inputArea =="loop" and object.selectingLoopCounter==true ) then --Handles input when selecting how many times a loop should repeat
                object.queue.loopCounter[object.queue.loopPointer]  = 8
                object.selectingLoopCounter=false
                object.rightMenu.inputAreaChanged = true
                object.rightMenu.inputArea = "build"
            elseif object.selectingActionEdit ~= nil or object.isMovingAction == true then --Handles input when a command is selected or input when moving a command
                print("Not allowed while selecting edit or moving action")
            else -- Handles input during normal state. Lets user add P2 to main queue.
                if object.maxCommands["P2"] == 0 or #object.queue.actions<object.maxCommands[object.inputArea] == false then
                    print("Action not allowed")
                    return;
                end
                --object:isBuildArea() == true or
                object.rightMenu.inputAreaChanged = true
                object.rightMenu.inputArea = "build"
                object.buildArea:setBuildType("P2")
                object.queue:push(Commands.P2, object.inputArea)
                object.inputArea = "P2"

                object.prevPosition = object.position
                object.position = 2*object.rowLength + 1
                object.buildArea:setPosition(object.position)
                object.drawBottomMenu:clearPos(object.prevPosition, object.queue.actions)
                object.buildArea.drawBuildArea:clearPos(object.buildArea.prevPosition, object.buildArea.p2Queue)
            end
        elseif event.key == Event.KEY_NINE then
            if(object.inputArea =="loop" and object.selectingLoopCounter==true ) then --Handles input when selecting how many times a loop should repeat
                object.queue.loopCounter[object.queue.loopPointer]  = 9
                object.selectingLoopCounter=false
                object.rightMenu.inputAreaChanged = true
                object.rightMenu.inputArea = "build"
            elseif object.selectingActionEdit ~= nil or object.isMovingAction == true then --Handles input when a command is selected or input when moving a command
                print("Not allowed while selecting edit or moving action")
            else  -- Handles input during normal state. Sends user to the clearAll confirmation.
                object.clearAllCheck = true
                object.rightMenu.inputAreaChanged = true
                object.rightMenu.inputArea = "confirm"
            end

        elseif event.key == Event.KEY_UP then
            if object.selectingActionEdit ~= nil then -- Handles input while a command is selected
                print("Not allowed while selecting edit")
            elseif  object:isUpperRow(object.position) == false then -- Handles input while navigating. Checks to see that the move is ok.
                object:setPosition(-object.rowLength)
            end
        elseif event.key == Event.KEY_DOWN then
            if object.selectingActionEdit ~= nil then -- Handles input while a command is selected
                print("Not allowed while selecting edit")
            elseif  object:isAllowedDown() then -- Handles input while navigating. Checks to see that the move is ok.
                object:setPosition(object.rowLength)
            end
        elseif event.key == Event.KEY_LEFT then
            if object.selectingActionEdit ~= nil then -- Handles input while a command is selected
                print("Not allowed while selecting edit")
            elseif object.position > 1 and object.position ~= 2*object.rowLength + 1 then -- Handles input while navigating. Checks to see that the move is ok.
                object:setPosition(-1)
            end
        elseif event.key == Event.KEY_RIGHT then
            if object.selectingActionEdit ~= nil then -- Handles input while a command is selected
                print("Not allowed while selecting edit")
            elseif object:isAllowedRight() then -- Handles input while navigating. Checks to see that the move is ok.
                object:setPosition(1)
            end
        elseif event.key == Event.KEY_ZERO then
            if(object.inputArea =="loop" and object.selectingLoopCounter==true ) then --Handles input when selecting how many times a loop should repeat
                object.queue.loopCounter[object.queue.loopPointer] = object.queue.INFINITY
                object.selectingLoopCounter=false
                object.rightMenu.inputAreaChanged = true
                object.rightMenu.inputArea = "build"
            elseif object.selectingActionEdit ~= nil then  -- Handles input while an action is selected. Lets user deselect action.
                object.selectingActionEdit = nil
            elseif object.inputArea == "if-wall" then  -- Handles input while user in working in the if-true statement. Lets user switch to the if-not statement-
                object.rightMenu.inputAreaChanged = true
                object.rightMenu.inputArea = "build"
                object.buildArea:setBuildType("if-not-wall")
                object.inputArea = "if-not-wall"
                object.prevPosition = object.position
                object.position = 2*object.rowLength + 1
                object.buildArea:setPosition(object.position)
                object.drawBottomMenu:clearPos(object.prevPosition, object.queue.actions)
                object.buildArea.drawBuildArea:clearPos(object.buildArea.prevPosition, object.buildArea.ifFalseQueue)
                --object:updateInputArea(object.inputArea, true)
            elseif object.inputArea == "queue"  then  -- Handles input while user is working in main queue. Lets user execute the queue.
                object.rightMenu:play()
                object:executeQueue()
            else -- Handles input when user is working in buildArea. Let's user back out to the main queue.
                if object.selectingLoopCounter == true then
                    object.selectingLoopCounter = false
                end
                object.prevPosition = object.position
                object.position = 1
                object.buildArea:setPosition(object.position)
                object.drawBottomMenu:clearPos(object.prevPosition, object.queue.actions)
                object.buildArea.drawBuildArea:clearPos(object.buildArea.prevPosition, object:getQueue(object.inputArea))
                object.rightMenu.inputAreaChanged = true
                object.rightMenu.inputArea = "queue"
                object.inputArea = "queue"
            end

        elseif event.key == Event.KEY_OK then
            local queuePos = object.position
            if queuePos > 2*object.rowLength then
                queuePos = queuePos - 2*object.rowLength -- Must be done if clicking a command in buildArea to get correct position in queue
            end
            if object.isMovingAction == true then   -- Handles input while user is moving an action
                object:moveAction(object.posActionToMove, object.position)
                object.isMovingAction = false
                object:updateInputArea(object.inputArea, true)
                if object.inputArea == "queue" then
                    object.rightMenu.inputAreaChanged = true
                    object.rightMenu.inputArea = object.inputArea
                else
                    object.rightMenu.inputAreaChanged = true
                    object.rightMenu.inputArea = "build"
                end
            else --Handles input during regular state. Let's user select a command.
                local count = 0
                for i = queuePos, 0, -1 do
                    if object.queue.actions[i] == Commands.LOOP then
                        count = count + 1
                    end
                end
                object.queue.loopPointer = count
--                if(object:getQueue(object.inputArea)[queuePos] == Commands.LOOP)then
--                    object.buildArea:setQueue(object.queue.loopActions[object.queue.loopPointer],"loop")
--                end
                object.rightMenu.selectedCommand = object:getQueue(object.inputArea)[queuePos]
                print(object:getQueue(object.inputArea)[queuePos])

                if object.rightMenu.selectedCommand ~= nil then
                    object.rightMenu.inputAreaChanged = true
                    object.rightMenu.inputArea = "options"
                end
                object.selectingActionEdit = object:getQueue(object.inputArea)[queuePos]
            end
        elseif event.key == Event.KEY_BACK then --This terminates the game no matter what is happening.
            object:returnToMenus()
        end
    end
end

function BottomMenu:isBuildArea()
    if self.inputArea == "loop" or self.inputArea == "P1" or self.inputArea == "P2" or self.inputArea == "if-wall" or self.inputArea == "if-not-wall" then
        return true
    else
        return false
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

---------------------------------------------
-- Checks if marker is allowed to go to the right from the current position.
-- Returns true if allowed and false otherwise.
-- @author Mikael Ögren
-----------------------------------------
function BottomMenu:isAllowedRight()
    local queuePos = self.position
    if queuePos > 2*self.rowLength then
        queuePos = queuePos - 2*self.rowLength
    end

    if self.position < 4*self.rowLength and self.position ~= 2*self.rowLength and self.maxCommands[self.inputArea] > queuePos  then
        return true
    else
        return false
    end
end

---------------------------------------------
-- Checks if marker is allowed to go down from the current position.
-- Returns true if allowed and false otherwise.
-- @author Mikael Ögren
-----------------------------------------
function BottomMenu:isAllowedDown()
    local queuePos = self.position
    if queuePos > 2*self.rowLength then
        queuePos = queuePos - 2*self.rowLength
    end

    if  self:isUpperRow(self.position) == true and self.maxCommands[self.inputArea] >= queuePos + self.rowLength then
        return true
    else
        return false
    end
end

---------------------------------------------
-- Enters the method (loop, P1 or P2) currently marked
-- @author Mikael Ögren
-----------------------------------------
function BottomMenu:enterMethod()
    local queuePos = self.position
    if queuePos > 2*self.rowLength then
        queuePos = queuePos - 2*self.rowLength -- Must be done if clicking a command in buildArea to get correct position in queue
    end
    if self.maxCommands[self:getQueue(self.inputArea)[queuePos]] > 0 then
        self.buildArea:setBuildType(self:getQueue(self.inputArea)[queuePos]) --object:getQueue(object.inputArea)[queuePos] is the command you clicked on
        self.inputArea = self:getQueue(self.inputArea)[queuePos]
        self.prevPosition = self.position
        self.position = 2*self.rowLength + 1
        self.buildArea:setPosition(self.position)
        self.drawBottomMenu:clearPos(self.prevPosition, self.queue.actions)
        self.buildArea.drawBuildArea:clearPos(self.buildArea.prevPosition, self:getQueue(self.inputArea))
    end
end

---------------------------------------------
-- Checks if the marked position is in the top row.
-- Used when navigating the queue with arrow keyes
-- @param pos:integer the position of the marker in the queue
-- @return boolean representing if the marker is in the top row.
-- @author Mikael Ögren
-----------------------------------------
function BottomMenu:isUpperRow(pos)
    if (pos > self.rowLength and pos <= 2*self.rowLength) or (3*self.rowLength < pos and pos <= 4*self.rowLength) then
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
    if self:getQueue(inputArea)[queuePos] == Commands.LOOP then
        local counter = 0
      for i = position, 0, -1 do
          if self.queue.actions[i] == "loop" then
              counter = counter + 1
          end
      end
      table.remove(self.queue.loopActions, counter)
      table.remove(self.queue.loopCounter, counter)
    end

    if queuePos > 2*self.rowLength then
        queuePos = queuePos - 2*self.rowLength -- Must be done if clicking a command in buildArea to get correct position in queue
    end

    if self:getQueue(inputArea)[queuePos] ~= nil then
        for i=queuePos, (#self:getQueue(inputArea)) do
            self:getQueue(inputArea)[i] = self:getQueue(inputArea)[i + 1]
        end
    end
end

-----------------------------------
-- Moves an action in the queue.
-- @param positionOne:Integer. The position (in the menu, not in the queue) of the action to be moved.
-- @param positionTwo:Integer. The position (in the menu, not in the queue) where the action is to be moved.
--@author Mikael Ögren
-----------------------------------
function BottomMenu:moveAction(positionOne, positionTwo)
    local queuePosOne = positionOne
    local queuePosTwo = positionTwo

        if queuePosOne > 2*self.rowLength then
            queuePosOne = queuePosOne - 2*self.rowLength -- Must be done if clicking a command in buildArea to get correct position in queue
            queuePosTwo = queuePosTwo - 2*self.rowLength -- Must be done if clicking a command in buildArea to get correct position in queue
        end

        if queuePosTwo > #self:getQueue(self.inputArea) then
            print("Not allowed to move action to empty slot")
            return
        end

        if (self.inputArea == "queue") and (self:getQueue(self.inputArea)[queuePosOne] == Commands.LOOP or self:getQueue(self.inputArea)[queuePosTwo] == Commands.LOOP) then
            self.queue:setPosition(queuePosOne, queuePosTwo)
        else

        local actionOne = self:getQueue(self.inputArea)[queuePosOne]

        if queuePosOne > queuePosTwo then
            for i = queuePosOne, queuePosTwo + 1, -1 do
                self:getQueue(self.inputArea)[i] = self:getQueue(self.inputArea)[i-1]
            end
            self:getQueue(self.inputArea)[queuePosTwo] = actionOne
        else
            for i = queuePosOne, queuePosTwo - 1 do
                self:getQueue(self.inputArea)[i] = self:getQueue(self.inputArea)[i+1]
            end
            self:getQueue(self.inputArea)[queuePosTwo] = actionOne
        end

        self.actionToMove = nil
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
        return self.queue.loopActions[self.queue.loopPointer]
    elseif inputArea == "P1" then
        return self.queue.p1Actions
    elseif inputArea == "P2" then
        return self.queue.p2Actions
    elseif inputArea == "if-wall" then
        return self.queue.ifTrueActions
    elseif inputArea == "if-not-wall" then
        return self.queue.ifFalseActions
    end
end

BottomMenu.eventHandler = bottomMenuEventHandler

return BottomMenu
