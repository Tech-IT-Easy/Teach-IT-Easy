-- Created by chuck, now it doesn't affect anything. 
-- Don't consider this file, just keep it.

local UIWindowViewController = require("toolkit.UIKit.UIWindowViewController")
local UIAlertWindowView = require('toolkit.UIKit.UIAlertWindowView')


local UIAlertWindowController = extends(UIWindowViewController)

function UIAlertWindowController:new(args)
  local o = UIAlertWindowController:super(UIAlertWindowView:new{title=args.title})
  o.callback = args.callback
  return UIAlertWindowController:init(o)
end

function UIAlertWindowController:onClickEvent(sender)
  self.callback(sender)
  --[[if sender.identity == "button1" then
    print("I know who you are:"..sender.identity)
  elseif sender.identity == "button2" then
    print("I know who you are:"..sender.identity)
  end
  ]]--
end
function onKeyEvent(listener,event)
  print("controllere ")
end

function UIWindowViewController:presentView()--[[sender]]--)
  self.window:show()
  gfx.update()
end



return UIAlertWindowController