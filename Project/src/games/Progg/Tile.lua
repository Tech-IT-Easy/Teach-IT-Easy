--[[TEACH IT EASY, an educational games platform
    Copyright (C) 2015  Linköping University

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.


    MIT LICENSE:
    Copyright (c) 2015 Zenterio AB

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:



    The above copyright notice and this permission notice shall be included in
    all copies or substantial portions of the Software.


    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
    THE SOFTWARE.


    ]]
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

