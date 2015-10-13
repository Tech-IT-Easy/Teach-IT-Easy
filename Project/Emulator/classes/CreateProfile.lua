CreateProfile = {} --MenuView:new()


function CreateProfile:new()

  -- text placing
  self.appnamebaseline = screen:get_height()*0.08
  self.pagenamebaseline = screen:get_height()*0.15

  -- images
  self.background = gfx.loadpng("data/background.png")

  -- fonts
  -- Needs to be changed to absolute path on STB, or implement solution
  self.appname = sys.new_freetype({g=255, r=255, b=255}, screen:get_height()*0.04, {x= screen:get_width()*0.43, y=self.appnamebaseline}, script_path..'data/BlackoutMidnight.ttf')
  self.pagename = sys.new_freetype({g=255, r=255, b=255}, screen:get_height()*0.07, {x= screen:get_width()*0.375, y=self.pagenamebaseline}, script_path..'data/Chalkduster.ttf')
 
  return self
end

function CreateProfile:handleinput(key)
  if key == '1' then return {" "} else return {" "} end

end

--load view
function CreateProfile:loadview()
  self:printbackground()
  self:renderui()

end

function CreateProfile:printbackground()
  screen:copyfrom(self.background, nil, {x=0,y=0,w=screen:get_width(), h=screen:get_height()},true)
end



function CreateProfile:renderui()

  self.appname:draw_over_surface(screen, "TEACH IT EASY")
  self.pagename:draw_over_surface(screen, "TYPE IN YOUR NAME")
end

return CreateProfile