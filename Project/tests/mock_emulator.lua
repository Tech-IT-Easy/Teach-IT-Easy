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
--
-- Created by IntelliJ IDEA.
-- User: jonathan
-- Date: 2015-10-06
-- Time: 22:01
-- To change this template use File | Settings | File Templates.
--

package.loaded['Config.ADConfig'] = nil -- need to delete the package where the function is taken from.
package.preload['Config.ADConfig'] = function () -- Create preload. When the program wants to include love. This function will run instead
  local ADConfig = {} -- empty table. To make sure it looks the same as in the test program.
  ADConfig.isSimulator = true
  return ADConfig
end

local lemock = require 'lemock' -- needed to be able to make a mock
mec = lemock.controller() -- same here
local nil_returner = mec:mock() -- function you want imitate.
package.loaded['SDK.Utils.ADLogger'] = nil -- need to delete the package where the function is taken from.
package.preload['SDK.Utils.ADLogger'] = function () -- Create preload. When the program wants to include love. This function will run instead
  local ADLogger = {}
  ADLogger.trace = nil_returner
  ADLogger.debug = nil_returner
  ADLogger.warn = nil_returner
  ADLogger.error = nil_returner
  return ADLogger
end

local newImageData = mec:mock()
local newFileData = mec:mock()
local newCanvas = mec:mock()
local getColor = mec:mock()
local newImage = mec:mock()
local getTime = mec:mock()

package.loaded.love = nil -- need to delete the package where the function is taken from.
package.preload['love'] = function () -- Create preload. When the program wants to include love. This function will run instead
  local love = {} -- empty table. To make sure it looks the same as in the test program.
  local graphics = {}
  local image = {}
  local filesystem = {}
  local timer = {}
  local event = {}
  local keyboard = {}
  love.graphics = graphics
  love.image = image
  love.filesystem = filesystem
  love.timer = timer
  love.event = event
  love.keyboard = keyboard
  love.graphics.setNewFont = nil_returner
  love.image.newImageData = newImageData
  love.filesystem.newFileData = newFileData
  love.graphics.newCanvas = newCanvas
  love.graphics.print = nil_returner
  love.graphics.draw = nil_returner
  love.graphics.getColor = getColor
  love.graphics.setColor = nil_returner
  love.graphics.setCanvas = nil_returner
  love.graphics.newImage = newImage
  love.draw = nil_returner
  love.graphics.draw = nil_returner
  love.timer.getTime = getTime
  love.event.quit = nil_returner
  love.filesystem.getUserDirectory = nil_returner
  love.load = nil_returner
  love.run = nil_returner
  love.keyboard.setKeyRepeat = nil_returner
  love.graphics.setNewFont = nil_returner
  love.keypressed = nil_returner
  love.keyreleased = nil_returner
  return love
end

local data = mec:mock()
data:getHeight(mec.ANYARGS) ; mec:returns(50) :anytimes()
data:getWidth(mec.ANYARGS) ; mec:returns(50) :anytimes()
data:getDimensions(mec.ANYARGS) ; mec:returns(50, 50) :anytimes()
data:setPixel(mec.ANYARGS) ; mec:returns(nil) :anytimes()
data:getPixel(mec.ANYARGS) ; mec:returns(0,0,0,0) :anytimes()
local canvas_data = mec:mock()
canvas_data:getImageData(mec.ANYARGS) ; mec:returns(data) :anytimes()
newCanvas(mec.ANYARGS) ; mec:returns(canvas_data) :anytimes()
newImageData(mec.ANYARGS) ; mec:returns(data) :anytimes()
newFileData(mec.ANYARGS) ; mec:returns(data) :anytimes()
getColor(mec.ANYARGS) ; mec:returns(0,0,0,0) :anytimes()
newImage(mec.ANYARGS) ; mec:returns(data) :anytimes()
getTime(mec.ANYARGS) ; mec:returns(0.1) :anytimes()
nil_returner(mec.ANYARGS) ; mec:returns(nil) :anytimes()

local Network = mec:mock()
package.loaded['toolkit.Network'] = nil -- need to delete the package where the function is taken from.
package.preload['toolkit.Network'] = function () -- Create preload. When the program wants to include love. This function will run instead
    local toolkit = {}
    toolkit.Network = Network
    return Network
end

