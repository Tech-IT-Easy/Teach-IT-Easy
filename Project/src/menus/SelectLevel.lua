--
-- Created by IntelliJ IDEA.
-- User: Marcus
-- Date: 2015-11-29
-- Time: 23:37
-- To change this template use File | Settings | File Templates.
--

local Super = require('toolkit.MenuSuperClass')
local SelectLevel = extends(Super)

local Profile = require('platform.Profile')

local Event = require('toolkit.Event')
local CreateProfile = require('menus.CreateProfile')
local GameFactory = require('games.GameFactory')



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
  if event.key == Event.KEY_RIGHT and self.pos < self.unlockedLevels then
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
    CreateProfile.profilename = ""
    return { "create" }
  end
  return {" "}
end

-------------------------------------
-- Loads the menu
-- @param input:String The username
-- @author Marcus
-------------------------------------
function SelectLevel:loadview(input)
  self.pos = 1
  self.lastpos = 1
  self.username = input

  self.unlockedLevels = self.context.profile.gameprogress:getProgress("games.Progg.ProggGame").level + 1
  self.image1 = gfx.loadpng('data/progg_game_icons/check.png')
  self.image1:premultiply()

  self:renderui(self.unlockedLevels)
end

-------------------------------------
-- Prints a button as active
-- @param x1 Position of button
-- @author Marcus
-------------------------------------
function SelectLevel:active(x1)
   if x1 < 5 then
  screen:clear({ g = 255, r = 255, b = 255 }, { x = screen:get_width() * 0.08 + (screen:get_width() * 0.22) * (x1 - 1), y = (screen:get_height() * 0.28), w = screen:get_height() * 0.25, h = screen:get_height() * 0.25 })
  screen:copyfrom(self.image1, nil, {x = screen:get_width() * 0.13 + (screen:get_width() * 0.22) * (x1 - 1), y = (screen:get_height() * 0.40), w = self.image1:get_width() * 0.1, h = self.image1:get_height() * 0.1})
  else
  screen:clear({ g = 255, r = 255, b = 255 }, { x = screen:get_width() * 0.08 + (screen:get_width() * 0.22) * (x1 - 5), y = (screen:get_height() * 0.65), w = screen:get_height() * 0.25, h = screen:get_height() * 0.25 })
   end
   level_fonts[x1]:draw_over_surface(screen, ""..x1)
  --screen:copyfrom(self.myimages[x1], nil, { x = (prof_sel_hspacing * x1) + prof_sel_itemwidth * (x1 - 1)*0.82 + screen:get_width() * 0.04, y = prof_sel_itemy - screen:get_height() * 0.035, w = self.image1:get_width() * 0.6, h = self.image1:get_height() * 0.6 }, true)

end

-------------------------------------
-- Prints an inactive button.
-- @param x1. Which position to print button at.
-- @author Marcus
-------------------------------------
function SelectLevel:inactive(x1)
  if x1 < 5 and x1  then
  screen:clear({ g = 228, r = 187, b = 235 }, { x = screen:get_width() * 0.08 + (screen:get_width() * 0.22) * (x1 - 1), y = (screen:get_height() * 0.28), w = screen:get_height() * 0.25, h = screen:get_height() * 0.25 })
  screen:copyfrom(self.image1, nil, {x = screen:get_width() * 0.13 + (screen:get_width() * 0.22) * (x1 - 1), y = (screen:get_height() * 0.40), w = self.image1:get_width() * 0.1, h = self.image1:get_height() * 0.1})
  else
  screen:clear({ g = 228, r = 187, b = 235 }, { x = screen:get_width() * 0.08 + (screen:get_width() * 0.22) * (x1 - 5), y = (screen:get_height() * 0.65), w = screen:get_height() * 0.25, h = screen:get_height() * 0.25 })
  end
  level_fonts[x1]:draw_over_surface(screen, ""..x1)
  --screen:copyfrom(self.myimages[x1], nil, { x = (prof_sel_hspacing * x1) + prof_sel_itemwidth * (x1 - 1)*0.82 + screen:get_width() * 0.04, y = prof_sel_itemy - screen:get_height() * 0.035, w = self.image1:get_width() * 0.6, h = self.image1:get_height() * 0.6 }, true)

end

-------------------------------------
-- Prints locked buttons. i.e the levels that are not unlocked yet.
-- @param x1. Which position to print button at.
-- @author Marcus
-------------------------------------
function SelectLevel:lockedlevels(x1)
  if x1 < 5 then
  screen:clear({ g = 131, r = 0, b = 143 }, { x = screen:get_width() * 0.08 + (screen:get_width() * 0.22) * (x1 - 1), y = (screen:get_height() * 0.28), w = screen:get_height() * 0.25, h = screen:get_height() * 0.25 })
  level_fonts[x1]:draw_over_surface(screen, ""..x1)
  else
  screen:clear({ g = 131, r = 0, b = 143 }, { x = screen:get_width() * 0.08 + (screen:get_width() * 0.22) * (x1 - 5), y = (screen:get_height() * 0.65), w = screen:get_height() * 0.25, h = screen:get_height() * 0.25 })
  end

  locked_levels[x1]:draw_over_surface(screen, ""..x1)
end

-------------------------------------
-- Loads initial screen of menu
-- @author Marcus
-------------------------------------
function SelectLevel:renderui(unlocked)
  create_prof_appname:draw_over_surface(screen, "TEACH IT EASY")
  create_prof_pagename:draw_over_surface(screen, "SELECT LEVEL")

  self:active(1)
  for i = 2, unlocked, 1 do
    self:inactive(i)
  end

  for i = unlocked + 1, 8, 1 do
    self:lockedlevels(i)
  end
end


return SelectLevel