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
-------------------------------------
-- This class represents a profile. It holds
-- avatar and progress related to an instance
-- of Profile.
-- @author Adam
-------------------------------------

local Object = require('toolkit.Object')
local Profile = extends(Object)

local GameProgress =require('toolkit.GameProgress')

-------------------------------------
-- Constructor method
-- @param name:String the name of the profile
-- @param avatarNum:integer a representation of the avatar images
-- @return :Profile a new instance of Profile
-- @author Adam
-------------------------------------
function Profile:new(name, image, imagefolder)
        local o = Profile:super()
        o.name = name
        o.avatar = image
          -- @member gameProgress:GameProgress
        o.gameprogress = GameProgress:new(o.name)
        o.images = {}
        o.images = Profile:getImages(imagefolder)

        return Profile:init(o)
end

-------------------------------------
-- Returns avatar images
-- @param imagefolder:String the name of the folder with the images
-- @return :Table with the images mapped to keys UP, DOWN, LEFT, RIGHT
-- @author Trygg
-------------------------------------
function Profile:getImages(imagefolder)
    local folderstring = "data/avatar"..imagefolder
    local UP = folderstring.."UP.png"
    local DOWN = folderstring.."DOWN.png"
    local RIGHT = folderstring.."RIGHT.png"
    local LEFT = folderstring.."LEFT.png"
    local images = {UP = UP, DOWN = DOWN, RIGHT = RIGHT, LEFT = LEFT }
    return images
end


return Profile

