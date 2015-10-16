require("classes.Object")

-- "Abstract" menu class

MenuView = Object:new()

function MenuView:new()
  -- text placing
  self.appnamebaseline = screen:get_height()*0.08
  self.pagenamebaseline = screen:get_height()*0.15
  -- Fonts
  -- Needs to be changed to absolute path on STB, or implement solution
  -- self.appname = sys.new_freetype({g=255, r=255, b=255}, screen:get_height()*0.04, {x= screen:get_width()*0.43, y=self.appnamebaseline}, script_path..'data/BlackoutMidnight.ttf')

  return self
end

function MenuView:handleinput(key)
-- each menu will have its own function to handle remote input
-- sent from the onkey()
end

function MenuView:printbackground()
  --screen:clear({g=131, r=0, b=143}, {x=100, y=100, w=100, h= 100})
  screen:copyfrom(self.background, nil, {x=0,y=0,w=screen:get_width(), h=screen:get_height()},true)
end

function MenuView:loadview()
--for printing out the current view
end

return MenuView
