-----------------------------------------------------------
-- This class is the class for showing a button, which can be
-- configured based on its properties
--
-- @Author:Created by Chuck, NOV 19,2015
-----------------------------------------------------------
local UIView = require("toolkit.UIKit.UIView")
local UIButtonView = extends(UIView)

-- args = {frame={x=1,y=1,w=50,h=50},}
function UIButtonView:new(args)
  local o = UIButtonView:super{frame=args.frame,container=args.container}
  -- @member background image
  o.backgroundImage = args.backgroundImage or nil
  -- @member background color
  o.backgroundColor = args.backgroundColor or {r=255,g=255,b=255}
  -- @member border color
  o.borderColor = args.borderColor or {r=0,g=0,b=0}
  -- @member border width, default is 2
  o.borderWidth = args.borderWidth or 2
  -- @member marked as selected, default is false
  o.isSelected = args.isSelected or false
  -- @member hightlight color
  o.selectedColor = args.selectedColor or {r=0,g=100,b=255}
  -- @member label
  o.label = args.label or nil
  -- @member label position
  o.labelPosition = args.labelPosition or {x=0,y=0}
  -- @member background area = frame - borderWidth
  o.backgroundArea = {
    x = o.position.x + o.borderWidth,
    y = o.position.y + o.borderWidth,
    w = o.frame.w - 2*o.borderWidth,
    h = o.frame.h - 2*o.borderWidth
  }
  -- @member labelData 
  -- firstly change position relative to button frame
  if o.label then
    o.labelAbsolutePosition = {
      x = o.position.x + o.labelPosition.x,
      y = o.position.y + o.labelPosition.y
    }
    o.labelData = sys.new_freetype(o.label.color, o.label.size, o.labelAbsolutePosition,o.label.font)
  end
  
  return UIButtonView:init(o)
end

--------------------------------------------------
--@ override UIView method
--since labelData needs to be created before shown
--------------------------------------------------
function UIButtonView:afterPositionChanges()

  self.backgroundArea = {
    x = self.position.x + self.borderWidth,
    y = self.position.y + self.borderWidth,
    w = self.frame.w - 2*self.borderWidth,
    h = self.frame.h - 2*self.borderWidth
  }
 
  if self.label then
    self.labelAbsolutePosition = {
      x = self.position.x + self.labelPosition.x,
      y = self.position.y + self.labelPosition.y
    }
    self.labelData = sys.new_freetype(self.label.color, self.label.size, self.labelAbsolutePosition,self.label.font)
  end
end

-- show the button on specific position
function UIButtonView:show()
  -- draw frame with border color
  -- if selected, draw with highlight
  if self.isSelected then
      screen:clear(self.selectedColor, self.frame)
  else
      screen:clear(self.borderColor, self.frame)
  end
  
  -- draw background with background color
  screen:clear(self.backgroundColor, self.backgroundArea)

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
  if self.label and self.labelData then
    self.labelData:draw_over_surface(screen, self.label.text)
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

return UIButtonView
