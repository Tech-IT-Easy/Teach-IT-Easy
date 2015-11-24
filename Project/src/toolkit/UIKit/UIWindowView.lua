local UIView = require("toolkit.UIKit.UIView")
local List = require("toolkit.Utils.List")
local ListNode = require("toolkit.Utils.ListNode")
local UIPanelView = require("toolkit.UIKit.UIPanelView")

--local Controllable = require("toolkit.Controllable")

local UIWindowView = extends(UIView)

function UIWindowView:new(args)
  local o = UIWindowView:super{frame=nil--[[args.frame]],container=nil--[[args.container]]}
  --@member window title
  o.title = args.title
  --@member window toolbar, for future development
  --o.toolbar = UIToolBar:new(nil)
  --@member window body which is a blank panel filling with whole window
  o.body = UIPanelView:new{container=o,backgroundImage = args.backgroundImage,backgroundColor=args.backgroundColor}--[[frame=frame-o.toolbar.frame]]--
  --@member delegate for events process
  --o.footbarHeight = args.footbarHeight or 20
  --o.footbar = UIPanelView:new{frame={x = 0,y = self.frame.h-o.footbarHeight,w = self.frame.w,h = o.footbarHeight},container = o}
  o.focusList = List:new()
  o.shortcuts = {}
  o.focusingView = nil
  return UIWindowView:init(o)
end


function UIWindowView:setShortcutKey(view,key)
  assert(view and view.enableFocus,"UIWindowView:setShortcutKey(view,"..key.."), error:view is nil or view.enableFocus is false")
  assert(self.shortcuts[key]==nil,"UIWindowView:setShortcutKey(view,"..key.."), error:repeated key")
  
  self.shortcuts[key] = view
  print(self.shortcuts[5])
  ADLogger.trace("setShortcutKey(view,"..key..")")
end

function UIWindowView:moveTofocusByKey(key)
  assert(self.focusList.first,"UIWindowView:moveTofocusByKey("..key.."),error: no enable focused view in current window ")
  if self.shortcuts[key] then
    self.focusingView:unFocused()
    self.focusingView = self.shortcuts[key]
    self.focusList:setCurrentNode(self.focusingView)
    ADLogger.trace("UIWindowView:moveTofocusByKey("..key..")")
  end
end

function UIWindowView:addView(view,weight)
  self.body:addChildView(view)
  self:addToFocusHeap(view,weight)
  if self.focusList.currentNode then
    self.focusingView = self.focusList:currentNode().view
  end
end

function UIWindowView:addToFocusHeap(view,weight)
  if weight == nil then
    return
  end
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

return UIWindowView
