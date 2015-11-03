-----------------------------------------------------------
-- This class is for the platform menu which is used
-- to show game choice menu and process some key events
--
-- @Author:Created by Chuck, Aug 16,2015
-- @Author:Updated by author,date
-----------------------------------------------------------

local Object = require('toolkit.Object')
local EventHandler = require('toolkit.EventHandler')
local Event = require('toolkit.Event')
local Controllable = require('toolkit.Controllable')
local GameFactory = require('games.GameFactory')

local PlatformMenu = extends(Controllable.class())


-----------------------------------------------------------
-- Construct method
-----------------------------------------------------------
function PlatformMenu:new()
  -- example code 
  self.position = {x=1,y=2}
  return self.class()
end

function PlatformMenu:show()
  -- example code
  screen:clear({g=15, r=15, b=220}, {x=self.position.x*100,y=self.position.y*100,width=100,height=100})
end

function PlatformMenu:update()
  -- example code
  screen:clear({g=15, r=15, b=220}, {x=self.position.x*100,y=self.position.y*100,width=100,height=100})
end
-----------------------------------------------------------
-- Menu event handler for some keyboard input, when creating 
-- a handler, you need to do a few the steps as follow
-- @object which will be operated, usually it is 
--          the class that contain this handler, here is menu
-- @event which is event currently happening
-----------------------------------------------------------

-- create a event delegate for menu
menuEventHandler = EventHandler:new()

-- register interesting events, listener will only notify these events
menuEventHandler.events = {[Event.KEY_UP] = Event.KEY_STATE_DOWN,[Event.KEY_DOWN] = Event.KEY_STATE_DOWN,[Event.KEY_RIGHT]=Event.KEY_STATE_DOWN,[Event.KEY_LEFT]=Event.KEY_STATE_DOWN}

-- override specific update method to response keyboard events, 
function menuEventHandler:update(object,eventListener,event)
  print("platform menu event handler")
  if event.key == Event.KEY_UP then
    ------------
    --code 
    ------------
    
    -- load game only once
    if event.state == Event.KEY_STATE_DOWN then
      PlatformContext.game = GameFactory:getGame("mario",PlatformContext)
      PlatformContext.game:start()
    end
    
    
  elseif event.key == Event.KEY_RIGHT then
    PlatformMenu.position.x = PlatformMenu.position.x + 1
    ------------
    --code 
    ------------ 
  elseif event.key == Event.KEY_LEFT then
    PlatformMenu.position.x = PlatformMenu.position.x - 1
    ------------
    --code 
    ------------
  elseif event.key == Event.KEY_DOWN then
    PlatformMenu.position.y = PlatformMenu.position.y + 1
    ------------
    --code 
    ------------
  end
end

-- Make handler useful to PlatformMenu
PlatformMenu.eventHandler = menuEventHandler

return PlatformMenu