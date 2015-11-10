-- Under development... feel free to add, edit, remove
-- This class represents the game map.

-- Created by IntelliJ IDEA.
-- User: Adam Lydén
-- Date: 2015-11-04
-- Time: 13:57


local Object = require('toolkit.Object')

local Map = extends(Object.class())

-- constructor for new empty map, 0 = free walking
function Map:new()
  --[[
  -- defining the total area
  self.area={x=0,y=0,width=800,height=500 }

  self.mapblocks = {0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0, 0,}
--]]
  return self.class()
end
--[[
-- 2nd constructor, for constructing map with help of predefined Mapdata (does not yet exist such data)
function Map:new(Mapdata)

  self.area={x=0,y=0,width=800,height=500 }
  self.mapblocks = {}
  self.mapblocks = Mapdata

  return self.class()
end
]]

function Map:load()
  self.background = gfx.loadpng('data/game_background_small.png')
  screen:copyfrom(self.background, nil, { x = 0, y = 0, w = screen:get_width()*0.75, h = screen:get_height()*0.65 }, true)
  self.background:destroy()
  
  screen:clear({ r = 0, g = 0, b = 0 }, { x = screen:get_width() * 0.05, y = screen:get_height()*0.05, w = screen:get_width() * 0.65, h = screen:get_height()*0.55 })
    
  
end

function Map:update()

end


return Map


