EventListener = Object:new()

function EventListener:new()
  self.context = nil
  self.observers = {}
  self.chainListener = nil
  self.beforeUpdateHook = nil
  return self
end


---------------------------------
-- add a chain listener to this listener
---------------------------------
function EventListener:addChainListener(listener)
  self.chainListener = listener
end
---------------------------------
--   object={event list}
--   @object: Object attach an object to game core with events
--   @events: Table event list
---------------------------------
function EventListener:attach(object)
   table.insert(self.observers,object)
end

---------------------------------
--   notify all the observers which has been attached to this listener
--   @events: Table event list
---------------------------------
function EventListener:notifyAllObservers(event)
  for _,object in pairs(self.observers) do
    if object:interestInEvent(event) == true then
      object:update(self,event)
    end
  end
end

-- hook to do something before udpate happens



---------------------------------
--   some event trigger this listener in specific context 
--   @context: specific context where event happens
--   @events: Table event list
---------------------------------
function EventListener:update(context,event)  
  self.context = context
  
  -- do some thing before notify, such as change context content
  if beforeUpdateHook ~= nil then
    self.beforeUpdateHook:beforeListenerUpdate(context,event)  
  end
  
  -- notify all observers the events
  self:notifyAllObservers(event)
  
  -- notify chain listener which is usually a game listener
  if self.chainListener ~= nil then
    self.chainListener:update(contex,event)
  end
  
  print("listener update")
end

