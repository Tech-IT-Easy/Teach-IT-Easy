-----------------------------------------------------------
-- This class is for the platform context which is used
-- to create menu and all the objects related to platform
-- and to control the screen showing of all objects or
-- update screen
-- Platform context is responsible for all the platform things
--
-- @Author:Created by Chuck, Aug 16,2015
-- @Author:Updated by author,date
-----------------------------------------------------------

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
end


local Object = require('toolkit.Object')
local EventListener = require('toolkit.EventListener')
local PlatformMenu = require('platform.PlatformMenu')
local Event = require('toolkit.Event')

local GameProgress =require('toolkit.GameProgress')


PlatformContext = extends(Object)

-----------------------------------------------------------
-- Constructor method
--@return :PlatformMenu a new instance of PlatformMenu
-- @author Chuck
-----------------------------------------------------------
function PlatformContext:new()
  local o = PlatformContext:super()
  -- Platform contains a game which will be allocated when profile selected
  o.game = nil

  o.proggGameLevels = self.getProggLevels()
  print("PROGGGAMELEVELS:")
  print(o.proggGameLevels[1].maxCommands.queue)

  -- Platform menu
  -- @member platformMenu:PlatformMenu
  o.platformMenu = PlatformMenu:new()

  -- Platform event listener
  -- @member platformEventListener:EventListener
  o.platformEventListener = EventListener:new(self)

  -- Attach menu object to listener
  o.platformEventListener:attach(o.platformMenu)

  -- @member profile:Profile
  o.profile = nil
  -- @member gameProgress:GameProgress
  o.gameprogress = GameProgress:new()

  --------------
  -- code
  --------------

  return PlatformContext:init(o)
end
------------------------------------
--Allows a game to create a new menu, since the
--old menu is discarded when game is created.
-- @author Ludwig Wikblad
------------------------------------
function PlatformContext:createNewMenu()
  if self.platformMenu == nil then
    self.platformMenu = PlatformMenu:new()
    self.platformEventListener:attach(self.platformMenu)
    self.platformMenu:show()
  end
end

-----------------------------------------------------------
-- Load resources,such as images to platform context
-- @author Chuck
-----------------------------------------------------------
function PlatformContext:load()

-- self.platformMenu:loadImage()
--------------
-- code
--------------
end

----------------------------------------------------------
-- Show something on the screen when starting
-- @author Chuck
----------------------------------------------------------
function PlatformContext:show()
  --------------
  -- code
  --------------
  self.platformMenu:show()

  gfx.update()
end



----------------------------------------------------------
-- Update the screen when something happens
-- @author Chuck
----------------------------------------------------------
function PlatformContext:update()
  if self.game ~= nil then
    self.game:update()
  end

  if self.platformMenu ~= nil then
    self.platformMenu:update()
  end
  -- code
  gfx.update()
  --collectgarbage()
end

----------------------------------------------------------
-- Accept event and inform its event listener
-- there is something happening, after which it update itself
-- @param key The key that was pressed
-- @param state the state of the key, i.e. up, down or repeat
-- @author Chuck
----------------------------------------------------------
function PlatformContext:process(key,state)
  ADLogger.trace("OnKey("..key..","..state..")")
  local event = Event:new(key,state)
  self.platformEventListener:update(event)
  if event.state == Event.KEY_STATE_DOWN then
    self:update()
  end
end


function PlatformContext:getProggLevels()
    local levels = {}
    local level1 = {level = 1, maxCommands = {["queue"] = 13, ["loop"] = 11, ["P1"] = 13, ["P2"] = 16, ["if-wall"] = 16, ["if-not-wall"] = 16 }, mapData = "9acfffff5f3cffff5ff7ffff5fffffff7fffffff", levelGoalPosition = 20, levelStartPosition = 33, objectives = { 17, 1 } }
    local level2 = {level = 2, maxCommands = {["queue"] = 8, ["loop"] = 6, ["P1"] = 12, ["P2"] = 5, ["if-wall"] = 5, ["if-not-wall"] = 5 }, mapData = "3acad6ff503cffff5ff7ffff5fbc6fff7fffffff", levelGoalPosition = 20, levelStartPosition = 33, objectives = {} }
    local level3 = {level = 3, maxCommands = {["queue"] = 16, ["loop"] = 16, ["P1"] = 16, ["P2"] = 16, ["if-wall"] = 16, ["if-not-wall"] = 16 }, mapData = "0000000000000000000000000000000000000000", levelGoalPosition = 20, levelStartPosition = 33, objectives = {} }
    local level4 = {level = 4, maxCommands = {["queue"] = 16, ["loop"] = 16, ["P1"] = 16, ["P2"] = 16, ["if-wall"] = 16, ["if-not-wall"] = 16 }, mapData = "0000000000000000000000000000000000000000", levelGoalPosition = 20, levelStartPosition = 33, objectives = {} }
    table.insert(levels, level1)
    table.insert(levels, level2)
    table.insert(levels, level3)
    table.insert(levels, level4)
    return levels
end

return PlatformContext
