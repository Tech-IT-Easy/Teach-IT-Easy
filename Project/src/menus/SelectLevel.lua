------------------------------
-- Menu class that represents the
-- select level menu.
-- @author Marcus Fridén
------------------------------

local Super = require('toolkit.MenuSuperClass')
local SelectLevel = extends(Super)

local Profile = require('platform.Profile')

local Event = require('toolkit.Event')
local CreateProfile = require('menus.CreateProfile')
local GameFactory = require('games.GameFactory')

local LOCALE = require('i18n.main')



-------------------------------------
-- Creates a new menu
-- @return self:SelectLevel The created menu
-- @author Marcus
-------------------------------------
function SelectLevel:new()
  local o = SelectLevel:super()
    --@member gameFactory:GameFactory
  o.gameFactory = GameFactory:new()
  o.context = PlatformContext
  -- available games
  o.games = o.gameFactory.gameMatrix
  return SelectLevel:init(o)
end

-------------------------------------
-- Update menu when navigated in
-- @author Marcus
-------------------------------------
function SelectLevel:update()
    self:inactive(self.lastpos)
    self:active(self.pos)
end

-------------------------------------
-- Handles the input from the user
-- @param event The key pressed by the user
-- @return menu:String to navigate to or empty string
-- @author Marcus
-------------------------------------
function SelectLevel:handleinput(event)
  collectgarbage()
  self.lastpos = self.pos
  if event.key == Event.KEY_RIGHT and self.pos < self.unlockedLevels and self.pos ~= 8 then
    self.pos = self.pos + 1
  elseif event.key == Event.KEY_LEFT and self.pos > 1 then
    self.pos = self.pos - 1
    elseif event.key == Event.KEY_DOWN and (self.pos < 5 and self.unlockedLevels >= self.pos +4) then
    self.pos = self.pos + 4
    elseif event.key == Event.KEY_UP and self.pos > 4 then
    self.pos = self.pos - 4
  elseif (event.key == Event.KEY_OK) then

    platformContext.game = self.gameFactory:getGame('Programming',platformContext, self.pos)
      platformContext.game:start()
      platformContext.platformEventListener:remove(platformContext.platformMenu)
      platformContext.platformMenu = nil

    collectgarbage()
  elseif (event.key == Event.KEY_BACK) then
    return { "games"}
  end
  return {" "}
end

-------------------------------------
-- Loads the menu
-- @param input:String The username
-- @author Marcus
-------------------------------------
function SelectLevel:loadview()
  self.pos = 1
  self.lastpos = 1
  self.username = platformContext.profile.name

  self.unlockedLevels = self.context.profile.gameprogress:getProgress("games.Progg.ProggGame").level + 1

  self.checkImage = gfx.loadpng('data/check.png')
  self.checkImage:premultiply()
  self.lockImage = gfx.loadpng('data/lock.png')
  self.lockImage:premultiply()

  self:renderui(self.unlockedLevels)
end

-------------------------------------
-- Prints a button as active
-- @param x1 Position of button
-- @author Marcus
-------------------------------------
function SelectLevel:active(x1)

  if x1 < 5 and x1 < self.unlockedLevels then
  screen:clear({ g = 131, r = 0, b = 143 }, { x = screen:get_width() * 0.08 + (screen:get_width() * 0.23) * (x1 - 1), y = (screen:get_height() * 0.28), w = screen:get_height() * 0.25, h = screen:get_height() * 0.25 })
  screen:clear({ g = 255, r = 255, b = 255 }, { x = (screen:get_width() * 0.08 + (screen:get_width() * 0.23) * (x1 - 1)) + 4, y = (screen:get_height() * 0.28) + 4, w = screen:get_height() * 0.24, h = screen:get_height() * 0.24 })
  screen:copyfrom(self.checkImage, nil, {x = (screen:get_width() * 0.13 + (screen:get_width() * 0.23) * (x1 - 1)) + 48, y = (screen:get_height() * 0.44), w = self.checkImage:get_width() * 0.05, h = self.checkImage:get_width() * 0.05})
  level_fonts[x1]:draw_over_surface(screen, ""..x1)
  elseif x1 < 5 and x1 == self.unlockedLevels then
    screen:clear({ g = 131, r = 0, b = 143 }, { x = screen:get_width() * 0.08 + (screen:get_width() * 0.23) * (x1 - 1), y = (screen:get_height() * 0.28), w = screen:get_height() * 0.25, h = screen:get_height() * 0.25 })
    screen:clear({ g = 255, r = 255, b = 255 }, { x = (screen:get_width() * 0.08 + (screen:get_width() * 0.23) * (x1 - 1)) + 4, y = (screen:get_height() * 0.28) + 4, w = screen:get_height() * 0.24, h = screen:get_height() * 0.24 })
  level_fonts[x1]:draw_over_surface(screen, ""..x1)
  end

  if (x1 > 4 and x1 < 9) and x1 < self.unlockedLevels then
  screen:clear({ g = 131, r = 0, b = 143 }, { x = screen:get_width() * 0.08 + (screen:get_width() * 0.23) * (x1 - 5), y = (screen:get_height() * 0.65), w = screen:get_height() * 0.25, h = screen:get_height() * 0.25 })
  screen:clear({ g = 255, r = 255, b = 255 }, { x = screen:get_width() * 0.08 + (screen:get_width() * 0.23) * (x1 - 5) + 4, y = (screen:get_height() * 0.65) + 4, w = screen:get_height() * 0.24, h = screen:get_height() * 0.24 })
  screen:copyfrom(self.checkImage, nil, {x = (screen:get_width() * 0.13 + (screen:get_width() * 0.23) * (x1 - 5)) + 48, y = (screen:get_height() * 0.81), w = self.checkImage:get_width() * 0.05, h = self.checkImage:get_width() * 0.05})
  level_fonts[x1]:draw_over_surface(screen, ""..x1)
  elseif (x1 > 4 and x1 < 9) and x1 == self.unlockedLevels then
    screen:clear({ g = 131, r = 0, b = 143 }, { x = screen:get_width() * 0.08 + (screen:get_width() * 0.23) * (x1 - 5), y = (screen:get_height() * 0.65), w = screen:get_height() * 0.25, h = screen:get_height() * 0.25 })
    screen:clear({ g = 255, r = 255, b = 255 }, { x = screen:get_width() * 0.08 + (screen:get_width() * 0.23) * (x1 - 5) + 4, y = (screen:get_height() * 0.65) + 4, w = screen:get_height() * 0.24, h = screen:get_height() * 0.24 })
  level_fonts[x1]:draw_over_surface(screen, ""..x1)
  end


