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
-- This class is supper class for UI views, usually a UIView 
-- class should contain a specific UIType such as UILabel or 
-- UIImage to show them
--
-- @Author:Created by Chuck, NOV 19,2015
-----------------------------------------------------------
local Object = require("toolkit.Object")
local UIView = extends(Object)

function UIView:new(args)
  local o = UIView:super()
 
  --@member frame UIView class default frame is window screen
  o.frame = (args and args.frame) or {x = 0,y = 0,w = screen:get_width(),h = screen:get_height()}
  
  --@member container which contains this UIView,default nil which means whole window
  o.container = (args and args.container) or {frame={x = 0,y = 0,w = screen:get_width(),h = screen:get_height()},globalFrame={x = 0,y = 0,w = screen:get_width(),h = screen:get_height()}}
  
  --@member absolute position,which should be used when show something on screen
  o.globalFrame = {x = o.frame.x + o.container.globalFrame.x, y = o.frame.y + o.container.globalFrame.y,w = o.frame.w,h = o.frame.h}
  return UIView:init(o)
end

function UIView:afterUpdateGlobalFrame()
  -- code implemented by subclass
end


function UIView:updateGlobalFrame()
  self.globalFrame = {x = self.frame.x + self.container.globalFrame.x, y = self.frame.y + self.container.globalFrame.y,w = self.frame.w,h = self.frame.h}
  self:afterUpdateGlobalFrame()
end


function UIView:setContainer(container)
  self.container = container
  self:updateGlobalFrame()
end

function UIView:setFrame(frame)
  self.frame = frame
  self:updateGlobalFrame()
end

WINDOW = UIView:new(nil)

return UIView
