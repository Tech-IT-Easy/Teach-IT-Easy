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
function GameFactory:getGame(profile,context)
  local mod = nil
  if profile == "mario" then
    load = require("games.mario.Mario")
    
  elseif profile == "duck" then
    load = require("games.duck.Duck")
  elseif profile == "progg" then
    load = require("games.Progg.ProggGame")
  end
  --------------------
  -- add another game profile when extended
  --------------------
  
  self.game = load:new(context)
  return self.game
end

return GameFactory:new()