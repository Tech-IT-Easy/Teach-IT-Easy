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
local BottomMenu = extends(Controllable)

local inputArea = "queue"
local queue = nil
local context = nil
local newDrawBottomMenu = require("games.Progg.DrawBottomMenu")

--Constructor method
function BottomMenu:new(maxCommands,gameContext)
    local o = BottomMenu:super()
    o.selectingLoopCounter = false;
    o.queue = {}
    o.position = 1
    o.prevPosition = nil
    context = gameContext
    print("pos: ", o.position)
    o.buildArea = buildArea:new(maxCommands, o.position)
    o.drawBottomMenu = newDrawBottomMenu:new(maxCommands)
    o.character = Character:new(Position:new(0,0))
    queue = Queue:new(o, o.buildArea)
    return BottomMenu:init(o)
end


function BottomMenu:load()
    self.drawBottomMenu:background(inputArea)
    self.drawBottomMenu:emptySlots(inputArea)
    self.drawBottomMenu:headline("Main")
    self.buildArea:load()
    self.buildArea:show(inputArea, queue)
end

--Used when BottomMenu is updated
function BottomMenu:show()
    self.drawBottomMenu:icons(self.queue)
    self.drawBottomMenu:highlightIcon(self.position, self.prevPosition, self.queue)
    self.buildArea:show(inputArea, queue)
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
    self.character:startExecution(queue)

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
              queue.loopCounter = 1
              object.selectingLoopCounter=false
        else
              queue:push(Commands.MOVE, inputArea)
           end

      elseif event.key == Event.KEY_TWO then
        if(inputArea =="loop" and object.selectingLoopCounter==true ) then
              queue.loopCounter = 2
              buildArea:drawLoopCounter(queue.loopCounter)
              object.selectingLoopCounter=false
        else
              queue:push(Commands.TURN_LEFT, inputArea)
           end

      elseif event.key == Event.KEY_THREE then
         if(inputArea =="loop" and object.selectingLoopCounter==true ) then
              queue.loopCounter = 3
              object.selectingLoopCounter=false
        else
              queue:push(Commands.TURN_RIGHT, inputArea)
           end

      elseif event.key == Event.KEY_FOUR then
        if(inputArea =="loop" and object.selectingLoopCounter==true ) then
              queue.loopCounter = 4
              object.selectingLoopCounter=false
        else
              --queue:push(Commands.TURN_RIGHT, inputArea)
           end

      elseif event.key == Event.KEY_FIVE then
         if(inputArea =="loop" and object.selectingLoopCounter==true ) then
              queue.loopCounter = 5
              object.selectingLoopCounter=false
        else
              --queue:push(Commands.TURN_RIGHT, inputArea)
           end

      elseif event.key == Event.KEY_SIX then

         if(inputArea =="loop" and object.selectingLoopCounter==true ) then
              queue.loopCounter = 6
              object.selectingLoopCounter=false
        else
            object.buildArea:setBuildType("loop")
            queue:push(Commands.LOOP, inputArea)
            inputArea = "loop"
            object.selectingLoopCounter=true
         end

        object.position = 17
        object.buildArea:setPosition(object.position)

      elseif event.key == Event.KEY_SEVEN then
       if(inputArea =="loop" and object.selectingLoopCounter==true ) then
              queue.loopCounter = 7
              object.selectingLoopCounter=false
       else
          object.buildArea:setBuildType("P1")
          queue:push(Commands.P1, inputArea)
          inputArea = "P1"
       end

        object.position = 17
        object.buildArea:setPosition(object.position)


      elseif event.key == Event.KEY_EIGHT then
        if(inputArea =="loop" and object.selectingLoopCounter==true ) then
             queue.loopCounter = 8
             object.selectingLoopCounter=false
         else
             object.buildArea:setBuildType("P2")
             queue:push(Commands.P2, inputArea)
             inputArea = "P2"
         end

        object.position = 17
        object.buildArea:setPosition(object.position)

      elseif event.key == Event.KEY_NINE then
       if(inputArea =="loop" and object.selectingLoopCounter==true ) then
             queue.loopCounter = 9
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
              object:setPosition(-9)
              object.buildArea.drawBuildArea:clearPos(object.prevPosition, object.buildArea.loopQueue)
          elseif object.position > 1 then
              object:setPosition(-1)
          end
      elseif event.key == Event.KEY_RIGHT then
          if object.position == 8 or object.position == 16 then
              object:setPosition(9)
              object.drawBottomMenu:clearPos(object.prevPosition, object.queue)
          elseif object.position < 32 then
              object:setPosition(1)
          end
      elseif event.key == Event.KEY_ZERO then
          if inputArea == "queue"  then
            object:executeQueue()
          else
            inputArea = "queue"
          end
      end
      print(object.position)
  end
  return true
end

function BottomMenu:setPosition(change)
    self.prevPosition = self.position
    self.position = self.position + change
    self.buildArea:setPosition(self.position)
end


function BottomMenu:isUpperRow(pos)
    if (pos > 8 and pos <= 16) or (24 < pos and pos <= 32) then
        return false
    else
        return true
    end
end

BottomMenu.eventHandler = bottomMenuEventHandler



return BottomMenu
