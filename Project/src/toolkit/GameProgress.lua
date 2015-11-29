local Object = require('toolkit.Object')
local GameProgress = extends(Object)


-------------------------------------
-- Creates the Game Progress object.
-- @return GameProgress-object.
-- @author Daniel
-------------------------------------
function GameProgress:new(name)
    local o = GameProgress:super()
    o.progress = {}
    o.progress["games.Progg.ProggGame"] = {}
--    o.progress["games.Reading.ReadingGame"] = {}
    if name == "Knatte" then
        o.progress["games.Progg.ProggGame"] = {level = 1, proggGameLoopLevel = false, proggGameProcLevel= false, proggGameIfLevel = false }
    elseif name == "Fnatte" then
        o.progress["games.Progg.ProggGame"] = {level = 3, proggGameLoopLevel = true, proggGameProcLevel= false, proggGameIfLevel = false }
    elseif name == "Tjatte" then
        o.progress["games.Progg.ProggGame"] = {level = 5, proggGameLoopLevel = true, proggGameProcLevel= true, proggGameIfLevel = false }
    else
       o.progress["games.Progg.ProggGame"] = {level = 0, proggGameLoopLevel = false, proggGameProcLevel= false, proggGameIfLevel = false }
    end

    return GameProgress:init(o)
end


-------------------------------------
-- Creates the Game Progress object.
-- @param game. The game specific string
-- @return string. Either the progress of the game or N/A
-- @author Daniel
-------------------------------------
function GameProgress:getprogress(game)
    if game == nil then
        return "N/A"
    elseif self.progress[game] == nil then
--        print("Getting progress for game: "..game)
        return "N/A"
    else
--        print("Getting progress for game: "..game)
        return self.progress[game].level.."/5"
    end
end



return GameProgress