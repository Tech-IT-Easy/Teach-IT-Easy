-----------------------------------------------------------
-- This class is for the event listener, usually a
-- context object will have a listener to transfer event to 
-- specific observers or add a chain listener.
--
-- @Author:Created by Chuck, Aug 16,2015
-- @Author:Updated by Chuck, Nov 11,2015 fit to new structure
-----------------------------------------------------------
local Object = require("toolkit.Object")

local EventListener = extends(Object)

-----------------------------------------------------------
-- Constructor method
-- @param context:Context (either PlatformContext or Game)
-- @return :EventListener new instance
-- @Author Chuck
-----------------------------------------------------------
function EventListener:new(context)
  local o = EventListener:super()
  
  -- Object which owns this listener
  o.context = context
  
  -- Objects which are registered in this listener
  o.observers = {}
  
  -- Chain listener which will be notified when this listener finishes updating
  o.chainListener = nil
  
  -- Hook for doing something before notifying
  -- self.beforeUpdateHook = nil
  return EventListener:init(o)
end


-----------------------------------------------------------
-- Add a chain listener to this listener. It will be notified
-- of every event this eventListener gets.
-- @param listener:EventListener
-- @Author Chuck
-----------------------------------------------------------
function EventListener:addChainListener(listener)
  self.chainListener = listener
end

-----------------------------------------------------------
-- Remove the chain listener from this listener
-- @Author Ludwig Wikblad
-----------------------------------------------------------
function EventListener:removeChainListener()
  self.chainListener = nil
end

-----------------------------------------------------------
-- Attach a object to this listener
-- @param object:Object which is being attached object
-----------------------------------------------------------
function EventListener:attach(object)
   table.insert(self.observers,object)
end

-----------------------------------------------------------
-- Remove an object from this listener.
-- @param object:Object which is being removed
-- @Author Ludwig Wikblad
-----------------------------------------------------------
function EventListener:remove(object)
  for _,obj in pairs(self.observers) do
    if obj == object then
      table.remove(self.observers, _)
    end
  end
end
-----------------------------------------------------------
-- Notify all the observers which has been attached to this listener
-- @param event:Event which is event currently happening
-- @Author Chuck
-----------------------------------------------------------
function EventListener:notifyAllObservers(event)
  for _,object in pairs(self.observers) do
    if object:interestInEvent(event) == true then
      object:process(self,event)
    end
  end
end

-----------------------------------------------------------
-- Some event trigger this listener in specific context 
-- @param context:PlatformContext;Game which specific context where event happens
-- @param event:Event which is event currently happening
-- @author Chuck
-----------------------------------------------------------
function EventListener:update(event)  
  -- do some thing before notify, such as change context content
  -- if beforeUpdateHook ~= nil then
    -- self.beforeUpdateHook:beforeListenerUpdate(context,event)  
  -- end
  
  -- notify all observers the events
  self:notifyAllObservers(event)
  
  -- notify chain listener which is usually a game listener
  if self.chainListener ~= nil then
    self.chainListener:update(event)
  end

end

return EventListener
