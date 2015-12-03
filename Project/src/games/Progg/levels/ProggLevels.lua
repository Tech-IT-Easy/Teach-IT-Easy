--
-- Created by IntelliJ IDEA.
-- User: Trygg
-- Date: 2015-11-30
-- Time: 01:14
-- To change this template use File | Settings | File Templates.
--

local Object = require("toolkit.Object")
local ProggLevels = extends(Object)
local Network = require("toolkit.Network")



function ProggLevels:new()
    local o = ProggLevels:super()
    o.maxLevel = 8
    return ProggLevels:init(o)
end




function ProggLevels:getProggLevels()
    local levels = Network:getLevels("games.Progg.ProggGame") or {
        {
            level = 1, maxCommands = {["queue"] = 8, ["loop"] = 0, ["P1"] = 0, ["P2"] = 0, ["if-wall"] = 0, ["if-not-wall"] = 0 }, mapData = "dfffffff5fffffff5fffffff5fffffff7fffffff", levelGoalPosition = 1, levelStartPosition = 33, objectives = {}
        },
        {
            level = 2, maxCommands = {["queue"] = 8, ["loop"] = 0, ["P1"] = 0, ["P2"] = 0, ["if-wall"] = 0, ["if-not-wall"] = 0 }, mapData = "ffffffffffffffff9aefffff5fffffff7fffffff", levelGoalPosition = 19, levelStartPosition = 33, objectives = {}
        },
        {
            level = 3, maxCommands = {["queue"] = 16, ["loop"] = 0, ["P1"] = 0, ["P2"] = 0, ["if-wall"] = 0, ["if-not-wall"] = 0 }, mapData = "fffffffffffffffff9efffff96ffffff7fffffff", levelGoalPosition = 19, levelStartPosition = 33, objectives = {26}
        },
        {
            level = 4, maxCommands = {["queue"] = 16, ["loop"] = 16, ["P1"] = 16, ["P2"] = 16, ["if-wall"] = 16, ["if-not-wall"] = 16 }, mapData = "9aefffff5fffffff5fffffff5fffffff7fffffff", levelGoalPosition = 3, levelStartPosition = 33, objectives = {}
        },
        {
            level = 5, maxCommands = {["queue"] = 16, ["loop"] = 16, ["P1"] = 16, ["P2"] = 16, ["if-wall"] = 16, ["if-not-wall"] = 16 }, mapData = "9aaaaacf59aaac5f55baa65f53aaaa6f7fffffff", levelGoalPosition = 19, levelStartPosition = 33, objectives = {}
        },
        {
            level = 6, maxCommands = {["queue"] = 3, ["loop"] = 16, ["P1"] = 5, ["P2"] = 5, ["if-wall"] = 16, ["if-not-wall"] = 16 }, mapData = "9aaacfff5fff5fff5fff5fff5fff5fff7fff7fff", levelGoalPosition = 37, levelStartPosition = 33, objectives = {}
        },
        {
            level = 7, maxCommands = {["queue"] = 16, ["loop"] = 16, ["P1"] = 16, ["P2"] = 16, ["if-wall"] = 16, ["if-not-wall"] = 16 }, mapData = "9aefffff5fffffff5fffffff5fffffff7fffffff", levelGoalPosition = 3, levelStartPosition = 33, objectives = {}
        },
        {
            level = 8, maxCommands = {["queue"] = 16, ["loop"] = 16, ["P1"] = 16, ["P2"] = 16, ["if-wall"] = 16, ["if-not-wall"] = 16 }, mapData = "9aefffff5fffffff5fffffff5fffffff7fffffff", levelGoalPosition = 3, levelStartPosition = 33, objectives = {}
        }

    }
    return levels
end

return ProggLevels