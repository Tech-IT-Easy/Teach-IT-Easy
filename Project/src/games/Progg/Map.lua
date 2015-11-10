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
  screen:clear({ r = 55, g = 72, b = 160 }, { x = screen:get_width() * 0.055, y = screen:get_height()*0.06, w = screen:get_width() * 0.64, h = screen:get_height()*0.532 })




    self.mapdata = {2, 1, 2, 1, 1, 1, 1, 1,
                    1, 2, 1, 2, 1, 1, 1, 1,
                    1, 1, 2, 1, 2, 1, 1, 1,
                    1, 1, 1, 2, 1, 2, 1, 1,
                    1, 1, 1, 1, 2, 1, 2, 1,}

  --Mapdata
  for i = 1, 40, 1 do
    --to be implemented?
    --self:printsquare(mapdata[i])

    self:printsquare(i, self.mapdata)
  end

end

function Map:update()

end

function Map:printsquare(i, mapdata)

  -- If bloctype == type 1
  if mapdata[i]==1 then

  if(i<9)then
    screen:clear({ g = 83, r = 101, b = 219 }, { x = screen:get_width() * 0.08 + (screen:get_width() * 0.06) * (i - 1), y = (screen:get_height() * 0.08), w = screen:get_width() * 0.05, h = screen:get_height() * 0.08 })
  elseif(i<17)then
  i= i -8
  screen:clear({ g = 83, r = 101, b = 219 }, { x = screen:get_width() * 0.08 + (screen:get_width() * 0.06) * (i - 1), y = (screen:get_height() * 0.18), w = screen:get_width() * 0.05, h = screen:get_height() * 0.08 })
 
  elseif(i<25)then
  i= i -16
  screen:clear({ g = 83, r = 101, b = 219 }, { x = screen:get_width() * 0.08 + (screen:get_width() * 0.06) * (i - 1), y = (screen:get_height() * 0.28), w = screen:get_width() * 0.05, h = screen:get_height() * 0.08 })
 
  elseif(i<33)then
  i= i -24
  screen:clear({ g = 83, r = 101, b = 219 }, { x = screen:get_width() * 0.08 + (screen:get_width() * 0.06) * (i - 1), y = (screen:get_height() * 0.38), w = screen:get_width() * 0.05, h = screen:get_height() * 0.08 })
 
  else
  i= i -32
  screen:clear({ g = 83, r = 101, b = 219 }, { x = screen:get_width() * 0.08 + (screen:get_width() * 0.06) * (i - 1), y = (screen:get_height() * 0.48), w = screen:get_width() * 0.05, h = screen:get_height() * 0.08 })
 
  
  end
  end


end


return Map


