-----------------------------------------------------------
-- This class is supper class for UI Layout views, usually a 
-- UILayoutView is responsible for managing UIView object.
--
-- @Author:Created by Chuck, NOV 19,2015
-----------------------------------------------------------
local UIView = require("toolkit.UIKit.UIView")
local UILayoutView = extends(UIView)

function UILayoutView:new(args)
  local o = UILayoutView:super{frame=args.frame,container=args.container}
  return UILayoutView:init(o)
end

return UILayoutView

