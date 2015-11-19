-----------------------------------------------------------
-- This class is supper class for UI Layout views, usually a 
-- UILayoutView is responsible for managing UIView object.
--
-- @Author:Created by Chuck, NOV 19,2015
-----------------------------------------------------------
local Object = require("toolkit.Object")
local UILayoutView = extends(Object)

function UILayoutView:new()
  local o = UILayoutView:super()
  return UILayoutView:init(o)
end

return UILayoutView

