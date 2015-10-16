require('toolkit.Object')
require('toolkit.EventHandler')
require('toolkit.Events')
require('toolkit.Controllable')
require('games.GameFactory')

PlatformMenu = Controllable:new()

function PlatformMenu:new()
  return self
end

----------------------------------------------------
-- menu event delegate for some keyboard input 
-- @object: Object
-- @events: Table event list
----------------------------------------------------
-- create a event delegate for menu
menuEventHandler = EventHandler:new()

-- register interesting events
menuEventHandler.events = {[Events.KEY_UP] = 1,[Events.KEY_DOWN] = 1,[Events.KEY_RIGHT]=1,[Events.KEY_LEFT]=1}

-- override specific update method to response keyboard events
function menuEventHandler:update(object,eventListener,event)
  if event == Events.KEY_UP then
    -- code 
    -- load game only once
    PlatformContext.game = GameFactory:getGame("mario")
    PlatformContext.game:start()
    
  elseif event == Events.KEY_RIGHT then
    -- code 
  elseif event == Events.KEY_LEFT then
    -- code
  elseif event == Events.KEY_DOWN then
    -- code
  end
end

-- make handler useful
PlatformMenu.eventHandler = menuEventHandler

return PlatformMenu