-----------------------------------------------------------
-- This class is for the specific game context which is used
-- to create all the objects related to specific game
-- and to control the screen showing of all objects or
-- update screen 
--
-- @Author:Created by Chuck, Aug 16,2015
-- @Author:Updated by author,date
-----------------------------------------------------------

local Game = require('toolkit.Game')
local Hook = require('toolkit.Hook')
local EventListener = require('toolkit.EventListener')
local ExampleActor = require('games.mario.ExampleActor')
local Mario = extends(Game.class())

-----------------------------------------------------------
-- Create event listener hook to swap listen context to Mario 
-- context. When platform load game, it need to add a chain 
-- between game event listener and itself event listener to 
-- make game accept keyboard event. This hook will help specific 
-- game get platform context and change context of game's Listener 
-- to game itself
-- @context which is the object who creates the listener, here
--          is the priori object which will be changed to game
-- @event which is keyboard event
-----------------------------------------------------------

--beforeUpdateHook = Hook:new()
--function beforeUpdateHook:beforeListenerUpdate(context,event)
--  Mario.gameEventListener.context = Mario
--end
--Mario.gameEventListener.beforeUpdateHook = beforeUpdateHook

-----------------------------------------------------------
-- Construct method
-----------------------------------------------------------
function Mario:new(context)

  -- override hook function to make some changes for mario, we need to change platform context to game context
  -- Add platform context 
  self.platformContext = context
  -- create all the objects related in game
  
  self.exampleActor = ExampleActor:new()
  -- initialize listener whose detail has been implemented in super class
  
  ----------------
  -- some error I am trying to solve here. It is the connection between platform listener and game listener
  -----------------
  self:initListener()
  -- attach all object to delegate
  self.gameEventListener:attach(self.exampleActor)
  return self.class()
end


-----------------------------------------------------------
-- Loading resources
-----------------------------------------------------------
local function load()
  -- load resources 
  Mario.exampleActor:load()
  print("load resouces")
end

-----------------------------------------------------------
-- Start a game after loading resources
-----------------------------------------------------------
function Mario:start()


 
  load()
  
  -- start game
  print("start game")
  
  --self.platformContext:update()
end


-----------------------------------------------------------
-- Update screen and inform platform to update screen
-----------------------------------------------------------
function Mario:update()
  -- object code update
  self.exampleActor:show()
  print("update Mario")
  -- Inform platform to update
  -- self.platformContext.update()
end



return Mario