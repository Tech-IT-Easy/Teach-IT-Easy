-- Under development... feel free to add, edit, remove
-- This class represents the game map.

-- Created by IntelliJ IDEA.
-- User: Adam Lydén
-- Date: 2015-11-04
-- Time: 13:57


local Object = require('toolkit.Object')

local Map = extends(Object)

-- constructor for new empty map, 0 = free walking
function Map:new()
  local o = Map:super()
    -- defining the total area
 o.area={x=0,y=0,width=800,height=500 }

    o.mapblocks = {0, 0, 0, 0, 0, 0, 0, 0,
          0, 0, 0, 0, 0, 0, 0, 0,
          0, 0, 0, 0, 0, 0, 0, 0,
          0, 0, 0, 0, 0, 0, 0, 0,
          0, 0, 0, 0, 0, 0, 0, 0,}

 return Map:init(o)
end

-- 2nd constructor, for constructing map with help of predefined Mapdata (does not yet exist such data)
function Map:new(Mapdata)
  local o = Map:super()
    o.area={x=0,y=0,width=800,height=500 }
    o.mapblocks = {}
    o.mapblocks = Mapdata

 return Map:init(o)
end


return Map


