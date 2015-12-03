-----------------------------------------------------------
-- This class contains methods for interacting with the
-- right-hand menu
--
-- @Author:Created by Mikael Ögren, Nov 04,2015
-- @Author:Updated by Vilhelm Granath, Nov 16, 2015 Moved draw functions to DrawRightMenu
-----------------------------------------------------------

local Object = require("toolkit.Object")
local Controllable = require("toolkit.Controllable")
local EventHandler = require('toolkit.EventHandler')
local Event = require('toolkit.Event')
local Commands = require('games.Progg.Commands')
local skin = require('games.Progg.progg_skin')

local RightMenu = extends(Controllable)
local drawRightMenu = require('games.Progg.DrawRightMenu')


-------------------------------------
-- Creates the Right-hand screen in the programming game
-- @return rightMenu:RightMenu The created object.
-- @author Vilhelm
-------------------------------------
function RightMenu:new(maxCommands)
    local o = RightMenu:super()
    --Draw right-hand side
    screen:clear({ r = 92, g = 128, b = 149 }, { x = screen:get_width() * 0.75, y = 0, w = screen:get_width() * 0.25, h = screen:get_height()*0.65 })
    -- @member drawRightMenu:DrawRightMenu
    o.draw = drawRightMenu:new(maxCommands)
    o.currentHighlight = nil
    o.inputAreaChanged = false
    o.preventFalseChanged = false
    o.inputArea = "queue"
    o.highlightTimer = nil
    o.isFirstTimeLoop = true

    return RightMenu:init(o)
end

-------------------------------------
-- Load function
-- @author Vilhelm
-------------------------------------
function RightMenu:load()
    self:standardLayout()
end

-------------------------------------
-- Shows all elements in the menu
-- Currently also used to test certain commands
-- @author Vilhelm
-------------------------------------
function RightMenu:show(bottomInput, preventFalse)
    --self:standardLayout()
    --self:optionsLayout(true)
    --self:highlight("action")
    --self:highlight("P2")
    --self:play()
    --self:stop()
    --self:loopLayout()
    --self:buildLayout()
    if (self.inputAreaChanged == true or self.preventFalseChanged == true) then
        if (self.inputArea == "queue") then
            self:standardLayout()
        elseif(self.inputArea == "loop") then
            self:loopLayout()
        elseif(self.inputArea == "build") then
            self:buildLayout(bottomInput)
        elseif(self.inputArea == "if-wall") then
            self:ifTrueLayout(preventFalse)
        elseif(self.inputArea == "options") then
            self:optionsLayout()
        elseif(self.inputArea == "confirm") then
            self:confirmLayout()
        end
        self.inputAreaChanged = false
        self.preventFalseChanged = false
    end
    if (self.toHighlight ~= nil) then
        self:highlight(self.toHighlight)
        self.toHighlight = nil
    end


end


-------------------------------------
-- Highlights the command in the
-- specified position.
--
-- Needs to implement a timed call to remove
-- the highlight again
--
-- @params command:Commands to be highlighted
-- @author Vilhelm
-------------------------------------
function RightMenu:highlight(command)
    if self.currentHighlight ~= nil then
        self:removeHighlight(self.currentHighlight)
    end

    callback = function(timer)
        self:removeHighlight(self.currentHighlight)
    end

    self.draw:drawHighlight(command)

    self.currentHighlight = command
    self.highlightTimer = sys.new_timer(500, "callback")
end

-------------------------------------
-- Removes the highlight on the command in the
-- specified position.
--
-- @params command:Commands to be un-highlighted
-- @author Vilhelm
-------------------------------------
function RightMenu:removeHighlight(command)
    self.draw:drawRemoveHighlight(command)
    self.currentHighlight = nil
    self.highlightTimer:stop()
end

