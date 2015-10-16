require('toolkit.EventListener')

Game = Object:new()

function Game:new()
  self.platformContext = nil
  self.gameEventListener = EventListener:new()
  return self
end

return Game