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

--@member static constant 
UILabelView.FONT_GROBOLD = 'data/GROBOLD.ttf'

function UILabelView:new(args)
  local o = UILabelView:super()
  --@member container which contains this LabelView,default nil which means whole window
  o.container = args.container or nil
  --@member label UILabel type 
  o.label = args.label
  --@member position e.g.{x=1,y=1}
  o.position = args.position
  -- reset coordinate to make this view fit container, also see UIView class about this method
  o:resetCoordinate()
  --@member label data 
  o.labelData = sys.new_freetype(o.label.color, o.label.size, o.position,o.label.font)
  return UILabelView:init(o)
end

function UILabelView:show()
  self.labelData:draw_over_surface(screen, self.label.text)
end

return UILabelView
