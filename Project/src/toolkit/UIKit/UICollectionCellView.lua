-----------------------------------------------------------
-- This class is the class for containing a UIView object, such 
-- as a UIButtonView object. Since UICollectionView can only manage
-- UICollectionCellView, which is a medium between UICollectionView and
-- UIView
--
-- @Author:Created by Chuck, NOV 19,2015
-----------------------------------------------------------

local UIView = require("toolkit.UIKit.UIView")
local UICollectionCellView = extends(UIView)

function UICollectionCellView:new(args)
  local o = UICollectionCellView:super{frame=nil,container=args.container}
  --@member view that is managed by this cell
  o.view = args.view
  --@member view type, for future developing
  o.viewType = args.viewType
  return UICollectionCellView:init(o)
end

---- Combine setContainer and setFrame method in UIView 
function UICollectionCellView:fitToCollection(collectionView,frame)
  self.container = collectionView
  self.frame = frame
  self:updateGlobalFrame()  
end

---- @override UIView hook method to update position of child view
function UICollectionCellView:afterUpdateGlobalFrame()
  self.view.container = self
  self.view.frame = {x=0,y=0,w=self.frame.w,h=self.frame.h}
  self.view:updateGlobalFrame()
end

function UICollectionCellView:show()
  self.view:show()
end

return UICollectionCellView