-- Created by chuck, now it doesn't affect anything. 
-- Don't consider this file, just keep it.

local UIWindowViewController = require("toolkit.UIKit.UIWindowViewController")
local UIStartWindowView = require('platform.UIStartWindowView')


local UIStartWindowController = extends(UIWindowViewController)

function UIStartWindowController:new()
  local o = UIStartWindowController:super(UIStartWindowView:new())
  o.window.button1.delegate = o
  o.window.button2.delegate = o
  return UIStartWindowController:init(o)
end

function UIStartWindowController:onClickEvent(sender)
  if sender.identity == "button1" then
    print("I know who you are:"..sender.identity)
  elseif sender.identity == "button2" then
    print("I know who you are:"..sender.identity)
  end
end

function UIStartWindowController:button1_OnClickEvent()
  print("button 1 delegate")
end

function UIStartWindowController:button2_OnClickEvent()
  print("button 2 delegate")
end

return UIStartWindowController