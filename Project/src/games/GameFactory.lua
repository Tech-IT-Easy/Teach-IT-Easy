-----------------------------------------------------------
-- This class is for creating specific games based on profile
-- which is the name of the game. 
-- 
-- @Author:Created by Chuck, Aug 16,2015
-- @Author:Updated by author,date
-----------------------------------------------------------


local Object = require('toolkit.Object')
local GameFactory = extends(Object)

GameFactory.game = nil

GameFactory.gameMatrix = {}
GameFactory.gameMatrix[1] = {"mario", "games.mario.Mario"}
GameFactory.gameMatrix[2] = {"Programming", "games.Progg.ProggGame"}

-----------------------------------------------------------
-- Game create factory to create specific games based on profile
-- which is the name of the game. 
--
-- @param gameName:string String representative of the game
-- @param context:PlatformContext
-- @return a Game or nil
-- @author Daniel
-----------------------------------------------------------
function GameFactory:getGame(gameName,context)
  for i = 1, #self.gameMatrix, 1 do
    if gameName == self.gameMatrix[i][1] then
      print("Selected game: " .. self.gameMatrix[i][1] .. " importing: " .. self.gameMatrix[i][2])
      local load = require(self.gameMatrix[i][2])
      self.game = load:new(context)
      return self.game
    end
  end

  print("WARNING: Unknown game started...")

  return nil
end

return GameFactory:new()