-----------------------------------------------------------
-- This class is for the event listener, usually a
-- context object will have a listener to transfer event to 
-- specific observers or add a chain listener.
--
-- @Author:Created by Chuck, Aug 16,2015
-- @Author:Updated by author,date
-----------------------------------------------------------
local Object = require("toolkit.Object")

local EventListener = extends(Object.class())

-----------------------------------------------------------
-- Construct method
-----------------------------------------------------------
function EventListener:new(context)
  -- Object which owns this listener
  newObject = {}
  newObject.context = context
  -- Objects which are registed in this listener
  newObject.observers = {}
  
  -- Chain listener which will be notified when this listener finishes updating
  newObject.chainListener = nil
  
  self.__index = self
  -- Hook for doing something before notifying
  -- self.beforeUpdateHook = nil
  return setmetatable(newObject,self)--self.class()
end


-----------------------------------------------------------
-- Add a chain listener to this listener
-----------------------------------------------------------
function EventListener:addChainListener(listener)
  self.chainListener = listener
end

-----------------------------------------------------------
-- Attach a object to this listener
-- @object which is being attached object
-----------------------------------------------------------
function EventListener:attach(object)
   table.insert(self.observers,object)
end

-----------------------------------------------------------
-- Notify all the observers which has been attached to this listener
-- @events which is event currently happening
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
-- @context which specific context where event happens
-- @events which is event currently happening
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
