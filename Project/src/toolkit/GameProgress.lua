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