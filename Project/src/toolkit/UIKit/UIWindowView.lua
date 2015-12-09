-----------------------------------------------------------
-- This class is super class of a window, which will be shown
-- as a full screen container. UIView classes can be added into
-- a window
--
-- @Author:Created by Chuck, Nov 16,2015
-----------------------------------------------------------
--
local UIView = require("toolkit.UIKit.UIView")
local List = require("toolkit.Utils.List")
local ListNode = require("toolkit.Utils.ListNode")
local UIPanelView = require("toolkit.UIKit.UIPanelView")

--local Controllable = require("toolkit.Controllable")

local UIWindowView = extends(UIView)

function UIWindowView:new(args)
  local o = UIWindowView:super{frame=args.frame or nil,container=args.container or nil}
  --@member window title
  o.title = args.title
  --@member window toolbar, for future development
  --o.toolbar = UIToolBar:new(nil)
  --@member window body which is a blank panel filling with whole window
  
  o.body = UIPanelView:new{container=o,frame={x=0,y=0,w=o.frame.w,h=o.frame.h},backgroundImage = args.backgroundImage,backgroundColor=args.backgroundColor}--[[frame=frame-o.toolbar.frame]]--
  --@member delegate for events process
  --o.footbarHeight = args.footbarHeight or 20
  --o.footbar = UIPanelView:new{frame={x = 0,y = self.frame.h-o.footbarHeight,w = self.frame.w,h = o.footbarHeight},container = o}
  o.horizontalFocusConfig = List:new()
  o.verticalFocusConfig = List:new()
  o.shortcuts = {}
  o.focusingView = nil
  o.enterEnable = true
  return UIWindowView:init(o)
end

function UIWindowView:addChildView(view)
  assert(view,"UIWindowView:addChildView(view),error: view is nil")
  self.body:addChildView(view)
end


-- private 
-- comparator between two nodes,when node1<=node2 return -1  
local function compare(node1,node2)
  if node1.value.focusWeight > node2.value.focusWeight then
    return  1
  elseif node1.value.focusWeight < node2.value.focusWeight then
    return -1
  else
    return 0
  end
end

local function compareView(node1,node2)
  if node1.value.view == node2.value.view then
    return 0
  else
    return 1
  end
end

function UIWindowView:setFocusWeight(args)
  assert(args,"UIWindowView:setFocusWeight({view=view,hWeight=hWeight,vWeight=vWeight}),error: args is nil")
  assert(args.view and args.view.enableFocus,"UIWindowView:setFocusWeight({view=view...}),error: view is nil or view.enableFocus is false ")
  assert(args.hWeight or vWeight,"UIWindowView:setFocusWeight({view=view,hWeight=hWeight,vWeight=vWeight}),error: hWeight and vWeight are both nil")

  if args.hWeight then
    local node = ListNode:new{view=args.view,focusWeight=args.hWeight}
    self.horizontalFocusConfig:push(node,compare)
  end
  
  if args.vWeight then
    local node = ListNode:new{view=args.view,focusWeight=args.vWeight}
    self.verticalFocusConfig:push(node,compare)
  end

  ADLogger.trace("UIWindowView:setFocusWeight({view=view,hWeight="..(args.hWeight or "nil")..",vWeight="..(args.vWeight or "nil")..")")
end

function UIWindowView:setFocusView(view)
  assert(view,"UIWindowView:setFocusView(view),error: view is nil")
  assert(self.horizontalFocusConfig.currentNode or self.verticalFocusConfig.currentNode,"UIWindowView:setFocusView(view),error: never set any weight with setFocusWeight method")
  
  if self.focusingView then
    self.focusingView:unFocused()
  end
  local node = ListNode:new{view=view,focusWeight=nil}
  
  if self.horizontalFocusConfig.current then
    self.horizontalFocusConfig:setCurrentNode(node,compareView)
  end
  
  if self.verticalFocusConfig.current then
    self.verticalFocusConfig:setCurrentNode(node,compareView)
  end 
  
  self.focusingView = view--self.horizontalFocusConfig:currentNode().view
  
  ADLogger.trace("UIWindowView:setFocusView(view)")
end


function UIWindowView:setShortcutKey(view,key)
  assert(view and view.enableFocus,"UIWindowView:setShortcutKey(view,"..key.."), error:view is nil or view.enableFocus is false")
  assert(self.shortcuts[key]==nil,"UIWindowView:setShortcutKey(view,"..key.."), error:repeated key")

  self.shortcuts[key] = view
  
  ADLogger.trace("setShortcutKey(view,"..key..")")
end

function UIWindowView:moveTofocusByKey(key)
  if self.shortcuts[key] then
    assert(self.horizontalFocusConfig.first,"UIWindowView:moveTofocusByKey("..key.."),error: no enable focused view in current window ")
    
    self.focusingView:unFocused()
    self.focusingView = self.shortcuts[key]
    local node = ListNode:new{view=self.focusingView,focusWeight=nil}
    self.horizontalFocusConfig:setCurrentNode(node,compareView)
    self.verticalFocusConfig:setCurrentNode(node,compareView)
    ADLogger.trace("UIWindowView:moveTofocusByKey("..key..")")
    return true
  end
  return false
end

function UIWindowView:show()
  if self.focusingView then
    self.focusingView:focused()
  end
  -- now we only have body
  self.body:show()
  -- draw title somewhere...
  -- self.toolbar:show() ...
end

function UIWindowView:moveToPreFocus()
  if self.focusingView then
    self.focusingView:unFocused()
    local node = self.horizontalFocusConfig:preDifferNode(compare)
    self.focusingView = node.value.view
    self.verticalFocusConfig:setCurrentNode(node,compareView)
  end
end

function UIWindowView:moveToNextFocus()
  if self.focusingView then
    self.focusingView:unFocused()
    local node = self.horizontalFocusConfig:nextDifferNode(compare)
    self.focusingView = node.value.view
    self.verticalFocusConfig:setCurrentNode(node,compareView)
  end
end

function UIWindowView:moveToUpFocus()
  if self.focusingView then
    self.focusingView:unFocused()
    local node = self.verticalFocusConfig:preDifferNode(compare)
    self.focusingView = node.value.view
    self.horizontalFocusConfig:setCurrentNode(node,compareView)
  end
end

function UIWindowView:moveToDownFocus()
  if self.focusingView then
    self.focusingView:unFocused()
    local node = self.verticalFocusConfig:nextDifferNode(compare)
    self.focusingView = node.value.view
    self.horizontalFocusConfig:setCurrentNode(node,compareView)
  end
end

return UIWindowView
