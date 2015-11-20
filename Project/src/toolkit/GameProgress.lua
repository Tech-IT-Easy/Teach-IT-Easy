local Object = require('toolkit.Object')
local GameProgress = extends(Object)


-------------------------------------
-- Creates the Game Progress object.
-- @return GameProgress-object.
-- @author Daniel
-------------------------------------
function GameProgress:new()
    local o = GameProgress:super()
    o.progress = {}
    o.progress["games.Progg.ProggGame"] = "11/13"
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
        print("Getting progress for game: "..game)
        return "N/A"
    else
        print("Getting progress for game: "..game)
        return self.progress[game]
    end
end



return GameProgress