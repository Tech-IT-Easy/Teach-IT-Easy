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

ExampleActor = extends(Controllable.class())

-----------------------------------------------------------
-- Construct method 
-- This is a specific object, give some specific properties value
-----------------------------------------------------------
function ExampleActor:new()
  self.position = {x=3,y=3}
  self.image = "data/mario.png"
  self.loadImage = nil
  return self.class()
end


-----------------------------------------------------------
-- Load resources method which will be abstracted future
-----------------------------------------------------------
function ExampleActor:load()
  self.loadImage = gfx.loadpng(self.image)
end

-----------------------------------------------------------
-- Show on screen method which will be abstracted future
-----------------------------------------------------------
function ExampleActor:show()
  screen:copyfrom(self.loadImage, nil, {x=(self.position.x)*30,y=(self.position.y)*30,w=100,h=100},true)
end

-----------------------------------------------------------
-- ExampleActor event handler for some keyboard input, when creating
-- a handler, you need to do a few the steps as follow
-- @object which will be operated, usually it is
--          the class that contain this handler, here is menu
-- @event which is event currently happening
-----------------------------------------------------------

-- create a event delegate for menu
exampleEventHandler = EventHandler:new()

-- register interesting events, listener will only notify these events
exampleEventHandler.events = {[Event.KEY_UP] = 1,[Event.KEY_DOWN] = 1,[Event.KEY_RIGHT]=1,[Event.KEY_LEFT]=1}

-- override specific update method to response keyboard events,
function exampleEventHandler:update(object,eventListener,event)
  print("mario game actor event handler")
  if event.key == Event.KEY_UP then
  ------------
  --code
  ------------
  
  elseif event.key == Event.KEY_RIGHT then
  ------------
  --code
  ------------
  ExampleActor.position.x = ExampleActor.position.x + 1
  
  elseif event.key == Event.KEY_LEFT then
  ------------
  --code
  ------------
  elseif event.key == Event.KEY_DOWN then
  ------------
  --code
  ------------
  end
  
  return true
end

-- Make handler useful to PlatformMenu
ExampleActor.eventHandler = exampleEventHandler

return ExampleActor
