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
  o.container = (args and args.container) or {frame={x = 0,y = 0,w = screen:get_width(),h = screen:get_height()},globalFrame={x = 0,y = 0,w = screen:get_width(),h = screen:get_height()}}
  
  --@member absolute position,which should be used when show something on screen
  o.globalFrame = {x = o.frame.x + o.container.globalFrame.x, y = o.frame.y + o.container.globalFrame.y,w = o.frame.w,h = o.frame.h}
  return UIView:init(o)
end

function UIView:afterUpdateGlobalFrame()
  -- code implemented by subclass
end


function UIView:updateGlobalFrame()
  self.globalFrame = {x = self.frame.x + self.container.globalFrame.x, y = self.frame.y + self.container.globalFrame.y,w = self.frame.w,h = self.frame.h}
  self:afterUpdateGlobalFrame()
end


function UIView:setContainer(container)
  self.container = container
  self:updateGlobalFrame()
end

function UIView:setFrame(frame)
  self.frame = frame
  self:updateGlobalFrame()
end

WINDOW = UIView:new(nil)

return UIView
