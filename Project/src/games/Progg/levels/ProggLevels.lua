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
------------------------------
-- This class contains the different
-- levels of the programming game.
-- @author: Alexander Trygg
------------------------------

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
            level = 3, maxCommands = {["queue"] = 8, ["loop"] = 0, ["P1"] = 0, ["P2"] = 0, ["if-wall"] = 0, ["if-not-wall"] = 0 }, mapData = "fffffffffffffffff9efffff96ffffff7fffffff", levelGoalPosition = 19, levelStartPosition = 33, objectives = {26}
        },
        {
            level = 4, maxCommands = {["queue"] = 4, ["loop"] = 0, ["P1"] = 4, ["P2"] = 4, ["if-wall"] = 0, ["if-not-wall"] = 0 }, mapData = "9aefffff5fffffff5fffffff5fffffff7fffffff", levelGoalPosition = 3, levelStartPosition = 33, objectives = {}
        },
        {
            level = 5, maxCommands = {["queue"] = 16, ["loop"] = 16, ["P1"] = 16, ["P2"] = 16, ["if-wall"] = 1, ["if-not-wall"] = 1 }, mapData = "9aaaaacf59aaac5f55baa65f53aaaa6f7fffffff", levelGoalPosition = 19, levelStartPosition = 33, objectives = {}
        },
        {
            level = 6, maxCommands = {["queue"] = 8, ["loop"] = 16, ["P1"] = 16, ["P2"] = 16, ["if-wall"] = 1, ["if-not-wall"] = 1 }, mapData = "fffffffff9aa8acff5ff5f7ff7ff5fffffff7fff", levelGoalPosition = 26, levelStartPosition = 37, objectives = {23}
        },
        {
            level = 7, maxCommands = {["queue"] = 16, ["loop"] = 16, ["P1"] = 16, ["P2"] = 16, ["if-wall"] = 1, ["if-not-wall"] = 1 }, mapData = "fffd9acff9c55f5ff5555f5ff5322a6ff7ffffff", levelGoalPosition = 7, levelStartPosition = 34, objectives = {4,31}
        },
        {
            level = 8, maxCommands = {["queue"] = 16, ["loop"] = 16, ["P1"] = 16, ["P2"] = 16, ["if-wall"] = 1, ["if-not-wall"] = 1 }, mapData = "9ac9cf9c5f553a655f10ae945f559a653a632aa6", levelGoalPosition = 17, levelStartPosition = 35, objectives = {40,22,14}
        }

    }
    return levels
end

return ProggLevels