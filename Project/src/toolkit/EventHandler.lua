-----------------------------------------------------------
-- This class is supper class for the event handler, usually a
-- controllable object needs this to process the specific event,
-- for example up or left.
--
-- @Author:Created by Chuck, Aug 16,2015
-- @Author:Updated by author,date
-----------------------------------------------------------
local Object = require("toolkit.Object")

local EventHandler = extends(Object.class())


-- events that this handler are capable of processing
EventHandler.events = {}

-----------------------------------------------------------
-- Delegate for object when some event happens, it is like a 
-- abstract method which is required to be implemented in 
-- specific usage.
-- @object which is the object who owns this handler
-- @event which is specific event
-- @eventListener which is for future developing but now it's 
-- not used
-----------------------------------------------------------
function EventHandler:update(object,eventListener,event)
  -- do some events process in specific object, never change here
end

return EventHandler
