--Games = {} --MenuView:new()
-- Changed to extending empty super-menu
local Super = require('toolkit.MenuSuperClass')
local Games = extends(Super)
--local GameProgress = require('toolkit.GameProgress')
local Event = require('toolkit.Event')
local GameFactory = require('games.GameFactory')


-------------------------------------
-- Creates the Games menu.
-- @return self The created menu-object.
-- @author Erik
-------------------------------------
function Games:new()
  local o = Games:super()
  --@member gameFactory:GameFactory
  o.gameFactory = GameFactory:new()
  -- available games
  o.games = o.gameFactory.gameMatrix
  return Games:init(o)
end


-------------------------------------
-- Handles the button-click sent from main.
-- @param key. Represent which button was pressed.
-- @return string. Either " " as standard or a string representing view to be changed to.
-- @author Erik
-------------------------------------
function Games:handleinput(event)
  collectgarbage()
  self.lastpos = self.pos
  if event.key == Event.KEY_RIGHT and self.pos < #self.games then
     self.pos = self.pos + 1
  elseif event.key == Event.KEY_LEFT and self.pos > 1 then
    self.pos = self.pos - 1
  elseif event.key == Event.KEY_BACK then
    return { "main", self.usernamestring }
  elseif event.key == Event.KEY_OK and self.pos == 1 then
    return{"selectlevel"}
  elseif event.key == Event.KEY_OK then
    platformContext.game = self.gameFactory:getGame(self.games[self.pos][1],platformContext)
    if platformContext.game ~= nil then
      platformContext.game:start()
      platformContext.platformEventListener:remove(platformContext.platformMenu)
      platformContext.platformMenu = nil
    end
    collectgarbage()
  end
  return { " " }
end


function Games:update()
  self:buttoninactive(self.lastpos)
  self:buttonactive(self.pos)
end
-------------------------------------
-- Loads the view to the screen.
-- @author Erik
-------------------------------------
function Games:loadview(input)
  self.pos = 1
  self.lastpos = 1
  self.usernamestring = input

  self:renderui()
end

-------------------------------------
-- Prints content on screen.
-- @author Erik
-------------------------------------
function Games:renderui()

  games_appname:draw_over_surface(screen, "TEACH IT EASY")
  games_pagename:draw_over_surface(screen, "CHOOSE A GAME")
  games_username:draw_over_surface(screen, self.usernamestring)
  screen:clear({ g = 228, r = 187, b = 235 }, { x = screen:get_width() * 0.08, y = screen:get_height() * 0.09, w = screen:get_width() * 0.06, h = screen:get_height() * 0.1 })
  self:buttonactive(1)
  for i = 2, #self.games, 1 do
    self:buttoninactive(i)
  end
  screen:clear({ g = 0, r = 0, b = 0 }, { x = screen:get_width() * 0.8, y = screen:get_height() * 0.08, w = screen:get_width() * 0.05, h = screen:get_height() * 0.04 })
  screen:clear({ g = 230, r = 230, b = 230 }, { x = screen:get_width() * 0.803, y = screen:get_height() * 0.0845, w = screen:get_width() * 0.0455, h = screen:get_height() * 0.0308 })
  games_backbutton:draw_over_surface(screen, "BACK")
  games_backtext:draw_over_surface(screen, "Go back")
end

-------------------------------------
-- Prints an active gamebutton.
-- @param x. Which place to print button at.
-- @author Erik
-------------------------------------
function Games:buttonactive(x1)
  screen:clear({ g = 255, r = 255, b = 255 }, { x = screen:get_width() * 0.08 + (screen:get_width() * 0.22) * (x1 - 1), y = (screen:get_height() * 0.28), w = screen:get_width() * 0.18, h = screen:get_height() * 0.45 })

  games_gamesfonts[x1]:draw_over_surface(screen, self.games[x1][1])
  games_trophiesfonts[x1]:draw_over_surface(screen,"Progress: " .. platformContext.profile.gameprogress:getprogressStart(self.games[x1][2]))
end

-------------------------------------
-- Prints an inactive gamebutton.
-- @param x. Which place to print button at.
-- @author Erik
-------------------------------------
function Games:buttoninactive(x1)
  screen:clear({ g = 228, r = 187, b = 235 }, { x = screen:get_width() * 0.08 + (screen:get_width() * 0.22) * (x1 - 1), y = (screen:get_height() * 0.28), w = screen:get_width() * 0.18, h = screen:get_height() * 0.45 })

  games_gamesfonts[x1]:draw_over_surface(screen, self.games[x1][1])
  games_trophiesfonts[x1]:draw_over_surface(screen,"Progress: " .. platformContext.profile.gameprogress:getprogressStart(self.games[x1][2]))
end

return Games
