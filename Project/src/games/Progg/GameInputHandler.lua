
ADConfig = require("Config.ADConfig")
ADLogger = require("SDK.Utils.ADLogger")
ADLogger.trace("Application Init")

if ADConfig.isSimulator then
  gfx = require "SDK.Simulator.gfx"
  zto = require "SDK.Simulator.zto"
  surface = require "SDK.Simulator.surface"
  player = require "SDK.Simulator.player"
  freetype = require "SDK.Simulator.freetype"
  sys = require "SDK.Simulator.sys"
end

local Controllable = require("toolkit.Controllable")
local EventHandler = require('toolkit.EventHandler')
local Event = require('toolkit.Event')
local Commands = require('games.Progg.Commands')

GameInputHandler = extends(Controllable.class())

local context = nil
local queue = nil
local character = nil
local rightMenu = nil
local bottomMenu
local buildArea = nil
-----------------------------------------------------------
-- Construct method takes the context as parameter
-- to be able to create new menu for PlatformContext
-- -------------------------------------------------------
function GameInputHandler:new(gameContext, inqueue, newCharacter, newRightMenu, newBuildArea)
  context = gameContext
  queue = inqueue
  character = newCharacter
  rightMenu = newRightMenu
  buildArea = newBuildArea
return self.class()
end

function GameInputHandler:load()
  self.proggImage = gfx.loadpng('data/ProgrammingGamePic_405.png')
end

function GameInputHandler:show()

  --screen:copyfrom(self.proggImage, nil, { x = 0, y = 0, w = screen:get_width(), h = screen:get_height() }, true)
end
 

--Execute the entire queue but dosnt delete it
function GameInputHandler:executeQueue()

  local executionQueue = queue:getExecutionQueue()
  for i = 1, #executionQueue.actions do
    character:execute(executionQueue:pop())
  end
end

--Subscribing the eventHandler to all events. Only numbers by now
gameEventHandler = EventHandler:new()
gameEventHandler.events = {[Event.KEY_ONE] = 1,[Event.KEY_TWO] = 1,[Event.KEY_THREE]=1,[Event.KEY_FOUR]=1,[Event.KEY_FIVE]=1,[Event.KEY_SIX]=1,[Event.KEY_SEVEN]=1,[Event.KEY_EIGHT]=1,[Event.KEY_NINE]=1,[Event.KEY_ZERO]=1}

--Update function on every key input
function gameEventHandler:update(object,eventListener,event)

if(event.state==Event.KEY_STATE_DOWN) then
      --Switch for all the input handling to implement
      if event.key == Event.KEY_ONE then
        queue:push(Commands.MOVE)
        rightMenu:highlight(Commands.MOVE)
     
      elseif event.key == Event.KEY_TWO then
        queue:push(Commands.TURN_LEFT)
        rightMenu:highlight(Commands.TURN_LEFT)
      
      elseif event.key == Event.KEY_THREE then
        queue:push(Commands.TURN_RIGHT)
        rightMenu:highlight(Commands.TURN_RIGHT)

      elseif event.key == Event.KEY_FOUR then


      elseif event.key == Event.KEY_FIVE then
     
      
      elseif event.key == Event.KEY_SIX then
        buildArea:setBuildType("loop")
        queue:push(Commands.LOOP)
        rightMenu:highlight(Commands.LOOP)

      elseif event.key == Event.KEY_SEVEN then
        buildArea:setBuildType("procedure")
        queue:push(Commands.P1)
        rightMenu:highlight(Commands.P1)

      elseif event.key == Event.KEY_EIGHT then
         
      elseif event.key == Event.KEY_NINE then
      context.platformEventListener:removeChainListener()
      context:createNewMenu()
      context.game = nil
          
      elseif event.key == Event.KEY_ZERO then
      GameInputHandler:executeQueue()
      
     end
 end
 return true
end

GameInputHandler.eventHandler = gameEventHandler


return GameInputHandler
