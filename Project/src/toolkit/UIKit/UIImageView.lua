-----------------------------------------------------------
-- This class is a UIView class for showing a Label in specific 
-- position. After label is created, it is constant so that it can't
--  be changed. Although you change it, nothing will happen.
--
-- @Author:Created by Chuck, NOV 19,2015
-----------------------------------------------------------
--
local UIView = require("toolkit.UIKit.UIView")
local UIImageView = extends(UIView)
-- @args = {image = nonnull:UIImage,position=nonnull:{x=1,y=1}}
function UIImageView:new(args)
  local o = UIImageView:super()
  o.container = args.container or nil
  --@member image
  o.image = args.image
  --@member image position
  o.position = args.position
  return UIImageView:init(o)
end

function UIImageView:show()
  self:resetCoordinate()
  screen:copyfrom(self.image.imageData, nil, {x=self.position.x,y=self.position.y,w=self.image.width,h=self.image.height}, true)
end

return UIImageView
