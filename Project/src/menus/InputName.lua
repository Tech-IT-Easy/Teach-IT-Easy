--CreateProfile = {} --MenuView:new()
-- Changed to extending empty super-menu
local Super = require('toolkit.MenuSuperClass')
local InputName = extends(Super)

local Event = require('toolkit.Event')
local ProfileSelection = require('menus.ProfileSelection')
local LOCALE = require('i18n.main')

-------------------------------------
-- Creates the InputName-menu.
-- @return self:InputName The created menu-object.
-- @author Erik/ Marcus / Vilhelm
-------------------------------------

-- Must use ".self" otherwise it crashes in simulator when
-- trying to create profile, unknown reason why.. // Adam
function InputName:new()
  local o = InputName:super()
  --Profile name
  self.profilename = ""

  --Keyboard
  self.letters = { 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'DONE', '<--' }

  return self
end

-------------------------------------
-- Updates the currently active key on the keyboard.
-- @author Erik/ Marcus
-------------------------------------
function InputName:update()
  self:inactive(self.lastpos)
  self:active(self.pos)
end

-------------------------------------
-- Loads the view to the screen.
-- @author Erik/ Marcus
-------------------------------------
function InputName:loadview()
  self.pos = 1
  self.lastpos = 1
  --self:printbackground()
  self:renderui()
end

-------------------------------------
-- Prints content on screen.
-- @author Erik/ Marcus
-------------------------------------
function InputName:renderui()
  create_prof_appname:draw_over_surface(screen, LOCALE.APP_NAME)
  create_prof_pagename:draw_over_surface(screen, LOCALE.NAME_INPUT)
  screen:clear({ g = 255, r = 255, b = 255 }, { x = screen:get_width() * 0.1, y = screen:get_height() * 0.25 * 1.2, w = screen:get_width() * 0.8, h = screen:get_height() * 0.3 * 0.6 })
  screen:clear({ g = 131, r = 0, b = 143 }, { x = 0, y = screen:get_height() * 0.55, w = screen:get_width(), h = screen:get_height() * 0.45 })

  self:active(1)
  for i = 2, 28, 1 do
    self:inactive(i)
  end
end

-------------------------------------
-- Prints an active button.
-- @param x1. Which place to print button to.
-- @author Erik/ Marcus
-------------------------------------
function InputName:active(x1)
  if (x1 <= 10) then
    screen:clear({ g = 255, r = 255, b = 255 }, { x = (create_prof_hspacing * x1) + create_prof_itemwidth * (x1 - 1), y = create_prof_itemy, w = create_prof_itemwidth, h = create_prof_itemheight })
    screen:clear({ g = 255, r = 255, b = 255 }, { x = (create_prof_hspacing * x1) + create_prof_itemwidth * (x1 - 1) + create_prof_itemwidth * 0.02, y = create_prof_activey, w = create_prof_activewidth, h = create_prof_activeheight })
  elseif (x1 <= 20) then
    screen:clear({ g = 255, r = 255, b = 255 }, { x = (create_prof_hspacing * (x1 - 10) + create_prof_itemwidth * (x1 - 1 - 10)), y = (create_prof_itemy + create_prof_itemheight * (1 + 0.5)), w = create_prof_itemwidth, h = create_prof_itemheight })
    screen:clear({ g = 255, r = 255, b = 255 }, { x = (create_prof_hspacing * (x1 - 10) + create_prof_itemwidth * (x1 - 1 - 10)) + create_prof_itemwidth * 0.02, y = (create_prof_itemy + create_prof_itemheight * (1 + 0.5)), w = create_prof_itemwidth, h = create_prof_itemheight })
  elseif (x1 <= 26) then
    screen:clear({ g = 255, r = 255, b = 255 }, { x = (create_prof_hspacing * (x1 - 20) + create_prof_itemwidth * (x1 - 1 - 20)), y = (create_prof_itemy + create_prof_itemheight * (1 + 0.5) * 2), w = create_prof_itemwidth, h = create_prof_itemheight })
    screen:clear({ g = 255, r = 255, b = 255 }, { x = (create_prof_hspacing * (x1 - 20) + create_prof_itemwidth * (x1 - 1 - 20)) + create_prof_itemwidth * 0.02, y = (create_prof_itemy + create_prof_itemheight * (1 + 0.5) * 2), w = create_prof_itemwidth, h = create_prof_itemheight })
  elseif (x1 <= 28) then
    screen:clear({ g = 255, r = 255, b = 255 }, { x = (create_prof_hspacing * (x1 - 20) + create_prof_itemwidth * (x1 - 1 - 20)), y = (create_prof_itemy + create_prof_itemheight * (1 + 0.5) * 2), w = create_prof_itemwidth * 2, h = create_prof_itemheight })
    screen:clear({ g = 255, r = 255, b = 255 }, { x = (create_prof_hspacing * (x1 - 20) + create_prof_itemwidth * (x1 - 1 - 20)) + create_prof_itemwidth * 0.02, y = (create_prof_itemy + create_prof_itemheight * (1 + 0.5) * 2), w = create_prof_itemwidth * 2, h = create_prof_itemheight })
  end

  create_prof_keyletters[x1]:draw_over_surface(screen, self.letters[x1])
end

-------------------------------------
-- Prints an inactive button.
-- @param x1. Which place to print button to.
-- @author Erik/ Marcus
-------------------------------------
function InputName:inactive(x1)
  if (x1 <= 10) then
    screen:clear({ g = 228, r = 187, b = 235 }, { x = (create_prof_hspacing * x1) + create_prof_itemwidth * (x1 - 1), y = create_prof_itemy, w = create_prof_itemwidth, h = create_prof_itemheight })
  elseif (x1 <= 20) then
    screen:clear({ g = 228, r = 187, b = 235 }, { x = (create_prof_hspacing * (x1 - 10) + create_prof_itemwidth * (x1 - 1 - 10)), y = (create_prof_itemy + create_prof_itemheight * (1 + 0.5)), w = create_prof_itemwidth, h = create_prof_itemheight })
  elseif (x1 <= 26) then
    screen:clear({ g = 228, r = 187, b = 235 }, { x = (create_prof_hspacing * (x1 - 20) + create_prof_itemwidth * (x1 - 1 - 20)), y = (create_prof_itemy + create_prof_itemheight * (1 + 0.5) * 2), w = create_prof_itemwidth, h = create_prof_itemheight })
  elseif (x1 <= 28) then
    screen:clear({ g = 228, r = 187, b = 235 }, { x = (create_prof_hspacing * (x1 - 20) + create_prof_itemwidth * (x1 - 1 - 20)), y = (create_prof_itemy + create_prof_itemheight * (1 + 0.5) * 2), w = create_prof_itemwidth * 2, h = create_prof_itemheight })
  end

  if x1 < (#self.letters + 1) then
    create_prof_keyletters[x1]:draw_over_surface(screen, self.letters[x1])
  end
end

-------------------------------------
-- Prints the username to the screen when a letter is appended.
-- @author Erik/ Marcus
-------------------------------------
function InputName:updatetext()
  screen:clear({ g = 255, r = 255, b = 255 }, { x = screen:get_width() * 0.1, y = screen:get_height() * 0.25 * 1.2, w = screen:get_width() * 0.8, h = screen:get_height() * 0.3 * 0.6 })
  create_prof_typed:draw_over_surface(screen, self.profilename)
end


return InputName