end

-------------------------------------
-- Prints an inactive button.
-- @param x1. Which position to print button at.
-- @author Marcus
-------------------------------------
function SelectLevel:inactive(x1)
  if x1 < 5 and x1 < self.unlockedLevels then
  screen:clear({ g = 228, r = 187, b = 235 }, { x = screen:get_width() * 0.08 + (screen:get_width() * 0.23) * (x1 - 1), y = (screen:get_height() * 0.28), w = screen:get_height() * 0.25, h = screen:get_height() * 0.25 })
  screen:copyfrom(self.checkImage, nil, {x = (screen:get_width() * 0.13 + (screen:get_width() * 0.23) * (x1 - 1)) + 48, y = (screen:get_height() * 0.44), w = self.checkImage:get_width() * 0.05, h = self.checkImage:get_width() * 0.05})
  level_fonts[x1]:draw_over_surface(screen, ""..x1)
  elseif x1 < 5 and x1 == self.unlockedLevels then
    screen:clear({ g = 228, r = 187, b = 235 }, { x = screen:get_width() * 0.08 + (screen:get_width() * 0.23) * (x1 - 1), y = (screen:get_height() * 0.28), w = screen:get_height() * 0.25, h = screen:get_height() * 0.25 })
    level_fonts[x1]:draw_over_surface(screen, ""..x1)
  end

  if (x1 > 4 and x1 < 9) and x1 < self.unlockedLevels then
  screen:clear({ g = 228, r = 187, b = 235 }, { x = screen:get_width() * 0.08 + (screen:get_width() * 0.23) * (x1 - 5), y = (screen:get_height() * 0.65), w = screen:get_height() * 0.25, h = screen:get_height() * 0.25 })
  screen:copyfrom(self.checkImage, nil, {x = (screen:get_width() * 0.13 + (screen:get_width() * 0.23) * (x1 - 5)) + 48, y = (screen:get_height() * 0.81), w = self.checkImage:get_width() * 0.05, h = self.checkImage:get_width() * 0.05})
  level_fonts[x1]:draw_over_surface(screen, ""..x1)
  elseif (x1 > 4 and x1 < 9) and x1 == self.unlockedLevels then
    screen:clear({ g = 228, r = 187, b = 235 }, { x = screen:get_width() * 0.08 + (screen:get_width() * 0.23) * (x1 - 5), y = (screen:get_height() * 0.65), w = screen:get_height() * 0.25, h = screen:get_height() * 0.25 })
  level_fonts[x1]:draw_over_surface(screen, ""..x1)
  end



end

-------------------------------------
-- Prints locked buttons. i.e the levels that are not unlocked yet.
-- @param x1. Which position to print button at.
-- @author Marcus
-------------------------------------
function SelectLevel:lockedlevels(x1)
  if x1 < 5 then
    screen:clear({ g = 131, r = 0, b = 143 }, { x = screen:get_width() * 0.08 + (screen:get_width() * 0.23) * (x1 - 1), y = (screen:get_height() * 0.28), w = screen:get_height() * 0.25, h = screen:get_height() * 0.25 })
    screen:copyfrom(self.lockImage, nil, {x = (screen:get_width() * 0.13 + (screen:get_width() * 0.23) * (x1 - 1)) + 50, y = (screen:get_height() * 0.43), w = self.lockImage:get_width() * 0.1, h = self.lockImage:get_height() * 0.1})

  else
  screen:clear({ g = 131, r = 0, b = 143 }, { x = screen:get_width() * 0.08 + (screen:get_width() * 0.23) * (x1 - 5), y = (screen:get_height() * 0.65), w = screen:get_height() * 0.25, h = screen:get_height() * 0.25 })
  screen:copyfrom(self.lockImage, nil, {x = (screen:get_width() * 0.13 + (screen:get_width() * 0.23) * (x1 - 5)) + 50, y = (screen:get_height() * 0.80), w = self.lockImage:get_width() * 0.1, h = self.lockImage:get_height() * 0.1})
  end

  locked_levels[x1]:draw_over_surface(screen, ""..x1)
end

-------------------------------------
-- Loads initial screen of menu
-- @author Marcus
-------------------------------------
function SelectLevel:renderui(unlocked)
  select_level_appname:draw_over_surface(screen, LOCALE.APP_NAME)
  select_level_pagename:draw_over_surface(screen, LOCALE.LEVEL_SELECT)

  self:active(1)
  for i = 2, unlocked, 1 do
    self:inactive(i)
  end

  for i = unlocked + 1, 8, 1 do
    self:lockedlevels(i)
  end
end


return SelectLevel