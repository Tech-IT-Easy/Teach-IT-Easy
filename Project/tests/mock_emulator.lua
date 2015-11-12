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