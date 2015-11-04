-----------------------------------------------------------
-- This class is for creating specific games based on profile
-- which is the name of the game. 
-- 
-- @Author:Created by Chuck, Aug 16,2015
-- @Author:Updated by author,date
-----------------------------------------------------------


local Object = require('toolkit.Object')
local GameFactory = extends(Object.class())

GameFactory.game = nil

-----------------------------------------------------------
-- Game create factory to create specific games based on profile
-- which is the name of the game. 
-- 
-- @profile name of the game
-- @context which is the platform context
-----------------------------------------------------------
function GameFactory:getGame(gameName,context)
  local mod = nil
  if gameName == "mario" then
    load = require("games.mario.Mario")
    
  elseif gameName == "Programming" then
    load = require("games.Progg.ProggGame")
  end
  --------------------
  -- add another game profile when extended
  --------------------
  
  self.game = load:new(context)
  return self.game
end

return GameFactory:new()