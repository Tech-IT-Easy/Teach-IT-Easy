CreateProfile = {} --MenuView:new()

local Event = require('toolkit.Event')
local ProfileSelection = require('menus.ProfileSelection')

function CreateProfile:new()
  --Profile name
  self.profilename = ""

  --Keyboard
  self.letters = { 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z','DONE' }

  return self
end

function CreateProfile:handleinput(event)
  collectgarbage()
  self.lastpos = self.pos
  if event.key == Event.KEY_RIGHT and self.pos < #self.letters then
     self.pos = self.pos + 1
  elseif event.key == Event.KEY_LEFT and self.pos > 1 then
     self.pos = self.pos - 1
  elseif event.key == Event.KEY_DOWN and self.pos <=17 then
    self.pos = self.pos + 10
  elseif event.key == Event.KEY_UP and self.pos >= 11 then
    self.pos = self.pos - 10
  elseif event.key == Event.KEY_ONE and self.pos < 27 then
    self.profilename = self.profilename .. self.letters[self.pos] self:updatetext()
  elseif event.key == Event.KEY_ONE and self.pos == 27 then
    table.insert(ProfileSelection.usernames, self.profilename)
    return { "chooseavatar", self.profilename }
  elseif event.key == Event.KEY_TWO then
    return { "profilesel", " " }
  end
  return { " " }
end


function CreateProfile:update()
  self:inactive(self.lastpos)
  self:active(self.pos)
end
--load view
function CreateProfile:loadview()
  self.pos = 1
  self.lastpos = 1
  --self:printbackground()
  self:renderui()
end

function CreateProfile:printbackground()
  self.background = gfx.loadpng("data/background_h720.png")
  screen:copyfrom(self.background, nil, { x = 0, y = 0, w = screen:get_width(), h = screen:get_height() }, true)
  self.background:destroy()
end

function CreateProfile:renderui()
  create_prof_appname:draw_over_surface(screen, "TEACH IT EASY")
  create_prof_pagename:draw_over_surface(screen, "TYPE IN YOUR NAME")
  screen:clear({ g = 255, r = 255, b = 255 }, { x = screen:get_width() * 0.1, y = screen:get_height() * 0.25 * 1.2, w = screen:get_width() * 0.8, h = screen:get_height() * 0.3 * 0.6 })
  screen:clear({ g = 131, r = 0, b = 143 }, { x = 0, y = screen:get_height() * 0.55, w = screen:get_width(), h = screen:get_height() * 0.45 })

  self:active(1)
  for i = 2, 27, 1 do
    self:inactive(i)
  end
end

function CreateProfile:active(x1)
  if (x1 <= 10) then
    screen:clear({ g = 255, r = 255, b = 255 }, { x = (create_prof_hspacing * x1) + create_prof_itemwidth * (x1 - 1), y = create_prof_itemy, w = create_prof_itemwidth, h = create_prof_itemheight })
    screen:clear({ g = 255, r = 255, b = 255 }, { x = (create_prof_hspacing * x1) + create_prof_itemwidth * (x1 - 1) + create_prof_itemwidth * 0.02, y = create_prof_activey, w = create_prof_activewidth, h = create_prof_activeheight })
  elseif (x1 <= 20) then
    screen:clear({ g = 255, r = 255, b = 255 }, { x = (create_prof_hspacing * (x1 - 10) + create_prof_itemwidth * (x1 - 1 - 10)), y = (create_prof_itemy + create_prof_itemheight * (1 + 0.5)), w = create_prof_itemwidth, h = create_prof_itemheight })
    screen:clear({ g = 255, r = 255, b = 255 }, { x = (create_prof_hspacing * (x1 - 10) + create_prof_itemwidth * (x1 - 1 - 10)) + create_prof_itemwidth * 0.02, y = (create_prof_itemy + create_prof_itemheight * (1 + 0.5)), w = create_prof_itemwidth, h = create_prof_itemheight })
  elseif (x1 <= 26) then
    screen:clear({ g = 255, r = 255, b = 255 }, { x = (create_prof_hspacing * (x1 - 20) + create_prof_itemwidth * (x1 - 1 - 20)), y = (create_prof_itemy + create_prof_itemheight * (1 + 0.5) * 2), w = create_prof_itemwidth, h = create_prof_itemheight })
    screen:clear({ g = 255, r = 255, b = 255 }, { x = (create_prof_hspacing * (x1 - 20) + create_prof_itemwidth * (x1 - 1 - 20)) + create_prof_itemwidth * 0.02, y = (create_prof_itemy + create_prof_itemheight * (1 + 0.5) * 2), w = create_prof_itemwidth, h = create_prof_itemheight })
  elseif (x1 <= 27) then
    screen:clear({ g = 255, r = 255, b = 255 }, { x = (create_prof_hspacing * (x1 - 20) + create_prof_itemwidth * (x1 - 1 - 20)), y = (create_prof_itemy + create_prof_itemheight * (1 + 0.5) * 2), w = create_prof_itemwidth * 2, h = create_prof_itemheight }) 
    screen:clear({ g = 255, r = 255, b = 255 }, { x = (create_prof_hspacing * (x1 - 20) + create_prof_itemwidth * (x1 - 1 - 20)) + create_prof_itemwidth * 0.02, y = (create_prof_itemy + create_prof_itemheight * (1 + 0.5) * 2), w = create_prof_itemwidth * 2, h = create_prof_itemheight }) 
  end
  
  create_prof_keyletters[x1]:draw_over_surface(screen, self.letters[x1])
end

function CreateProfile:inactive(x1)
  if (x1 <= 10) then
    screen:clear({ g = 228, r = 187, b = 235 }, { x = (create_prof_hspacing * x1) + create_prof_itemwidth * (x1 - 1), y = create_prof_itemy, w = create_prof_itemwidth, h = create_prof_itemheight })
  elseif (x1 <= 20) then
    screen:clear({ g = 228, r = 187, b = 235 }, { x = (create_prof_hspacing * (x1 - 10) + create_prof_itemwidth * (x1 - 1 - 10)), y = (create_prof_itemy + create_prof_itemheight * (1 + 0.5)), w = create_prof_itemwidth, h = create_prof_itemheight })
  elseif (x1 <= 26) then
    screen:clear({ g = 228, r = 187, b = 235 }, { x = (create_prof_hspacing * (x1 - 20) + create_prof_itemwidth * (x1 - 1 - 20)), y = (create_prof_itemy + create_prof_itemheight * (1 + 0.5) * 2), w = create_prof_itemwidth, h = create_prof_itemheight })
  elseif (x1 == 27) then
    screen:clear({ g = 228, r = 187, b = 235 }, { x = (create_prof_hspacing * (x1 - 20) + create_prof_itemwidth * (x1 - 1 - 20)), y = (create_prof_itemy + create_prof_itemheight * (1 + 0.5) * 2), w = create_prof_itemwidth * 2, h = create_prof_itemheight }) 
  end
  
  if x1 < (#self.letters + 1) then
    create_prof_keyletters[x1]:draw_over_surface(screen, self.letters[x1])
  end
end

function CreateProfile:updatetext()
  screen:clear({ g = 255, r = 255, b = 255 }, { x = screen:get_width() * 0.1, y = screen:get_height() * 0.25 * 1.2, w = screen:get_width() * 0.8, h = screen:get_height() * 0.3 * 0.6 })
  create_prof_typed:draw_over_surface(screen, self.profilename)
end


return CreateProfile
