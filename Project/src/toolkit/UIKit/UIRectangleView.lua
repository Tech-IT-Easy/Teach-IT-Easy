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