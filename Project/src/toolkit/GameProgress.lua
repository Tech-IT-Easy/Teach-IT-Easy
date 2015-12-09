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
local Object = require('toolkit.Object')
local GameProgress = extends(Object)
local Network = require('toolkit.Network')


-------------------------------------
-- Creates the Game Progress object.
-- @return GameProgress-object.
-- @author Daniel; Alex
-------------------------------------
function GameProgress:new(name)
    local o = GameProgress:super()
    o.name = name
    o.progress = {}
    o.progress["games.Progg.ProggGame"] = {}
    o.progress["games.Catch.Catch"] = {}
    o.progress["games.Progg.ProggGame"] = Network:getProgress("games.Progg.ProggGame", name)
    o.progress["games.Catch.Catch"] = Network:getProgress("games.Catch.Catch", name)
    return GameProgress:init(o)
end


-------------------------------------
-- Gets the Game Progress object.
-- @param game. The game specific string
-- @return string. Either the progress of the game or N/A
-- @author Daniel
-------------------------------------
function GameProgress:getprogressStart(game)
    if game == nil then
        return "N/A"
    elseif self.progress[game] == nil then
--        print("Getting progress for game: "..game)
        return "N/A"
    else
--        print("Getting progress for game: "..game)
        if self.progress[game].level ~= nil then
            return self.progress[game].level.."/8"
        else
            return "N/A"
        end

    end
end

-------------------------------------
-- Gets the Game Progress object.
-- @param game. The game specific string
-- @return string. Either the progress of the game or N/A
-- @author Daniel
-------------------------------------
function GameProgress:getProgress(game)
    if game == nil then
        return "N/A"
    elseif self.progress[game] == nil then
--        print("Getting progress for game: "..game)
        return "N/A"
    else
--        print("Getting progress for game: "..game)
        return self.progress[game]
    end
end

-------------------------------------
-- Updates the Game Progress object.
-- @param game. The game specific string
-- @param progress. The new progress to be added for the current profile: {level = 1, proggGameLoopLevel = false, proggGameProcLevel= false, proggGameIfLevel = false }
-- @return string. Either the progress of the game or N/A
-- @author Trygg
-------------------------------------
function GameProgress:setProgress(game, progress)
    self.progress[game] = progress
    Network:pushProgress(game, self.name, progress)
end



return GameProgress