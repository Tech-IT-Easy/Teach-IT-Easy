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
  self.pagename = sys.new_freetype({g=255, r=255, b=255}, screen:get_height()*0.07, {x= screen:get_width()*0.33, y=self.pagenamebaseline}, script_path..'data/Chalkduster.ttf')
  self.username = sys.new_freetype({g=255, r=255, b=255}, screen:get_height()*0.035, {x= screen:get_width()*0.15, y=self.usernamebaseline}, script_path..'data/BlackoutMidnight.ttf')

  self.pos = 1
  return self
end


function Games:handleinput(key)

  if key == '1' then return {"main", self.usernamestring} else return {" "} end

end



function Games:loadview(input)
 self.usernamestring = input
  self:printbackground()

  self:renderui()
 

end

function Games:printbackground()
  screen:copyfrom(self.background, nil, {x=0,y=0,w=screen:get_width(), h=screen:get_height()},true)
end



function Games:renderui()

  self.appname:draw_over_surface(screen, "TEACH IT EASY")
  self.pagename:draw_over_surface(screen, "CHOOSE A GAME")
  self.username:draw_over_surface(screen, self.usernamestring)
  screen:clear({g=228, r=187, b=235}, {x=screen:get_width()*0.08, y=screen:get_height()*0.09, w=screen:get_width()*0.06, h= screen:get_height()*0.1})
  self:buttonactive(1)
end

function Games:buttonactive(x)
  screen:clear({ g = 255, r = 255, b = 255 }, { x = screen:get_width()*0.1 + (screen:get_width()*0.2)*(x-1) , y = (screen:get_height()*0.28) , w = screen:get_width()*0.18, h = screen:get_height()*0.45 })

  --local sidebuttontext = sys.new_freetype({ g = 131, r = 0, b = 143}, screen:get_height() * 0.07, { x = screen:get_width()*0.65, y = (screen:get_height()*0.35) + ((screen:get_height()*0.2125)*(x-1)) }, script_path .. 'data/condensed.ttf')
  --sidebuttontext:draw_over_surface(screen, self.sidebuttons[x])
end

function Games:buttoninactive(x)
  screen:clear({ g = 228, r = 187, b = 235 }, { x = screen:get_width()*0.5375, y = (screen:get_height()*0.3) + ((screen:get_height()*0.2125)*(x-1)) , w = screen:get_width()*0.425, h = screen:get_height()*0.185 })
  screen:clear({ g = 228, r = 187, b = 235 }, { x = screen:get_width()*0.1 + (screen:get_width()*0.2)*(x-1) , y = (screen:get_height()*0.25) , w = screen:get_width()*0.18, h = screen:get_height()*0.45 })
  
  --local sidebuttontext = sys.new_freetype({ g = 131, r = 0, b = 143}, screen:get_height() * 0.07, { x = screen:get_width()*0.65, y = (screen:get_height()*0.35) + ((screen:get_height()*0.2125)*(x-1)) }, script_path .. 'data/condensed.ttf')
  --sidebuttontext:draw_over_surface(screen, self.sidebuttons[x])
end

return Games