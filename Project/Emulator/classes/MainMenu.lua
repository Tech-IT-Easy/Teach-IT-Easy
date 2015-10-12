--require("classes.MenuView")

-- Inherits from MenuView

MainMenu = {} --MenuView:new()


function MainMenu:new()

-- text placing
  self.appnamebaseline = screen:get_height()*0.08
  self.pagenamebaseline = screen:get_height()*0.15
  -- Fonts
  -- Needs to be changed to absolute path on STB, or implement solution
  self.appname = sys.new_freetype({g=255, r=255, b=255}, screen:get_height()*0.04, {x= screen:get_width()*0.43, y=self.appnamebaseline}, script_path..'data/BlackoutMidnight.ttf')

  -- images
  self.background = gfx.loadpng("data/background.png")

  -- fonts
  self.pagename = sys.new_freetype({g=255, r=255, b=255}, screen:get_height()*0.07, {x= screen:get_width()*0.375, y=self.pagenamebaseline}, script_path..'data/Chalkduster.ttf')

  self.pos = 1
  return self
end


function MainMenu:handleinput(key)

-- each menu will have its own function to handle remote input

--[[ if key == 'right' and self.pos < 4 then self:inactive(self.pos) self.pos = self.pos + 1 self:active(self.pos) end

  if key == 'left' and self.pos > 1 then self:inactive(self.pos) self.pos = self.pos - 1 self:active(self.pos) end


  if key == 'down' then self:inactive(self.pos) self.pos = 5 self:active(self.pos) end


  if key == 'up' and self.pos == 5 then self:inactive(self.pos) self.pos = 1 self:active(self.pos) end

--]]
if key == '1' then return "profilesel" else return " " end

end



function MainMenu:loadview()

  self:printbackground()

  self:renderui()

end

function MainMenu:printbackground()
  --screen:clear({g=131, r=0, b=143}, {x=100, y=100, w=100, h= 100})
  screen:copyfrom(self.background, nil, {x=0,y=0,w=screen:get_width(), h=screen:get_height()},true)
end



function MainMenu:renderui()

  self.appname:draw_over_surface(screen, "TEACH IT EASY")

  self.pagename:draw_over_surface(screen, "MAIN MENU")

end



return MainMenu
