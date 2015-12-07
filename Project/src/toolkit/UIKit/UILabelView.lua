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

function UILabelView:new(args)
  --@member container which contains this LabelView,default nil which means whole window
  local o = UILabelView:super({frame=args.frame,container=args.container})
  --@member label UILabel type
  o.label = args.label
  --@member label data
  assert(args.identity,"UILabelView:new(args), args.identity is nil")

  return UILabelView:init(o)
end

function UILabelView:show()
  SystemFreeType:drawLabel(self.label,{x = self.globalFrame.x,y = self.globalFrame.y})
end

return UILabelView
