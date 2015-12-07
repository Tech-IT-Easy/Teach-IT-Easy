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
  local o = UIImageView:super{frame=args.frame,container=args.container}
  --@member image
  o.image = args.image
  return UIImageView:init(o)
end
function UIImageView:setImage(image)
  self.image = image
end

function UIImageView:show()
  if self.image.imageType == "png" then
    self.image.imageData:premultiply()
  end
  screen:copyfrom(self.image.imageData, nil, self.globalFrame, true)
end

return UIImageView
