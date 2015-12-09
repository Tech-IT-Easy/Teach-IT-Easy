--[[TEACH IT EASY, an educational games platform
    Copyright (C) 2015  Linköping University

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.


    MIT LICENSE:
    Copyright (c) 2015 Zenterio AB

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:



    The above copyright notice and this permission notice shall be included in
    all copies or substantial portions of the Software.


    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
    THE SOFTWARE.


    ]]
-----------------------------------------------------------
-- This class is for creating specific games based on
-- the name of the game.
-- 
-- @Author:Created by Chuck, Aug 16,2015
-- @Author:Updated by author,date
-----------------------------------------------------------


local Object = require('toolkit.Object')
local GameFactory = extends(Object)

--------------------------------------
-- Constructor method
-- @return :GameFactory a new instance of a GameFactory
-- @author Ludwig Wikblad
--------------------------------------
function GameFactory:new()
  local o = GameFactory:super()
  o.game = nil
  o.gameMatrix = {}
  o.gameMatrix[1] = {"Programming", "games.Progg.ProggGame" }
  o.gameMatrix[2] = {"Reading", "games.Catch.Catch" }
--  o.gameMatrix[3] = {"Test game", nil }
--  o.gameMatrix[4] = {"Pony game", nil }
  --o.gameMatrix[4] = {"Mario", "games.mario.Mario" }
  return GameFactory:init(o)
end

-----------------------------------------------------------
-- Game create factory to create specific games based on profile
-- which is the name of the game. 
--
-- @param gameName:string String representative of the game
-- @param context:PlatformContext
-- @return a Game or nil
-- @author Daniel
-----------------------------------------------------------
function GameFactory:getGame(gameName,context, level)
  for i = 1, #self.gameMatrix, 1 do
    if gameName == self.gameMatrix[i][1] and self.gameMatrix[i][2] ~= nil then
      print("Selected game: " .. self.gameMatrix[i][1] .. " importing: " .. self.gameMatrix[i][2])
      local load = require(self.gameMatrix[i][2])
      self.game = load:new(context, level)
      return self.game
    end
  end

  print("WARNING: Unknown game started...")

  return nil
end

return GameFactory