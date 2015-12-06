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
local script_path = nil
if ADConfig.isSimulator then
  script_path = ""
else
  script_path = sys.root_path()
end

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
  o.selectedColor = args.selectedColor or {r=0,g=100,b=255}
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
    assert(args.identity,"UIButtonView:new(args), args.identity is nil")
    --assert(SystemFreeType[args.identity.."1"]==nil,"UIButtonView:new(args), args.identity exists")
    o.freeTypeCount = 1
    
    o.labelAbsolutePosition = {
      x = o.globalFrame.x + o.labelPosition.x,
      y = o.globalFrame.y + o.labelPosition.y
    }
    if SystemFreeType[o.identity..o.freeTypeCount] == nil then
      SystemFreeType[o.identity..o.freeTypeCount] = sys.new_freetype(o.label.color, o.label.size, o.labelAbsolutePosition,script_path..o.label.font)
    end
    o.labelData = SystemFreeType[o.identity..o.freeTypeCount]
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

  if self.label then
    self.labelAbsolutePosition = {
      x = self.globalFrame.x + self.labelPosition.x,
      y = self.globalFrame.y + self.labelPosition.y
    }
    
    self.freeTypeCount = self.freeTypeCount + 1
    if SystemFreeType[self.identity..self.freeTypeCount] == nil then
      SystemFreeType[self.identity..self.freeTypeCount] = sys.new_freetype(self.label.color, self.label.size, self.labelAbsolutePosition,script_path..self.label.font)
    end
    self.labelData = SystemFreeType[self.identity..self.freeTypeCount]
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
