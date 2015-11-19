-----------------------------------------------------------
-- This class is supper class for UI views, usually a UIView 
-- class should contain a specific UIType such as UILabel or 
-- UIImage to show them
--
-- @Author:Created by Chuck, NOV 19,2015
-----------------------------------------------------------
local Object = require("toolkit.Object")
local UIView = extends(Object)

function UIView:new()
  local o = UIView:super()
  --@member frame UIView class default frame is window screen
  o.frame = {x = 0,y = 0,w = screen:get_width(),h = screen:get_height()}
  
  return UIView:init(o)
end

function UIView:resetCoordinate()
  -- if there is a container, make position relative to container
  if self.container then
    self.position.x = self.position.x + self.container.frame.x
    self.position.y = self.position.y + self.container.frame.y
  end
end

return UIView
