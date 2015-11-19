-----------------------------------------------------------
-- This class is the class for containing a UIView object, such 
-- as a UIButtonView object. Since UICollectionView can only manage
-- UICollectionCellView, which is a medium between UICollectionView and
-- UIView
--
-- @Author:Created by Chuck, NOV 19,2015
-----------------------------------------------------------

local Object = require("toolkit.Object")
local UICollectionCellView = extends(Object)

function UICollectionCellView:new(args)
  local o = UICollectionCellView:super()
  o.view = args.view
  o.viewType = args.viewType
  return UICollectionCellView:init(o)
end

function UICollectionCellView:adjustContent(args)
  if(self.viewType == "UIImageView") then
    self.view.position = {x = args.x,y = args.y}
    self.view.image.width = args.w
    self.view.image.height = args.h
  elseif(self.viewType == "UIButtonView") then
    self.view:setFrame(args)
  end
  -- other types 
end

function UICollectionCellView:show()
  self.view:show()
end

return UICollectionCellView