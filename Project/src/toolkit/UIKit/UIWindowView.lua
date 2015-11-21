local UIView = require("toolkit.UIKit.UIView")
local List = require("toolkit.Utils.List")
local ListNode = require("toolkit.Utils.ListNode")
local UIPanelView = require("toolkit.UIKit.UIPanelView")
local Event = require("toolkit.Event")
--local Controllable = require("toolkit.Controllable")

local UIWindowView = extends(UIView)

function UIWindowView:new(args)
  local o = UIWindowView:super{frame=nil--[[args.frame]],container=nil--[[args.container]]}
  --@member window title
  o.title = args.title
  --@member window toolbar, for future development
  --o.toolbar = UIToolBar:new(nil)
  --@member window body which is a blank panel filling with whole window
  o.body = UIPanelView:new{container=o}--[[frame=frame-o.toolbar.frame]]--
  --@member delegate for events process
  --o.footbarHeight = args.footbarHeight or 20
  --o.footbar = UIPanelView:new{frame={x = 0,y = self.frame.h-o.footbarHeight,w = self.frame.w,h = o.footbarHeight},container = o}
  o.focusList = List:new()
  o.focusingView = nil
  self:canvas()
  return UIWindowView:init(o)
end

function UIWindowView:addView(view,weight)
  self.body:addChildView(view)
  self:addToFocusHeap(view,weight)
  if(self.focusList.currentNode ~= nil) then
    self.focusingView = self.focusList:currentNode().view
  end
end

function UIWindowView:canvas()
--code
end

function UIWindowView:addToFocusHeap(view,weight)
  if (view.enableFocus == nil or view.enableFocus== false) and view.children == nil then
    return
  elseif (view.enableFocus == true) then
    local node = ListNode:new{view=view,focusWeight=weight}
    
    -- comparator between two nodes,when node1<=node2 return -1
    function compare(node1,node2)
      return (((node1.value.focusWeight > node2.value.focusWeight) and 1) or -1)
    end
    -- end comparator definition
    self.focusList:push(node,compare)
  elseif view.children ~= nil then
    local views = view:getChildViews()
    for _,v in pairs(views) do
      self:addToFocusHeap(v,weight)
      print("recursive")
    end
  end
end

function UIWindowView:show()
  
  self.focusingView:focused()
  
  -- now we only have body
  self.body:show()
  -- draw title somewhere...
  -- self.toolbar:show() ...
end

function UIWindowView:moveToPreFocus()
  if self.focusingView then
    self.focusingView:unFocused()
    self.focusingView = self.focusList:preNode().view
  end
end

function UIWindowView:moveToNextFocus()
  if self.focusingView then
    self.focusingView:unFocused()
    self.focusingView = self.focusList:nextNode().view
  end
end
-----------------------------------------------------------
-- Judge whether a event is interested by this controllable
-- object,this is typically used when listener notifies
-- @event which will be judged
-----------------------------------------------------------
function UIWindowView:interestInEvent(event)
  return true
end

-----------------------------------------------------------
-- Get event inform form listener
-- @listener which is the listener who send notify message,
--           it is kept for future extention
-- @event which will be judged
-----------------------------------------------------------
function UIWindowView:process(listener,event)
  if event.key == Event.KEY_LEFT and event.state == Event.KEY_STATE_DOWN then
    self:moveToPreFocus()
  elseif event.key == Event.KEY_RIGHT and event.state == Event.KEY_STATE_DOWN then
    self:moveToNextFocus()
  end
end

return UIWindowView
