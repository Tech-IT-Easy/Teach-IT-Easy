Games = {} --MenuView:new()

-------------------------------------
-- Creates the Games menu.
-- @return self. The created menu-object.
-- @author Erik
-------------------------------------
function Games:new()

  -- text placing
  self.appnamebaseline = screen:get_height() * 0.08
  self.pagenamebaseline = screen:get_height() * 0.15
  self.usernamebaseline = screen:get_height() * 0.125

  -- images
  --self.background = gfx.loadpng("data/background_h720.png")

  -- fonts
  self.appname = sys.new_freetype({g=255, r=255, b=255, a=255}, screen:get_height()*0.04, {x= screen:get_width()*0.43, y=self.appnamebaseline}, script_path..'data/BlackoutMidnight.ttf')
  self.pagename = sys.new_freetype({g=255, r=255, b=255, a=255}, screen:get_height()*0.07, {x= screen:get_width()*0.33, y=self.pagenamebaseline}, script_path..'data/Chalkduster.ttf')
  self.username = sys.new_freetype({g=255, r=255, b=255, a=255}, screen:get_height()*0.035, {x= screen:get_width()*0.15, y=self.usernamebaseline}, script_path..'data/GROBOLD.ttf')
  self.backbutton = sys.new_freetype({g=0, r=0, b=0, a=255}, screen:get_height()*0.03, { x=screen:get_width()*0.8103, y=screen:get_height()*0.08046}, script_path..'data/condensed.ttf')
  self.backtext = sys.new_freetype({g=255, r=255, b=255, a=255}, screen:get_height()*0.03, { x=screen:get_width()*0.791, y=screen:get_height()*0.125}, script_path..'data/GROBOLD.ttf')

  self.gamename1 = sys.new_freetype({ r = 78, g = 78, b = 78 ,a=255}, screen:get_height() * 0.05, { x = screen:get_width() * 0.095, y = (screen:get_height() * 0.28) + (screen:get_height() * 0.28) * 1.1, w = screen:get_width() * 0.18, h = screen:get_height() * 0.45 }, script_path .. 'data/condensed.ttf')
  self.trophies1 = sys.new_freetype({ r = 139, g = 139, b = 139, a=255}, screen:get_height() * 0.04, { x = screen:get_width() * 0.095, y = (screen:get_height() * 0.28) + (screen:get_height() * 0.28) * 1.3, w = screen:get_width() * 0.18, h = screen:get_height() * 0.45 }, script_path .. 'data/condensed.ttf')

  self.gamename2 = sys.new_freetype({ r = 78, g = 78, b = 78, a=255}, screen:get_height() * 0.05, { x = screen:get_width() * 0.095 + (screen:get_width() * 0.22), y = (screen:get_height() * 0.28) + (screen:get_height() * 0.28) * 1.1, w = screen:get_width() * 0.18, h = screen:get_height() * 0.45 }, script_path .. 'data/condensed.ttf')
  self.trophies2 = sys.new_freetype({ r = 139, g = 139, b = 139, a=255}, screen:get_height() * 0.04, { x = screen:get_width() * 0.095 + (screen:get_width() * 0.22), y = (screen:get_height() * 0.28) + (screen:get_height() * 0.28) * 1.3, w = screen:get_width() * 0.18, h = screen:get_height() * 0.45 }, script_path .. 'data/condensed.ttf')

  self.gamename3 = sys.new_freetype({ r = 78, g = 78, b = 78, a=255}, screen:get_height() * 0.05, { x = screen:get_width() * 0.095 + (screen:get_width() * 0.22) * 2, y = (screen:get_height() * 0.28) + (screen:get_height() * 0.28) * 1.1, w = screen:get_width() * 0.18, h = screen:get_height() * 0.45 }, script_path .. 'data/condensed.ttf')
  self.trophies3 = sys.new_freetype({ r = 139, g = 139, b = 139, a=255}, screen:get_height() * 0.04, { x = screen:get_width() * 0.095 + (screen:get_width() * 0.22) * 2, y = (screen:get_height() * 0.28) + (screen:get_height() * 0.28) * 1.3, w = screen:get_width() * 0.18, h = screen:get_height() * 0.45 }, script_path .. 'data/condensed.ttf')

  self.gamename4 = sys.new_freetype({ r = 78, g = 78, b = 78, a=255}, screen:get_height() * 0.05, { x = screen:get_width() * 0.095 + (screen:get_width() * 0.22) * 3, y = (screen:get_height() * 0.28) + (screen:get_height() * 0.28) * 1.1, w = screen:get_width() * 0.18, h = screen:get_height() * 0.45 }, script_path .. 'data/condensed.ttf')
  self.trophies4 = sys.new_freetype({ r = 139, g = 139, b = 139, a=255}, screen:get_height() * 0.04, { x = screen:get_width() * 0.095 + (screen:get_width() * 0.22) * 3, y = (screen:get_height() * 0.28) + (screen:get_height() * 0.28) * 1.3, w = screen:get_width() * 0.18, h = screen:get_height() * 0.45 }, script_path .. 'data/condensed.ttf')

  self.gamesfonts = {self.gamename1, self.gamename2, self.gamename3,self.gamename4}
  self.trophiesfonts = {self.trophies1, self.trophies2, self.trophies3, self.trophies4}

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
function Games:handleinput(key)

  if key == 'right' and self.pos < #self.games then
    self:buttoninactive(self.pos) self.pos = self.pos + 1 self:buttonactive(self.pos)

  elseif key == 'left' and self.pos > 1 then
    self:buttoninactive(self.pos) self.pos = self.pos - 1 self:buttonactive(self.pos)

    --[[ Returns which view to change to (not implemented)
    if key == '1' then
     return {"main", self.games[self.pos][1]}
    end]]

  elseif key == '2' then
    return { "main", self.usernamestring }
  end
  return { " " }
