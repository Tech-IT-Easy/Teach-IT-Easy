Controllable = Object:new()

Controllable.eventHandler = nil

function Controllable:interestInEvent(event)
  return self.eventHandler.events[event] == 1 
end

function Controllable:update(listener,event)
  self.eventHandler:update(self,listener,event)
end

return Controllable
