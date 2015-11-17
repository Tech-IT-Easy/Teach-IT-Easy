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
  o.availableSlots = maxCommands
  o.queue = {}
  --queue = inQueue
  context = gameContext
  o.buildArea = buildArea:new(16)
  o.drawBottomMenu = newDrawBottomMenu:new(o.availableSlots)
  o.character = Character:new(Position:new(0,0))
  queue = Queue:new(o, o.buildArea)
  return BottomMenu:init(o)
end

-- Used to load images
function BottomMenu:load()

end

--Used when BottomMenu is updated
function BottomMenu:show()
  self.drawBottomMenu:background(inputArea)
  self.drawBottomMenu:emptySlots(inputArea)
  self.drawBottomMenu:icons(self.queue)
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
  local executionQueue = queue:getExecutionQueue()
  for i = 1, #executionQueue.actions do
    self.character:execute(executionQueue:pop())
  end
end


--Subscribing the eventHandler to all events. Only numbers by now
bottomMenuEventHandler = EventHandler:new()
bottomMenuEventHandler.events = {[Event.KEY_ONE] = 1,[Event.KEY_TWO] = 1,[Event.KEY_THREE]=1,[Event.KEY_FOUR]=1,[Event.KEY_FIVE]=1,[Event.KEY_SIX]=1,[Event.KEY_SEVEN]=1,[Event.KEY_EIGHT]=1,[Event.KEY_NINE]=1,[Event.KEY_ZERO]=1}

--Update function on every key input
function bottomMenuEventHandler:update(object,eventListener,event)

  if(event.state==Event.KEY_STATE_DOWN) then
    --Switch for all the input handling to implement
    if event.key == Event.KEY_ONE then
      queue:push(Commands.MOVE, inputArea)
      --rightMenu:highlight(Commands.MOVE)

    elseif event.key == Event.KEY_TWO then
      queue:push(Commands.TURN_LEFT, inputArea)
      --rightMenu:highlight(Commands.TURN_LEFT)

    elseif event.key == Event.KEY_THREE then
      queue:push(Commands.TURN_RIGHT, inputArea)
      --rightMenu:highlight(Commands.TURN_RIGHT)

    elseif event.key == Event.KEY_FOUR then


    elseif event.key == Event.KEY_FIVE then


    elseif event.key == Event.KEY_SIX then
      object.buildArea:setBuildType("loop")
      queue:push(Commands.LOOP, inputArea)
      inputArea = "loop"
      --rightMenu:highlight(Commands.LOOP)

    elseif event.key == Event.KEY_SEVEN then
      object.buildArea:setBuildType("P1")
      queue:push(Commands.P1, inputArea)
      inputArea = "P1"
      --rightMenu:highlight(Commands.P1)

    elseif event.key == Event.KEY_EIGHT then
      object.buildArea:setBuildType("P2")
      queue:push(Commands.P2, inputArea)
      inputArea = "P2"
      --rightMenu:highlight(Commands.P2)

    elseif event.key == Event.KEY_NINE then
      context.platformEventListener:removeChainListener()
      context:createNewMenu()
      context.game = nil

    elseif event.key == Event.KEY_ZERO then
      if inputArea == "queue"  then
        GameInputHandler:executeQueue()
      else
        inputArea = "queue"
      end
    end
  end
  return true
end

BottomMenu.eventHandler = bottomMenuEventHandler



return BottomMenu
