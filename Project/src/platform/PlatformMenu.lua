-----------------------------------------------------------
-- This class is for the platform menu which is used
-- to show game choice menu and process some key events
--
-- @Author:Created by Chuck, Aug 16,2015
-- @Author:Updated by Tobias, Nov 02, 2015
-----------------------------------------------------------

local Object = require('toolkit.Object')
local EventHandler = require('toolkit.EventHandler')
local Event = require('toolkit.Event')
local Controllable = require('toolkit.Controllable')
local GameFactory = require('games.GameFactory')

local PlatformMenu = extends(Controllable)

--included classes for menu
local ProfileSelection = require('menus.ProfileSelection')
local MainMenu = require('menus.MainMenu')
local CreateProfile = require('menus.CreateProfile')
local Games = require('menus.Games')
skin = require('menus.skin')
local background = gfx.loadpng("data/background_h720.png")
local ChooseAvatar = require('menus.ChooseAvatar')

-----------------------------------------------------------
-- Construct method
-----------------------------------------------------------
function PlatformMenu:new()
  local o = PlatformMenu:super()
  self:loadviews()

  return PlatformMenu:init(o)
end

-----------------------------------------------------------
-- Loads the current view to the screen
-----------------------------------------------------------
function PlatformMenu:show()
  screen:copyfrom(background, nil, { x = 0, y = 0, w = screen:get_width(), h = screen:get_height() }, true)
  self.currentview:loadview()
end

function PlatformMenu:update()
  self.currentview:update()
end

-------------------------------------
-- Creates the menu-views un startup.
-- @author Erik/ Marcus
-------------------------------------
function PlatformMenu:loadviews()
  -- @member currentView:ProfileSelection
  self.currentview = ProfileSelection:new()
  self.views = {profilesel=ProfileSelection, main=MainMenu, create=CreateProfile, games=Games, chooseavatar=ChooseAvatar}
  collectgarbage()
end

-------------------------------------
-- Changes the current view and loads it.
-- @param newview. String that represents the new view.
-- @author Erik/ Marcus
-------------------------------------
function PlatformMenu:changeview(newview)
  -- @member currentView:MainMenu
  -- @member currentView:CreateProfile
  -- @member currentView:Games
  -- @member currentView:ChooseAvatar
  self.currentview = self.views[newview[1]]:new()
  screen:copyfrom(background, nil, { x = 0, y = 0, w = screen:get_width(), h = screen:get_height() }, true)
  self.currentview:loadview(newview[2])
  collectgarbage()
end

-----------------------------------------------------------
-- Menu event handler for some keyboard input, when creating
-- a handler, you need to do a few the steps as follow
-- @object which will be operated, usually it is
--          the class that contain this handler, here is menu
-- @event which is event currently happening
-----------------------------------------------------------

-- create a event delegate for menu
menuEventHandler = EventHandler:new()

-- register interesting events, listener will only notify these events
menuEventHandler.events = {[Event.KEY_UP] = Event.KEY_STATE_DOWN,[Event.KEY_DOWN] = Event.KEY_STATE_DOWN,[Event.KEY_RIGHT]=Event.KEY_STATE_DOWN,[Event.KEY_LEFT]=Event.KEY_STATE_DOWN,[Event.KEY_ONE]=Event.KEY_STATE_DOWN,[Event.KEY_TWO]=Event.KEY_STATE_DOWN}

-- override specific update method to response keyboard events,
function menuEventHandler:update(object,eventListener,event)
  print("platform menu event handler")

  -- if key == 'exit' then
  -- sys.stop()
  --end
  if event.state == Event.KEY_STATE_DOWN then
    local temp = object.currentview:handleinput(event)
    if temp[1] ~= " " then object:changeview(temp) end
    collectgarbage()
  end

end

-- Make handler useful to PlatformMenu
PlatformMenu.eventHandler = menuEventHandler

return PlatformMenu
