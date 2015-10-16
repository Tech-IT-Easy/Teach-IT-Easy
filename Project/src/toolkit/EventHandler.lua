
EventHandler = Object:new()

EventHandler.events = {}


---------------------------------
--   Delegate for object when some event happens
--   @object:Object delegated object
--   @event:Event specific event
--   @eventListener:eventListener it's for future developing but now it's not used
---------------------------------

function EventHandler:update(object,eventListener,event)

end

return EventHandler