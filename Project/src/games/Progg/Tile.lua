-----------------------------------------------------------
-- This class represents the different types of tiles or
-- "blocks" that is used by the map class. The different
-- tiles have different characteristics that is handled
-- by the map class.
-- @Author:Created by Adam Lydén, Nov 16, 2015
-----------------------------------------------------------
local Object = require('toolkit.Object')
local Tile = extends(Object)

-------------------------------------
-- Constructor for different kinds of tiles that is used by the Map class
-- @param value is read from mapdata and used by this constructor
-- so that it knows which tile to construct and return.
-- @author Adam
-------------------------------------
function Tile:new(value)

        local o = Tile:super()
        o.active = true

        if(value == "0") then
                o.topBorder = false
                o.bottomBorder = false
                o.leftBorder = false
                o.rightBorder = false
                return Tile:init(o)
        end

        if(value == "1") then
                o.topBorder = false
                o.bottomBorder = false
                o.leftBorder = true
                o.rightBorder = false
                return Tile:init(o)
        end

        if(value == "2") then
                o.topBorder = false
                o.bottomBorder = true
                o.leftBorder = false
                o.rightBorder = false
                return Tile:init(o)
        end

        if(value == "3") then
                o.topBorder = false
                o.bottomBorder = true
                o.leftBorder = true
                o.rightBorder = false
                return Tile:init(o)
        end

        if(value == "4") then
                o.topBorder = false
                o.bottomBorder = false
                o.leftBorder = false
                o.rightBorder = true
                return Tile:init(o)
        end

        if(value == "5") then
                o.topBorder = false
                o.bottomBorder = false
                o.leftBorder = true
                o.rightBorder = true
                return Tile:init(o)
        end

        if(value == "6") then
                o.topBorder = false
                o.bottomBorder = true
                o.leftBorder = false
                o.rightBorder = true
                return Tile:init(o)
        end

        if(value == "7") then
                o.topBorder = false
                o.bottomBorder = true
                o.leftBorder = true
                o.rightBorder = true
                return Tile:init(o)
        end

        if(value == "8") then
                o.topBorder = true
                o.bottomBorder = false
                o.leftBorder = false
                o.rightBorder = false
                return Tile:init(o)
        end

        if(value == "9") then
                o.topBorder = true
                o.bottomBorder = false
                o.leftBorder = true
                o.rightBorder = false
                return Tile:init(o)
        end

        if(value == "a") then
                o.topBorder = true
                o.bottomBorder = true
                o.leftBorder = false
                o.rightBorder = false
                return Tile:init(o)
        end

        if(value == "b") then
                o.topBorder = true
                o.bottomBorder = true
                o.leftBorder = true
                o.rightBorder = false
                return Tile:init(o)
        end

        if(value == "c") then
                o.topBorder = true
                o.bottomBorder = false
                o.leftBorder = false
                o.rightBorder = true
                return Tile:init(o)
        end

        if(value == "d") then
                o.topBorder = true
                o.bottomBorder = false
                o.leftBorder = true
                o.rightBorder = true
                return Tile:init(o)
        end

        if(value == "e") then
                o.topBorder = true
                o.bottomBorder = true
                o.leftBorder = false
                o.rightBorder = true
                return Tile:init(o)
        end

        if(value == "f") then
                o.active = false
                o.topBorder = false
                o.bottomBorder = false
                o.leftBorder = false
                o.rightBorder = false
                return Tile:init(o)
        end

end


return Tile

