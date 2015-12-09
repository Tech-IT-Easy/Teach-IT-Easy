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
-- This class is a data type which load image into memory based
-- on given path
--
-- @Author:Created by Chuck, NOV 19,2015
-----------------------------------------------------------
--
local Object = require("toolkit.Object")
local UIImage = extends(Object)

function UIImage:new(args)
  local o = UIImage:super()
  --@member image path
  o.imagePath = args.imagePath
  
  --@member image type
  o.imageType = args.imageType
  
  --@member imageBuffer load image when created
  if(args.imageType=="png") then
    o.imageData = gfx.loadpng(args.imagePath)
    o.imageData:premultiply()
  elseif(args.imageType=="jpeg") then
    o.imageData = gfx.loadjpeg(args.imagePath)
  end
  
  --For future development, when create a UIImage object, following properties are unnecessary
  --@member image width
  o.width = args.width or o.imageData:get_width()
  
  --@member image height
  o.height = args.height or o.imageData:get_height()
  
  return UIImage:init(o)
end

return UIImage