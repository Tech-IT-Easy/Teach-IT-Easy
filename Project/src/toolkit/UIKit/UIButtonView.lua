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
-- This class is the class for showing a button, which can be
-- configured based on its properties
--
-- @Author:Created by Chuck, NOV 19,2015
-----------------------------------------------------------
SystemFreeType = require("toolkit.UIKit.UISystemFreeType")
local UIDefaultTheme = require("toolkit.UIKit.UIDefaultTheme")
local UIView = require("toolkit.UIKit.UIView")
local UIButtonView = extends(UIView)

-- args = {frame={x=1,y=1,w=50,h=50},}
function UIButtonView:new(args)
  local o = UIButtonView:super{frame=args.frame,container=args.container}
  o.identity = args.identity
  -- @member background image
  o.backgroundImage = args.backgroundImage or nil
  -- @member background color
  o.backgroundColor = args.backgroundColor or UIDefaultTheme.BUTTON_VIEW.BACKGROUND
  -- @member border color
  o.borderColor = args.borderColor or o.backgroundColor
  -- @member border width, default is 2
  o.borderWidth = args.borderWidth or 2
  -- @member enable focused
  o.enableFocus = args.enableFocus or false
  -- @member marked as selected, default is false
  o.isSelected = args.isSelected or false
  -- @member hightlight color
  o.selectedColor = args.selectedColor or UIDefaultTheme.BUTTON_VIEW.BACKGROUND
  -- @member marked as selected, default is false
  o.isFocused = args.isFocused or false
  -- @member focused color
  o.focusedBorderColor = args.focusedBorderColor or UIDefaultTheme.BUTTON_VIEW.FOCUSED_BORDER
  -- @member focused background color
  o.focusedBackgroundColor = args.focusedBackgroundColor or UIDefaultTheme.BUTTON_VIEW.FOCUSED_BACKGROUND
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

  -- especially number
   -- @member label
  o.tipLabel = args.tipLabel or nil
  -- @member label position
  o.tipLabelPosition = args.tipLabelPosition or {x=0,y=0}

  -- @member labelData
  -- firstly change position relative to button frame
  if o.tipLabel then
    o.tipLabelAbsolutePosition = {
      x = o.globalFrame.x + o.tipLabelPosition.x,
      y = o.globalFrame.y + o.tipLabelPosition.y
    }
  end
  return UIButtonView:init(o)
end

--------------------------------------------------
--@ override UIView method
--since labelData needs to be created before shown
--------------------------------------------------
function UIButtonView:afterUpdateGlobalFrame()

  self.backgroundArea = {
    x = self.globalFrame.x + self.borderWidth,
    y = self.globalFrame.y + self.borderWidth,
    w = self.frame.w - 2*self.borderWidth,
    h = self.frame.h - 2*self.borderWidth
  }
  self:updateLabelPosition()
end

function UIButtonView:setLabel(label,position)
  self.label = label
  self.labelPosition = position or {x=0,y=0}
  self:updateLabelPosition()
end

function UIButtonView:updateLabelPosition()
  if self.label then
    self.labelAbsolutePosition = {
      x = self.globalFrame.x + self.labelPosition.x,
      y = self.globalFrame.y + self.labelPosition.y
    }
  end
  if self.tipLabel then
    self.tipLabelAbsolutePosition = {
      x = self.globalFrame.x + self.tipLabelPosition.x,
      y = self.globalFrame.y + self.tipLabelPosition.y
    }
  end
end
-- show the button on specific position
function UIButtonView:show()
  -- draw frame with border color


  -- if selected, draw with highlight
  if self.isSelected then
    screen:clear(self.selectedColor, self.globalFrame)
    screen:clear(self.backgroundColor, self.backgroundArea)
  elseif self.isFocused then
    screen:clear(self.focusedBorderColor, self.globalFrame)
    screen:clear(self.focusedBackgroundColor, self.backgroundArea)
  else
    screen:clear(self.borderColor, self.globalFrame)
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
  
  -- draw tip text,
  if self.tipLabel and self.tipLabelAbsolutePosition then
    SystemFreeType:drawLabel(self.tipLabel,self.tipLabelAbsolutePosition)
  end
  -- end draw text
end

-- make it highlighted
function UIButtonView:selected()
  self.isSelected = true
end

-- make it unSelected
function UIButtonView:unSelected()
  self.isSelected = false
end

-- make it focused
function UIButtonView:focused()
  self.isFocused = true
end

-- make it unFocused
function UIButtonView:unFocused()
  self.isFocused = false
end

-----------------------------------
--@ delegate 
-----------------------------------
--[[UIButtonView.delegate = { onClickEvent = function() end } ]]--
return UIButtonView
