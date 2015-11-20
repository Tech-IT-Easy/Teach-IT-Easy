-----------------------------------------------------------
-- This class is supper class for UI views, usually a UIView 
-- class should contain a specific UIType such as UILabel or 
-- UIImage to show them
--
-- @Author:Created by Chuck, NOV 19,2015
-----------------------------------------------------------
local Object = require("toolkit.Object")
local UIView = extends(Object)

function UIView:new(args)
  local o = UIView:super()
  --@member frame UIView class default frame is window screen
  o.frame = (args and args.frame) or {x = 0,y = 0,w = screen:get_width(),h = screen:get_height()}
  
  --@member container which contains this UIView,default nil which means whole window
  o.container = (args and args.container) or {frame={x = 0,y = 0,w = screen:get_width(),h = screen:get_height()},position={x=0,y=0}}
  
  --@member absolute position,which should be used when show something on screen
  o.position = {x = o.frame.x + o.container.position.x, y = o.frame.y + o.container.position.y}
  return UIView:init(o)
end

function UIView:afterPositionChanges()
  -- code implemented by subclass
end


function UIView:getAbsolutePosition()
  self.position = {x = self.frame.x + self.container.position.x, y = self.frame.y + self.container.position.y}
  self:afterPositionChanges()
end


function UIView:setContainer(container)
  self.container = container
  self:getAbsolutePosition()
end

function UIView:setFrame(frame)
  self.frame = frame
  self:getAbsolutePosition()
end

WINDOW = UIView:new(nil)

return UIView
