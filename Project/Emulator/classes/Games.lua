Games = {} --MenuView:new()


function Games:new()

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
  
  self.pos = 1
  return self
end


function Games:handleinput(key)

  if key == '1' then return {"main"} else return {" "} end

end



function Games:loadview(input)

  self:printbackground()

  self:renderui(input)

end

function Games:printbackground()
  screen:copyfrom(self.background, nil, {x=0,y=0,w=screen:get_width(), h=screen:get_height()},true)
end



function Games:renderui(input)

  self.appname:draw_over_surface(screen, "TEACH IT EASY")
  self.pagename:draw_over_surface(screen, "CHOOSE A GAME")
  self.username:draw_over_surface(screen, input)
  screen:clear({g=228, r=187, b=235}, {x=screen:get_width()*0.08, y=screen:get_height()*0.09, w=screen:get_width()*0.06, h= screen:get_height()*0.1})
end