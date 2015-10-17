-----------------------------------------------------------
-- This class is supper class for the controllable object  
-- which extends this class so that it owns controllable object
-- features
--
-- @Author:Created by Chuck, Aug 16,2015
-- @Author:Updated by author,date
-----------------------------------------------------------
local Object = require("toolkit.Object")

local Controllable = extends(Object.class())

-- Controllable.eventHandler = nil

-----------------------------------------------------------
-- Judge whether a event is interested by this controllable 
-- object,this is typically used when listener notifies
-- @event which will be judged
-----------------------------------------------------------
function Controllable:interestInEvent(event)
  return self.eventHandler.events[event.key] ~= nil
end

-----------------------------------------------------------
-- Get event inform form listener
-- @listener which is the listener who send notify message,
--           it is kept for future extention
-- @event which will be judged
-----------------------------------------------------------
function Controllable:process(listener,event)
  self.eventHandler:update(self,listener,event)
end

return Controllable