end


-------------------------------------
-- Loads the view to the screen.
-- @author Erik
-------------------------------------
function Games:loadview(input)
  self.pos = 1
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
  screen:copyfrom(self.background, nil, { x = 0, y = 0, w = screen:get_width(), h = screen:get_height() }, true)
  self.background:destroy()
end

-------------------------------------
-- Prints content on screen.
-- @author Erik
-------------------------------------
function Games:renderui()

  self.appname:draw_over_surface(screen, "TEACH IT EASY")
  self.pagename:draw_over_surface(screen, "CHOOSE A GAME")
  self.username:draw_over_surface(screen, self.usernamestring)
  screen:clear({ g = 228, r = 187, b = 235 }, { x = screen:get_width() * 0.08, y = screen:get_height() * 0.09, w = screen:get_width() * 0.06, h = screen:get_height() * 0.1 })
  self:buttonactive(1)
  for i = 2, #self.games, 1 do
    self:buttoninactive(i)
  end
  screen:clear({ g = 0, r = 0, b = 0 }, { x = screen:get_width() * 0.8, y = screen:get_height() * 0.08, w = screen:get_width() * 0.05, h = screen:get_height() * 0.04 })
  screen:clear({ g = 230, r = 230, b = 230 }, { x = screen:get_width() * 0.803, y = screen:get_height() * 0.0845, w = screen:get_width() * 0.0455, h = screen:get_height() * 0.0308 })
  self.backbutton:draw_over_surface(screen, "BACK")
  self.backtext:draw_over_surface(screen, "Go back")
end

-------------------------------------
-- Prints an active gamebutton.
-- @param x. Which place to print button at.
-- @author Erik
-------------------------------------
function Games:buttonactive(x1)
  screen:clear({ g = 255, r = 255, b = 255 }, { x = screen:get_width() * 0.08 + (screen:get_width() * 0.22) * (x1 - 1), y = (screen:get_height() * 0.28), w = screen:get_width() * 0.18, h = screen:get_height() * 0.45 })

  --local gamename = sys.new_freetype({ r = 78, g = 78, b = 78 }, screen:get_height() * 0.05, { x = screen:get_width() * 0.095 + (screen:get_width() * 0.22) * (x1 - 1), y = (screen:get_height() * 0.28) + (screen:get_height() * 0.28) * 1.1, w = screen:get_width() * 0.18, h = screen:get_height() * 0.45 }, script_path .. 'data/condensed.ttf')
  self.gamesfonts[x1]:draw_over_surface(screen, self.games[x1][1])

  --local trophies = sys.new_freetype({ r = 139, g = 139, b = 139 }, screen:get_height() * 0.04, { x = screen:get_width() * 0.095 + (screen:get_width() * 0.22) * (x1 - 1), y = (screen:get_height() * 0.28) + (screen:get_height() * 0.28) * 1.3, w = screen:get_width() * 0.18, h = screen:get_height() * 0.45 }, script_path .. 'data/condensed.ttf')
  self.trophiesfonts[x1]:draw_over_surface(screen,"Trophies: " .. self.games[x1][2])
end

-------------------------------------
-- Prints an inactive gamebutton.
-- @param x. Which place to print button at.
-- @author Erik
-------------------------------------
function Games:buttoninactive(x1)
  screen:clear({ g = 228, r = 187, b = 235 }, { x = screen:get_width() * 0.08 + (screen:get_width() * 0.22) * (x1 - 1), y = (screen:get_height() * 0.28), w = screen:get_width() * 0.18, h = screen:get_height() * 0.45 })

  --local gamename = sys.new_freetype({r=139, g=139, b=139}, screen:get_height() * 0.05, {x = screen:get_width()*0.095 + (screen:get_width()*0.22)*(x1-1) , y = (screen:get_height()*0.28)+(screen:get_height()*0.28)*1.1 , w = screen:get_width()*0.18, h = screen:get_height()*0.45  }, script_path .. 'data/condensed.ttf')
  self.gamesfonts[x1]:draw_over_surface(screen, self.games[x1][1])

  --local trophies = sys.new_freetype({r=139, g=139, b=139}, screen:get_height() * 0.04, {x = screen:get_width()*0.095 + (screen:get_width()*0.22)*(x1-1) , y = (screen:get_height()*0.28)+(screen:get_height()*0.28)*1.3 , w = screen:get_width()*0.18, h = screen:get_height()*0.45  }, script_path .. 'data/condensed.ttf')
  self.trophiesfonts[x1]:draw_over_surface(screen,"Trophies: " .. self.games[x1][2])
end

return Games
