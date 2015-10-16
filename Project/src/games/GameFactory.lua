

GameFactory = Object:new()

GameFactory.game = nil

function GameFactory:getGame(profile)

  if profile == "mario" then
    self.game = require("games.mario.Mario")
  elseif profile == "duck" then
    self.game = require("games.duck.Duck")
  end
  
  return self.game
end

return GameFactory