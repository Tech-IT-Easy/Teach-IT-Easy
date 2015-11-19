-----------------------------------------------------------
-- This class is supper class for the controllable object  
-- which extends this class so that it owns controllable object
-- features
--
-- @Author:Created by Chuck, Aug 16,2015
-- @Author:Updated by Chuck, Nov 11,2015 fit to new structure
-----------------------------------------------------------
local Object = require("toolkit.Object")

local Controllable = extends(Object)

-- Controllable.eventHandler = nil

-----------------------------------------------------------
-- Judge whether a event is interested by this controllable 
-- object,this is typically used when listener notifies
-- @param event:Event which will be judged
-- @return Boolean representing objects interest in the event
-----------------------------------------------------------
function Controllable:interestInEvent(event)
  return self.eventHandler.events[event.key] ~= nil
end

-----------------------------------------------------------
-- Tells the eventHandler to react to the event
-- Get event information from listener
-- @param listener:EventListener which is the listener who send notify message,
--        it is kept for future extention
-- @param event:Event which will be judged
-----------------------------------------------------------
function Controllable:process(listener,event)
  self.eventHandler:update(self,listener,event)
end

return Controllable
