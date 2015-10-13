--require("classes.MenuView")

-- Inherits from MenuView

MainMenu = {} --MenuView:new()


function MainMenu:new()

  -- text placing
  self.appnamebaseline = screen:get_height()*0.08
  self.pagenamebaseline = screen:get_height()*0.15
  self.usernamebaseline = screen:get_height()*0.125

  -- images
  self.background = gfx.loadpng("data/background.png")

  -- fonts
  -- Needs to be changed to absolute path on STB, or implement solution
  self.appname = sys.new_freetype({g=255, r=255, b=255}, screen:get_height()*0.04, {x= screen:get_width()*0.43, y=self.appnamebaseline}, script_path..'data/BlackoutMidnight.ttf')
  self.pagename = sys.new_freetype({g=255, r=255, b=255}, screen:get_height()*0.07, {x= screen:get_width()*0.375, y=self.pagenamebaseline}, script_path..'data/Chalkduster.ttf')
  self.username = sys.new_freetype({g=255, r=255, b=255}, screen:get_height()*0.035, {x= screen:get_width()*0.15, y=self.usernamebaseline}, script_path..'data/BlackoutMidnight.ttf')
  self.games = sys.new_freetype({g=131, r=0, b=143}, screen:get_height()*0.1, {x= screen:get_width()*0.19, y=(screen:get_height()*0.65)}, script_path..'data/BlackoutMidnight.ttf')

  self.pos = 1
  return self
end


function MainMenu:handleinput(key)

  if key == '1' then return {"games", self.usernamestring} else return {" "} end

end



function MainMenu:loadview(input)
  self.usernamestring = input
  self:printbackground()

  self:renderui()
end

function MainMenu:printbackground()
  screen:copyfrom(self.background, nil, {x=0,y=0,w=screen:get_width(), h=screen:get_height()},true)
end



function MainMenu:renderui()

  self.appname:draw_over_surface(screen, "TEACH IT EASY")
  self.pagename:draw_over_surface(screen, "MAIN MENU")
  self.username:draw_over_surface(screen, self.usernamestring)
  screen:clear({g=228, r=187, b=235}, {x=screen:get_width()*0.08, y=screen:get_height()*0.09, w=screen:get_width()*0.06, h= screen:get_height()*0.1})
  self:gamebuttonactive()
end

function MainMenu:gamebuttonactive()
  screen:clear({g=131, r=0, b=143}, {x=screen:get_width()*0.1, y=screen:get_height()*0.3, w=screen:get_width()*0.35, h= screen:get_height()*0.5})
  screen:clear({g=255, r=255, b=255}, {x=screen:get_width()*0.105 , y=(screen:get_height()*0.309), w=(screen:get_width()*0.34), h=(screen:get_height()*0.483)})
  self.games:draw_over_surface(screen, "GAMES")
end

function MainMenu:gamebuttoninactive()
  screen:clear({g=228, r=187, b=235}, {x=screen:get_width()*0.1, y=screen:get_height()*0.3, w=screen:get_width()*0.35, h= screen:get_height()*0.5})
  self.games:draw_over_surface(screen, "GAMES")
end



return MainMenu
