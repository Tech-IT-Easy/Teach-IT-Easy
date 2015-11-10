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

GameInputHandler = extends(Controllable.class())

local context = nil
-----------------------------------------------------------
-- Construct method takes the context as parameter
-- to be able to create new menu for PlatformContext
-- -------------------------------------------------------
function GameInputHandler:new(gameContext)
  context = gameContext
return self.class()
end

function GameInputHandler:load()
  self.proggImage = gfx.loadpng('data/ProgrammingGamePic_405.png')
end

function GameInputHandler:show()
  --screen:copyfrom(self.proggImage, nil, { x = 0, y = 0, w = screen:get_width(), h = screen:get_height() }, true)
end
 
--Subscribing the eventHandler to all events. Only numbers by now
gameEventHandler = EventHandler:new()
gameEventHandler.events = {[Event.KEY_ONE] = 1,[Event.KEY_TWO] = 1,[Event.KEY_THREE]=1,[Event.KEY_FOUR]=1,[Event.KEY_FIVE]=1,[Event.KEY_SIX]=1,[Event.KEY_SEVEN]=1,[Event.KEY_EIGHT]=1,[Event.KEY_NINE]=1,[Event.KEY_ZERO]=1}

--Update function on every key input
function gameEventHandler:update(object,eventListener,event)

  --Switch for all the input handling to implement
  if event.key == Event.KEY_ONE then
 
  elseif event.key == Event.KEY_TWO then
  
  elseif event.key == Event.KEY_THREE then
  print("It works!!")
  
  elseif event.key == Event.KEY_FOUR then
  ------------------------------
  --Since the menu is discarded when game starts, 
  --this creates a new one.
  ------------------------------
  context.platformEventListener:removeChainListener()
  context:createNewMenu()
  context.game = nil
  elseif event.key == Event.KEY_FIVE then
  
  elseif event.key == Event.KEY_SIX then
   
  elseif event.key == Event.KEY_SEVEN then
    
  elseif event.key == Event.KEY_EIGHT then
     
  elseif event.key == Event.KEY_NINE then
      
  elseif event.key == Event.KEY_ZERO then
 
 end
 return true
end

GameInputHandler.eventHandler = gameEventHandler


return GameInputHandler
