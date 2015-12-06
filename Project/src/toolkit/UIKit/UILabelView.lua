-----------------------------------------------------------
-- This class is a UIView class for showing a Label in specific
-- position. After label is created, it is constant so that it can't
--  be changed. Although you change it, nothing will happen.
--
-- @Author:Created by Chuck, NOV 19,2015
-----------------------------------------------------------
--
local UIView = require("toolkit.UIKit.UIView")
local UILabelView = extends(UIView)
SystemFreeType = require("toolkit.UIKit.UISystemFreeType")
--@member static constant
UILabelView.FONT_GROBOLD = 'data/GROBOLD.ttf'
UILabelView.FONT_CHALKDUSTER = 'data/Chalkduster.ttf'

local script_path = nil
if ADConfig.isSimulator then
  script_path = ""
else
  script_path = sys.root_path()
end

function UILabelView:new(args)
  --@member container which contains this LabelView,default nil which means whole window
  local o = UILabelView:super({frame=args.frame,container=args.container})
  --@member label UILabel type
  o.label = args.label
  --@member label data
  assert(args.identity,"UILabelView:new(args), args.identity is nil")
  --assert(SystemFreeType[args.identity.."1"]==nil,"UILabelView:new(args), args.identity exists")
  
  
  o.identity = args.identity
  o.freeTypeCount = 1
  if SystemFreeType[o.identity..o.freeTypeCount] == nil then
    SystemFreeType[o.identity..o.freeTypeCount] = sys.new_freetype(o.label.color, o.label.size, {x = o.globalFrame.x,y = o.globalFrame.y},script_path..o.label.font)
  end
  o.labelData = SystemFreeType[o.identity..o.freeTypeCount]--sys.new_freetype(o.label.color, o.label.size, {x = o.globalFrame.x,y = o.globalFrame.y},script_path..o.label.font)
  
  return UILabelView:init(o)
end

function UILabelView:show()
  self.labelData:draw_over_surface(screen, self.label.text)
end

function UILabelView:afterUpdateGlobalFrame()
  self.freeTypeCount = self.freeTypeCount + 1
  if SystemFreeType[self.identity..self.freeTypeCount] == nil then
    SystemFreeType[self.identity..self.freeTypeCount] = sys.new_freetype(self.label.color, self.label.size,{x = self.globalFrame.x,y = self.globalFrame.y},script_path..self.label.font)
  end
  self.labelData = SystemFreeType[self.identity..self.freeTypeCount]
end

return UILabelView
