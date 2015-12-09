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
-- This class is the class for showing a rectangle, which can be
-- configured based on its properties
--
-- @Author:Created by Chuck, NOV 19,2015
-----------------------------------------------------------

SystemFreeType = require("toolkit.UIKit.UISystemFreeType")
local UIView = require("toolkit.UIKit.UIView")
local UIRectangleView = extends(UIView)



function UIRectangleView:new(args)
  local o = UIRectangleView:super{frame=args.frame,container=args.container}
  assert(args.identity,"UIRectangleView:new(args):identity is nil")
  o.identity = args.identity
  --@member background color {r=2,g=2,b=3}
  o.backgroundColor = args.backgroundColor or {r=255,g=255,b=255}
  --@member background image.Type of UIImage
  o.backgroundImage = args.backgroundImage
  -- @member border color
  o.borderColor = args.borderColor or o.backgroundColor
  -- @member border width, default is 2
  o.borderWidth = args.borderWidth or 0
  -- @member label
  o.label = args.label or nil
  -- @member label position
  o.labelPosition = args.labelPosition or {x=0,y=0}
  -- @member background area = frame - borderWidth
  
  o.backgroundArea = {
    x = o.globalFrame.x + o.borderWidth,
    y = o.globalFrame.y + o.borderWidth,
    w = o.frame.w - 2*o.borderWidth,
    h = o.frame.h - 2*o.borderWidth
  }
  -- @member labelData
  -- firstly change position relative to button frame
  if o.label then
    o.labelAbsolutePosition = {
      x = o.globalFrame.x + o.labelPosition.x,
      y = o.globalFrame.y + o.labelPosition.y
    }
    
  end
  return UIRectangleView:init(o)
end

function UIRectangleView:afterUpdateGlobalFrame()

  self.backgroundArea = {
    x = self.globalFrame.x + self.borderWidth,
    y = self.globalFrame.y + self.borderWidth,
    w = self.frame.w - 2*self.borderWidth,
    h = self.frame.h - 2*self.borderWidth
  }
  self:updateLabelPosition()
end
function UIRectangleView:setLabel(label,position)
  self.label = label
  self.labelPosition = position or {x=0,y=0}
  self:updateLabelPosition()
end

function UIRectangleView:updateLabelPosition()
  if self.label then
    self.labelAbsolutePosition = {
      x = self.globalFrame.x + self.labelPosition.x,
      y = self.globalFrame.y + self.labelPosition.y
    }
  end
end
-- show the button on specific position
function UIRectangleView:show()
  -- draw frame with border color
  if self.borderWidth ~= 0 then
    screen:clear(self.borderColor, self.globalFrame)
  end
  
  if self.backgroundColor then
    screen:clear(self.backgroundColor, self.backgroundArea)
  end
  
  -- draw image
  -- calculate image position and make it center
  if self.backgroundImage then

    local fitImageSize = {
      w = ((self.backgroundImage.width > self.backgroundArea.w) and self.backgroundArea.w-2) or self.backgroundImage.width,
      h = ((self.backgroundImage.height > self.backgroundArea.h) and self.backgroundArea.h-2) or self.backgroundImage.height
    }

    local imageArea = {
      x = self.backgroundArea.x + self.backgroundArea.w/2 - fitImageSize.w/2,
      y = self.backgroundArea.y + self.backgroundArea.h/2 - fitImageSize.h/2,
      w = fitImageSize.w,
      h = fitImageSize.h
    }
    screen:copyfrom(self.backgroundImage.imageData, nil, imageArea, true)
  end
  -- end draw background image

  -- draw text,
  if self.label and self.labelAbsolutePosition then
    SystemFreeType:drawLabel(self.label,self.labelAbsolutePosition)
  end
  -- end draw text
end

return UIRectangleView