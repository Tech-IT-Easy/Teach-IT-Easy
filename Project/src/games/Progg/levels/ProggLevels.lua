--
-- Created by IntelliJ IDEA.
-- User: Trygg
-- Date: 2015-11-30
-- Time: 01:14
-- To change this template use File | Settings | File Templates.
--

local Object = require("toolkit.Object")
local ProggLevels = extends(Object)



function ProggLevels:new()
    local o = ProggLevels:super()
    return ProggLevels:init(o)
end




function ProggLevels:getProggLevels()
    local levels = {}
    local level1 = {level = 1, maxCommands = {["queue"] = 16, ["loop"] = 0, ["P1"] = 0, ["P2"] = 0, ["if-wall"] = 0, ["if-not-wall"] = 0 }, mapData = "dfffffff5fffffff5fffffff5fffffff7fffffff", levelGoalPosition = 1, levelStartPosition = 33, objectives = {} }
    local level2 = {level = 2, maxCommands = {["queue"] = 8, ["loop"] = 6, ["P1"] = 12, ["P2"] = 5, ["if-wall"] = 5, ["if-not-wall"] = 5 }, mapData = "ffffffffffffffff9aefffff5fffffff7fffffff", levelGoalPosition = 20, levelStartPosition = 33, objectives = {} }
    local level3 = {level = 3, maxCommands = {["queue"] = 16, ["loop"] = 16, ["P1"] = 16, ["P2"] = 16, ["if-wall"] = 16, ["if-not-wall"] = 16 }, mapData = "0000000000000000000000000000000000000000", levelGoalPosition = 20, levelStartPosition = 33, objectives = {} }
    local level4 = {level = 4, maxCommands = {["queue"] = 16, ["loop"] = 16, ["P1"] = 16, ["P2"] = 16, ["if-wall"] = 16, ["if-not-wall"] = 16 }, mapData = "0000000000000000000000000000000000000000", levelGoalPosition = 20, levelStartPosition = 33, objectives = {} }
    table.insert(levels, level1)
    table.insert(levels, level2)
    table.insert(levels, level3)
    table.insert(levels, level4)
    return levels
end

return ProggLevels