-------------------------------------
-- Changes the play-button to a stop-button when
-- the play-button is pressed
-- Also removes any highlight on the commands
--
-- Needs to stop the timer if there is one
--
-- @author Vilhelm
-------------------------------------
function RightMenu:play()
    if self.currentHighlight ~= nil then
        self:removeHighlight(self.currentHighlight)
    end
    self.draw:addStop()

end

-------------------------------------
-- Changes the stop-button to a play-button when
-- the stop-button is pressed
-- @author Vilhelm
-------------------------------------
function RightMenu:stop()
    self.draw:addPlay()
end

-------------------------------------
-- Called to write the standard layout
-- @author Vilhelm
-------------------------------------
function RightMenu:standardLayout()
    self.draw:drawRow(1)
    self.draw:drawRow(2)
    self.draw:drawRow(3)
    self.draw:addPlay()
    self.draw:addNumbers()
    self.draw:addImages()
end

-------------------------------------
-- Called to replace buttons for loops
-- @author Jonathan
-------------------------------------
function RightMenu:loopLayout()
    self.draw:drawRow(1)
    self.draw:drawRow(2)
    self.draw:drawRow(3)
    self.draw:drawFullRow(4,78,113,215)
    self.draw:addNumbers()
    self.draw:addLoopOptions()
end

-------------------------------------
-- Called to replace buttons for
-- use in the build area
-- @author Vilhelm
-------------------------------------
function RightMenu:buildLayout(bottomInput)
    self.draw:drawRow(1)
    self.draw:drawRow(2)
    self.draw:drawRow(3)
    self.draw:addNumbers()
    self.draw:addImages()
    self.draw:addBack()
    self.draw:preventRecursion(bottomInput ~= "if-not-wall")
end

-------------------------------------
-- Called to replace buttons for
-- use with if-statements
-- @author Vilhelm
-------------------------------------
function RightMenu:ifTrueLayout(preventFalse)
    self.draw:drawRow(1)
    self.draw:drawRow(2)
    self.draw:drawRow(3)
    self.draw:addNumbers()
    self.draw:addImages()
    self.draw:addIfFalse(preventFalse)
    self.draw:preventRecursion(false)
end

function RightMenu:preventIfFalse()
    self.draw:addIfFalse(false)
end
-------------------------------------
-- Called to replace buttons for
-- options when selecting an action
-- @author Vilhelm
-------------------------------------
function RightMenu:optionsLayout()
    self.can_enter = false
    if(self.selectedCommand == "loop" or self.selectedCommand == "P1" or self.selectedCommand == "P2" or self.selectedCommand == "if-wall") then
        self.can_enter = true
    end
    self.draw:addOptions(self.can_enter)
end

-------------------------------------
-- Called to changed button layout
-- to show confirmation window for clear all.
-- @author Mikael Ögrem
-------------------------------------
function RightMenu:confirmLayout()
    self.draw:addConfirm()
end

-------------------------------------
-- Functionality related to the event listener
-- @author Chuck
-------------------------------------
rightMenuEventHandler = EventHandler:new()
rightMenuEventHandler.events = {[Event.KEY_ONE] = 1,[Event.KEY_TWO] = 1,[Event.KEY_THREE]=1,[Event.KEY_FOUR]=1,[Event.KEY_FIVE]=1,[Event.KEY_SIX]=1,[Event.KEY_SEVEN]=1,[Event.KEY_EIGHT]=1,[Event.KEY_NINE]=1,[Event.KEY_ZERO]=1,[Event.KEY_OK]=1}

-- Warning!!!! Use parameter "object" as a reference RightMenu,
-----Never use RightMenu directly
-----Never use self to refer to RightMenu

------------------------------------------
-- Handles all input to the rightMenu.
-- @param object:RightMenu the rightMenu that owns this handler
-- @param eventListener:EventListener
-- @param event:Event the event that trigered the function call
function rightMenuEventHandler:update(object,eventListener,event)
    if(event.state==Event.KEY_STATE_DOWN) then
    end
end

RightMenu.eventHandler = rightMenuEventHandler

return RightMenu