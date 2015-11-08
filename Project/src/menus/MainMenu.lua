MainMenu = {} --MenuView:new()

local Event = require('toolkit.Event')
-------------------------------------
-- Creates the Main menu.
-- @return self. The created menu-object.
-- @author Erik
-------------------------------------
function MainMenu:new()

    self.sidebuttonfonts = { main_menu_sidebuttontext1, main_menu_sidebuttontext2, main_menu_sidebuttontext3 }
    return self
end

-------------------------------------
-- Handles the button-click sent from main.
-- @param key. Represent which button was pressed.
-- @return string. Either " " as standard or a string representing view to be changed to.
-- @author Erik
-------------------------------------
function MainMenu:handleinput(event)

  collectgarbage()
  self.lastpos = self.pos
  if event.key == Event.KEY_RIGHT and self.pos == 0 then
    self.pos = 1
  elseif event.key == Event.KEY_DOWN and self.pos > 0 and self.pos < 3 then
    self.pos = self.pos + 1
  elseif event.key == Event.KEY_UP and self.pos > 1 and self.pos < 4 then
    self.pos = self.pos - 1
  elseif event.key == Event.KEY_LEFT and self.pos > 0 and self.pos < 4 then
    self.pos = 0
  elseif event.key == Event.KEY_ONE and self.pos == 0 then
    return { "games", self.usernamestring }

  elseif event.key == Event.KEY_TWO then
    return { "profilesel" }
  end

  return { " " }
end


function MainMenu:update()
    if self.lastpos == 0 then
        self:gamebuttoninactive()
    else
        self:sidebuttoninactive(self.lastpos)
    end
    if self.pos == 0 then
        self:gamebuttonactive()
    else
        self:sidebuttonactive(self.pos)
    end
end


-------------------------------------
-- Loads the view to the screen.
-- @author Erik
-------------------------------------
function MainMenu:loadview(input)
  self.pos = 0
  self.lastpos = self.pos
  self.sidebuttons = { "Trophy room", "Wardrobe", "Settings" }
  self.usernamestring = input
  --self:printbackground()
  self:renderui()
end

-------------------------------------
-- Prints background on screen.
-- @author Erik
-------------------------------------
function MainMenu:printbackground()
  self.background = gfx.loadpng("data/background_h720.png")
  screen:copyfrom(self.background, nil, { x = 0, y = 0, w = screen:get_width(), h = screen:get_height() }, true)
  self.background:destroy()
end


-------------------------------------
-- Prints content on screen.
-- @author Erik
-------------------------------------
function MainMenu:renderui()

  main_menu_appname:draw_over_surface(screen, "TEACH IT EASY")
  main_menu_pagename:draw_over_surface(screen, "MAIN MENU")
  main_menu_username:draw_over_surface(screen, self.usernamestring)
  screen:clear({ g = 228, r = 187, b = 235 }, { x = screen:get_width() * 0.08, y = screen:get_height() * 0.09, w = screen:get_width() * 0.06, h = screen:get_height() * 0.1 })
  self:gamebuttonactive()
  for i = 1, 3, 1 do
    self:sidebuttoninactive(i)
  end
  screen:clear({ g = 0, r = 0, b = 0 }, { x = screen:get_width() * 0.8, y = screen:get_height() * 0.08, w = screen:get_width() * 0.05, h = screen:get_height() * 0.04 })
  screen:clear({ g = 230, r = 230, b = 230 }, { x = screen:get_width() * 0.803, y = screen:get_height() * 0.0845, w = screen:get_width() * 0.0455, h = screen:get_height() * 0.0308 })
  main_menu_backbutton:draw_over_surface(screen, "BACK")
  main_menu_backtext:draw_over_surface(screen, "Change profile")
end

-------------------------------------
-- Prints an active gamebutton.
-- @author Erik
-------------------------------------
function MainMenu:gamebuttonactive()
  screen:clear({ g = 131, r = 0, b = 143 }, { x = screen:get_width() * 0.05, y = screen:get_height() * 0.3, w = screen:get_width() * 0.42, h = screen:get_height() * 0.61 })
  screen:clear({ g = 255, r = 255, b = 255 }, { x = screen:get_width() * 0.055, y = (screen:get_height() * 0.309), w = (screen:get_width() * 0.41), h = (screen:get_height() * 0.593) })
  main_menu_games:draw_over_surface(screen, "Games")
end

-------------------------------------
-- Prints an inactive gamebutton.
-- @author Erik
-------------------------------------
function MainMenu:gamebuttoninactive()
  screen:clear({ g = 228, r = 187, b = 235 }, { x = screen:get_width() * 0.05, y = screen:get_height() * 0.3, w = screen:get_width() * 0.42, h = screen:get_height() * 0.61 })
  main_menu_games:draw_over_surface(screen, "Games")
end

-------------------------------------
-- Prints an active sidebutton.
-- @param x. Which place to print button.
-- @author Erik
-------------------------------------
function MainMenu:sidebuttonactive(x1)
  screen:clear({ g = 131, r = 0, b = 143 }, { x = screen:get_width() * 0.5375, y = (screen:get_height() * 0.3) + ((screen:get_height() * 0.2125) * (x1 - 1)), w = screen:get_width() * 0.425, h = screen:get_height() * 0.185 })
  screen:clear({ g = 255, r = 255, b = 255 }, { x = screen:get_width() * 0.5425, y = (screen:get_height() * 0.309) + ((screen:get_height() * 0.2125) * (x1 - 1)), w = (screen:get_width() * 0.415), h = (screen:get_height() * 0.1685) })

  self.sidebuttonfonts[x1]:draw_over_surface(screen, self.sidebuttons[x1])
end

-------------------------------------
-- Prints an inactive sidebutton.
-- @param x. Which place to print button.
-- @author Erik
-------------------------------------
function MainMenu:sidebuttoninactive(x1)
  screen:clear({ g = 228, r = 187, b = 235 }, { x = screen:get_width() * 0.5375, y = (screen:get_height() * 0.3) + ((screen:get_height() * 0.2125) * (x1 - 1)), w = screen:get_width() * 0.425, h = screen:get_height() * 0.185 })

  self.sidebuttonfonts[x1]:draw_over_surface(screen, self.sidebuttons[x1])
end

return MainMenu