Network.new(Network) ; mec:returns(nil) :anytimes()
Network.getFirstname(Network,mec.ANYARGS) ; mec:returns("testname") :anytimes()
Network.getProgress(Network, mec.ANYARGS) ; mec:returns({level = 8, proggGameLoopLevel = true, proggGameProcLevel= true, proggGameIfLevel = true, proggGameMasterProc = false }) :anytimes()
Network.getLevels(Network, mec.ANYARGS) ; mec:returns(
    {
        {
            level = 1, maxCommands = {["queue"] = 8, ["loop"] = 16, ["P1"] = 0, ["P2"] = 0, ["if-wall"] = 0, ["if-not-wall"] = 0 }, mapData = "dfffffff5fffffff5fffffff5fffffff7fffffff", levelGoalPosition = 1, levelStartPosition = 33, objectives = {}
        },
        {
            level = 2, maxCommands = {["queue"] = 8, ["loop"] = 0, ["P1"] = 0, ["P2"] = 0, ["if-wall"] = 0, ["if-not-wall"] = 0 }, mapData = "ffffffffffffffff9aefffff5fffffff7fffffff", levelGoalPosition = 19, levelStartPosition = 33, objectives = {}
        },
        {
            level = 3, maxCommands = {["queue"] = 16, ["loop"] = 0, ["P1"] = 0, ["P2"] = 0, ["if-wall"] = 0, ["if-not-wall"] = 0 }, mapData = "fffffffffffffffff9efffff96ffffff7fffffff", levelGoalPosition = 19, levelStartPosition = 33, objectives = {26}
        },
        {
            level = 4, maxCommands = {["queue"] = 4, ["loop"] = 0, ["P1"] = 8, ["P2"] = 8, ["if-wall"] = 0, ["if-not-wall"] = 0 }, mapData = "9aefffff5fffffff5fffffff5fffffff7fffffff", levelGoalPosition = 3, levelStartPosition = 33, objectives = {}
        },
        {
            level = 5, maxCommands = {["queue"] = 16, ["loop"] = 16, ["P1"] = 16, ["P2"] = 16, ["if-wall"] = 16, ["if-not-wall"] = 16 }, mapData = "9aaaaacf59aaac5f55baa65f53aaaa6f7fffffff", levelGoalPosition = 19, levelStartPosition = 33, objectives = {}
        },
        {
            level = 6, maxCommands = {["queue"] = 16, ["loop"] = 16, ["P1"] = 16, ["P2"] = 16, ["if-wall"] = 16, ["if-not-wall"] = 16 }, mapData = "fffffffff9aa8acff5ff5f7ff7ff5fffffff7fff", levelGoalPosition = 26, levelStartPosition = 37, objectives = {23}
        },
        {
            level = 7, maxCommands = {["queue"] = 16, ["loop"] = 16, ["P1"] = 16, ["P2"] = 16, ["if-wall"] = 16, ["if-not-wall"] = 16 }, mapData = "fffd9acff9c55f5ff5555f5ff5322a6ff7ffffff", levelGoalPosition = 7, levelStartPosition = 34, objectives = {4,31}
        },
        {
            level = 8, maxCommands = {["queue"] = 16, ["loop"] = 16, ["P1"] = 16, ["P2"] = 16, ["if-wall"] = 16, ["if-not-wall"] = 16 }, mapData = "9ac9cf9c5f553a655f10ae945f559a653a632aa6", levelGoalPosition = 17, levelStartPosition = 35, objectives = {40,22,14}
        }

    }) :anytimes()

package.loaded['socket'] = nil -- need to delete the package where the function is taken from.
package.preload['socket'] = function () -- Create preload. When the program wants to include love. This function will run instead
  local Socket = {}
  return Socket
end

package.loaded['socket.http'] = nil -- need to delete the package where the function is taken from.
package.preload['socket.http'] = function () -- Create preload. When the program wants to include love. This function will run instead
  local Socket = {}
  return Socket
end

package.loaded['ltn12'] = nil -- need to delete the package where the function is taken from.
package.preload['ltn12'] = function () -- Create preload. When the program wants to include love. This function will run instead
  local Socket = {}
  return Socket
end

function new_freetype(fontColor, fontSize, drawingStartPoint, fontPath)
  local freetype = freetype(fontColor, fontSize, drawingStartPoint, fontPath)
  return freetype;
end

local sys_data = mec:mock()
local sys_return = mec:mock()
local return_time = mec:mock()
package.loaded['SDK.Simulator.sys'] = nil -- need to delete the package where the function is taken from.
package.preload['SDK.Simulator.sys'] = function () -- Create preload. When the program wants to include love. This function will run instead
  local sys = {}
  sys.new_timer = sys_data
  sys.time = return_time
  sys.stop = nil_returner
  sys.root_path = love.filesystem.getUserDirectory()
  sys.new_player = nil_returner
  sys.new_freetype = new_freetype
  return sys
end

sys_data(mec.ANYARGS) ; mec:returns(sys_return) :anytimes()
sys_return:stop(mec.ANYARGS); mec:returns(nil_returner) : anytimes()
return_time(mec.ANYARGS) ; mec:returns(1) :anytimes()

mec:replay() -- Tells "now we start testing the code"
_G.love = require "love"
_G.ADConfig = require("Config.ADConfig")
_G.ADLogger = require("SDK.Utils.ADLogger")
_G.gfx = require "SDK.Simulator.gfx"
_G.zto = require "SDK.Simulator.zto"
_G.surface = require "SDK.Simulator.surface"
_G.player = require "SDK.Simulator.player"
_G.freetype = require "SDK.Simulator.freetype"
_G.sys = require "SDK.Simulator.sys"
_G.script_path = ""
_G.screen = gfx.new_surface(1280,720)