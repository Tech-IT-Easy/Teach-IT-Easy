-----------------------------------------------------------
-- This class is a collection layout which automatically calculate 
-- the width and height based on given rows and cols. Through filled with
-- different cells, a UICollectionView object can manage different UIViews
--
-- @Author:Created by Chuck, NOV 19,2015
-----------------------------------------------------------
local UIView = require("toolkit.UIKit.UIView")
local UIPanelView = extends(UIView)

function UIPanelView:new(args)
  local o = UIPanelView:super{frame=args.frame,container=args.container}
  --@member background color {r=2,g=2,b=3}
  o.backgroundColor = args.backgroundColor or {r=255,g=255,b=255}
  --@member 
  o.children = {}
  return UIPanelView:init(o)
end

-- update position of child view
function UIPanelView:afterPositionChanges()
  for _,view in pairs(self.children) do
    view:getAbsolutePosition()
  end
end

function UIPanelView:addChildView(view)
  table.insert(self.children,view)
  view:setContainer(self)
end

function UIPanelView:show()
  -- draw background
  screen:clear(self.backgroundColor, {x=self.position.x,y=self.position.y,w=self.frame.w,h=self.frame.h})

  for _,view in pairs(self.children) do
    view:show()
  end
end

return UIPanelView