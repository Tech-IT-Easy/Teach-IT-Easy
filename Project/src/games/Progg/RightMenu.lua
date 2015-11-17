-----------------------------------------------------------
-- This class contains methods for interacting with the
-- right-hand menu
--
-- @Author:Created by Mikael Ögren, Nov 04,2015
-- @Author:Updated by Vilhelm Granath, Nov 16, 2015 Moved draw functions to DrawRightMenu
-----------------------------------------------------------

local Object = require("toolkit.Object")
local Controllable = require("toolkit.Controllable")
local RightMenu = extends(Controllable)
skin = require('games/Progg/progg_skin')
local Commands = require('games.Progg.Commands')
local Event = require('toolkit.Event')
local EventHandler = require('toolkit.EventHandler')
local drawRightMenu = require('games/Progg/DrawRightMenu')

-- Variale to keep track of a highlighted command


-- Available commands
commands = {"move","turn-left","turn-right","action","if-wall","loop","P1","P2"}

-------------------------------------
-- Creates the Right-hand screen in the programming game
-- @return self. The created object.
-- @author Vilhelm
-------------------------------------
function RightMenu:new()
    local o = RightMenu:super()
    --Draw right-hand side
    screen:clear({ r = 92, g = 128, b = 149 }, { x = screen:get_width() * 0.75, y = 0, w = screen:get_width() * 0.25, h = screen:get_height()*0.65 })
    o.draw = drawRightMenu:new()
    self.currentHighlight = nil
    return RightMenu:init(o)
end

-------------------------------------
-- Load function
-- @author Vilhelm
-------------------------------------
function RightMenu:load()

end

-------------------------------------
-- Shows all elements in the menu
-- Currently also used to test certain commands
-- @author Vilhelm
-------------------------------------
function RightMenu:show()
    self:standardLayout()
    --self:highlight("action")
    --self:highlight("P2")
    --self:play()
    --self:stop()
    --self:loopLayout()
    --self:buildLayout()
end


-------------------------------------
-- Highlights the command in the
-- specified position.
--
-- Needs to implement a timed call to remove
-- the highlight again
--
-- @params command: command to be highlighted
-- @author Vilhelm
-------------------------------------
function RightMenu:highlight(command)
    if self.currentHighlight ~= nil then
        self:removeHighlight(self.currentHighlight)
    end

    self.draw:drawHighlight(command)

    self.currentHighlight = command

end

-------------------------------------
-- Removes the highlight on the command in the
-- specified position.
--
-- @params command: command to be un-highlighted
-- @author Vilhelm
-------------------------------------
function RightMenu:removeHighlight(command)
    self.draw:drawRemoveHighlight(command)
    self.currentHighlight = nil
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
    if self.currentHighlight ~= nill then
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
-- @author Vilhelm
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
function RightMenu:buildLayout()
    self.draw:addPlayAndBack()
end


-------------------------------------
-- Functionality related to the event listener
-- @author Chuck
-------------------------------------
rightMenuEventHandler = EventHandler:new()
rightMenuEventHandler.events = {[Event.KEY_ONE] = 1,[Event.KEY_TWO] = 1,[Event.KEY_THREE]=1,[Event.KEY_FOUR]=1,[Event.KEY_FIVE]=1,[Event.KEY_SIX]=1,[Event.KEY_SEVEN]=1,[Event.KEY_EIGHT]=1,[Event.KEY_NINE]=1,[Event.KEY_ZERO]=1}

-- Warning!!!! Use parameter "object" as a reference RightMenu,
-----Never use RightMenu directly
-----Never use self to refer to RightMenu
function rightMenuEventHandler:update(object,eventListener,event)
    if(event.state==Event.KEY_STATE_DOWN) then
        --Switch for all the input handling to implement
        if event.key == Event.KEY_ONE then
            object:highlight(Commands.MOVE)

        elseif event.key == Event.KEY_TWO then
            object:highlight(Commands.TURN_LEFT)

        elseif event.key == Event.KEY_THREE then
            object:highlight(Commands.TURN_RIGHT)

        elseif event.key == Event.KEY_FOUR then


        elseif event.key == Event.KEY_FIVE then


        elseif event.key == Event.KEY_SIX then
            object:highlight(Commands.LOOP)

        elseif event.key == Event.KEY_SEVEN then
            object:highlight(Commands.P1)

        elseif event.key == Event.KEY_EIGHT then
            object:highlight(Commands.P2)

        elseif event.key == Event.KEY_NINE then

        elseif event.key == Event.KEY_ZERO then

        end
    end
    return true
end

RightMenu.eventHandler = rightMenuEventHandler

return RightMenu