local UIView = require("toolkit.UIKit.UIView")
local UIRectangleView = extends(UIView)

local script_path = nil
if ADConfig.isSimulator then
  script_path = ""
else
  script_path = sys.root_path()
end

function UIRectangleView:new(args)
  local o = UIRectangleView:super{frame=args.frame,container=args.container}
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
    o.labelData = sys.new_freetype(o.label.color, o.label.size, o.labelAbsolutePosition,script_path..o.label.font)
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
    self.labelData = sys.new_freetype(self.label.color, self.label.size, self.labelAbsolutePosition,script_path..self.label.font)
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
  if self.label and self.labelData then
    self.labelData:draw_over_surface(screen, self.label.text)
  end
  -- end draw text
end

return UIRectangleView