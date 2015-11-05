Games = {} --MenuView:new()

local Event = require('toolkit.Event')
--added to test game
local GameFactory = require('games.GameFactory')

-------------------------------------
-- Creates the Games menu.
-- @return games_ The created menu-object.
-- @author Erik
-------------------------------------
function Games:new()

  -- available games
  self.games = { { "Programming", "5/12" }, { "Other game", "1/12" }, { "Test game", "12/12" }, { "Pony game", "100/100" } }
  return self
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
  elseif event.key == Event.KEY_TWO then
    return { "main", self.usernamestring }
  elseif event.key == Event.KEY_ONE then
----------------------------------------------------
--  Launches game and discards the menu to save space
----------------------------------------------------
   -- proggImage = gfx.loadpng('data/ProgrammingGamePic_405.png')
    --screen:copyfrom(proggImage, nil, { x = 0, y = 0, w = screen:get_width(), h = screen:get_height() }, true)
    --proggImage:destroy()
    PlatformContext.game = GameFactory:getGame(self.games[self.pos][1],PlatformContext)
    PlatformContext.game:start()
    PlatformContext.platformEventListener:remove(platformContext.platformMenu)
    PlatformContext.platformMenu = nil
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
  --self:printbackground()

  self:renderui()
end

-------------------------------------
-- Prints background on screen.
-- @author Erik
-------------------------------------
function Games:printbackground()
  self.background = gfx.loadpng("data/background_h720.png")
  screen:copyfrom(games_background, nil, { x = 0, y = 0, w = screen:get_width(), h = screen:get_height() }, true)
  self.background:destroy()
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
  games_trophiesfonts[x1]:draw_over_surface(screen,"Trophies: " .. self.games[x1][2])
end

-------------------------------------
-- Prints an inactive gamebutton.
-- @param x. Which place to print button at.
-- @author Erik
-------------------------------------
function Games:buttoninactive(x1)
  screen:clear({ g = 228, r = 187, b = 235 }, { x = screen:get_width() * 0.08 + (screen:get_width() * 0.22) * (x1 - 1), y = (screen:get_height() * 0.28), w = screen:get_width() * 0.18, h = screen:get_height() * 0.45 })

  games_gamesfonts[x1]:draw_over_surface(screen, self.games[x1][1])
  games_trophiesfonts[x1]:draw_over_surface(screen,"Trophies: " .. self.games[x1][2])
end

return Games
