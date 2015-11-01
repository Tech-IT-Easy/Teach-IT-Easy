ADConfig = require("Config.ADConfig")
ADLogger = require("SDK.Utils.ADLogger")
ADLogger.trace("Application Init")

if ADConfig.isSimulator then

  gfx = require "SDK.Simulator.gfx"
  zto = require "SDK.Simulator.zto"
  surface = require "SDK.Simulator.surface"
  player = require "SDK.Simulator.player"
  freetype = require "SDK.Simulator.freetype"
  sys = require "SDK.Simulator.sys"
  script_path = ""
else
  script_path = sys.root_path()
end

--included classes
local ProfileSelection = require('classes.ProfileSelection')
local MainMenu = require('classes.MainMenu')
local CreateProfile = require('classes.CreateProfile')
local Games = require('classes.Games')
skin = require('classes.skin')
local background = gfx.loadpng("data/background_h720.png")

-------------------------------------
-- Runs on startup.
-- @author Erik/ Marcus
-------------------------------------
function onStart()

  ADLogger.trace("onStart")
  if ADConfig.isSimulator then
    if arg[#arg] == "-debug" then require("mobdebug").start() end
  end

  loadviews()
  screen:copyfrom(background, nil, { x = 0, y = 0, w = screen:get_width(), h = screen:get_height() }, true)
  currentview:loadview()
  gfx.update()
end

-------------------------------------
-- Reacts to every button-click. Forwards click to the current view-object.
-- @param key, state. Represents button clicked.
-- @author Erik/ Marcus
-------------------------------------
function onKey(key, state)
  ADLogger.trace("OnKey(" .. key .. "," .. state .. ")")
  if state == 'down' then
    local temp = currentview:handleinput(key)
    if temp[1] ~= " " then changeview(temp) end
    gfx.update()
  end

end

-------------------------------------
-- Creates the menu-views un startup.
-- @author Erik/ Marcus
-------------------------------------
function loadviews()
  currentview = ProfileSelection:new()
  views = {profilesel=ProfileSelection, main=MainMenu, create=CreateProfile, games=Games}
end

-------------------------------------
-- Changes the current view and loads it.
-- @param newview. String that represents the new view.
-- @author Erik/ Marcus
-------------------------------------
function changeview(newview)
  currentview = views[newview[1]]:new()
  screen:copyfrom(background, nil, { x = 0, y = 0, w = screen:get_width(), h = screen:get_height() }, true)
  currentview:loadview(newview[2])
end

