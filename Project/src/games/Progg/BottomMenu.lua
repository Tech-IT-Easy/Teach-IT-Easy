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

local inputArea = "queue"
local context = nil
local newDrawBottomMenu = require("games.Progg.DrawBottomMenu")

--Constructor method
function BottomMenu:new(maxCommands,gameContext)
    local o = BottomMenu:super()
    o.selectingLoopCounter = false;
    o.position = 1
    context = gameContext
    o.buildArea = buildArea:new(maxCommands, o.position)
    o.drawBottomMenu = newDrawBottomMenu:new(maxCommands)
    o.character = Character:new(Position:new(0,0))
    o.queue = Queue:new(o, o.buildArea)
    return BottomMenu:init(o)
end

-- Used to load images
function BottomMenu:load()
end

--Used when BottomMenu is updated
function BottomMenu:show()
    self.drawBottomMenu:background(inputArea)
    self.drawBottomMenu:emptySlots(inputArea)
    self.drawBottomMenu:icons(self.queue.actions)
    self.drawBottomMenu:highlightIcon(self.position, self.queue.actions)
    self.drawBottomMenu:headline("Main")
    self.buildArea:show(inputArea)
end

-------------------------------------
-- Set the queue for this class.
-- @param queue. The queue that this class should use.
-- @author Mikael Ögren
-------------------------------------
function BottomMenu:setQueue(queue)
  self.queue = queue
end

function BottomMenu:executeQueue()
    self.character:startExecution(self.queue)
 
end


--Subscribing the eventHandler to all events.
bottomMenuEventHandler = EventHandler:new()
bottomMenuEventHandler.events = {[Event.KEY_ONE] = 1,[Event.KEY_TWO] = 1,[Event.KEY_THREE]=1,[Event.KEY_FOUR]=1,[Event.KEY_FIVE]=1,[Event.KEY_SIX]=1,[Event.KEY_SEVEN]=1,[Event.KEY_EIGHT]=1,[Event.KEY_NINE]=1
    ,[Event.KEY_ZERO]=1,[Event.KEY_UP]=1,[Event.KEY_DOWN]=1 ,[Event.KEY_LEFT]=1,[Event.KEY_RIGHT]=1 }

--Update function on every key input
function bottomMenuEventHandler:update(object,eventListener,event)

  if(event.state==Event.KEY_STATE_DOWN) then
      --Switch for all the input handling to implement
      if event.key == Event.KEY_ONE then
        if(inputArea =="loop" and object.selectingLoopCounter==true ) then
              object.queue.loopCounter = 1
              object.selectingLoopCounter=false
        else
              object.queue:push(Commands.MOVE, inputArea)
           end

      elseif event.key == Event.KEY_TWO then
        if(inputArea =="loop" and object.selectingLoopCounter==true ) then
              object.queue.loopCounter = 2
              object.selectingLoopCounter=false
        else
              object.queue:push(Commands.TURN_LEFT, inputArea)
           end

      elseif event.key == Event.KEY_THREE then
         if(inputArea =="loop" and object.selectingLoopCounter==true ) then
              object.queue.loopCounter = 3
              object.selectingLoopCounter=false
        else
              object.queue:push(Commands.TURN_RIGHT, inputArea)
           end

      elseif event.key == Event.KEY_FOUR then
        if(inputArea =="loop" and object.selectingLoopCounter==true ) then
              object.queue.loopCounter = 4
              object.selectingLoopCounter=false
        else
              --queue:push(Commands.TURN_RIGHT, inputArea)
        end

      elseif event.key == Event.KEY_FIVE then
         if(inputArea =="loop" and object.selectingLoopCounter==true ) then
              object.queue.loopCounter = 5
              object.selectingLoopCounter=false
        else
              --queue:push(Commands.TURN_RIGHT, inputArea)
        end

      elseif event.key == Event.KEY_SIX then

         if(inputArea =="loop" and object.selectingLoopCounter==true ) then
              object.queue.loopCounter = 6
              object.selectingLoopCounter=false
        else
            object.buildArea:setBuildType("loop")
            object.queue:push(Commands.LOOP, inputArea)
            inputArea = "loop"
            object.selectingLoopCounter=true
         end

        object.position = 17
        object.buildArea:setPosition(object.position)

      elseif event.key == Event.KEY_SEVEN then
       if(inputArea =="loop" and object.selectingLoopCounter==true ) then
              object.queue.loopCounter = 7
              object.selectingLoopCounter=false
       else
          object.buildArea:setBuildType("P1")
          object.queue:push(Commands.P1, inputArea)
          inputArea = "P1"
       end

        object.position = 17
        object.buildArea:setPosition(object.position)


      elseif event.key == Event.KEY_EIGHT then
        if(inputArea =="loop" and object.selectingLoopCounter==true ) then
             object.queue.loopCounter = 8
             object.selectingLoopCounter=false
         else
             object.buildArea:setBuildType("P2")
             object.queue:push(Commands.P2, inputArea)
             inputArea = "P2"
         end

        object.position = 17
        object.buildArea:setPosition(object.position)

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
          if (object.position > 8 and object.position <= 16) or (24 < object.position <= 32) then
              object.position = object.position - 8
              object.buildArea:setPosition(object.position)
          end
      elseif event.key == Event.KEY_DOWN then
          if object.position <= 8 or (16 < object.position < 25) then
              object.position = object.position + 8
              object.buildArea:setPosition(object.position)
          end
      elseif event.key == Event.KEY_LEFT then
          if object.position > 1 then
              object.position = object.position - 1
              object.buildArea:setPosition(object.position)
          end
      elseif event.key == Event.KEY_RIGHT then
          if object.position <= 32 then
            object.position = object.position + 1
            object.buildArea:setPosition(object.position)
          end
      elseif event.key == Event.KEY_ZERO then
      if inputArea == "queue"  then
        object:executeQueue()
      else
        inputArea = "queue"
      end
    end
  end
  return true
end

BottomMenu.eventHandler = bottomMenuEventHandler



return BottomMenu
