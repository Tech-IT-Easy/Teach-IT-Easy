-----------------------------------------------------------
-- This class manage UIAlertWindowView, create it and show it
--
-- @Author:Created by Chuck, Nov 16,2015
-----------------------------------------------------------

local UIWindowViewController = require("toolkit.UIKit.UIWindowViewController")
local UIAlertWindowView = require('toolkit.UIKit.UIAlertWindowView')


local UIAlertWindowController = extends(UIWindowViewController)

function UIAlertWindowController:new(args)
  local o = UIAlertWindowController:super(UIAlertWindowView:new{title=args.title,OK=args.OK,Cancel=args.Cancel})
  o.callback = args.callback
  return UIAlertWindowController:init(o)
end

function UIAlertWindowController:onClickEvent(sender)
  self.callback(sender)
end

function UIWindowViewController:presentView()--[[sender]]--)
  self.window:show()
  gfx.update()
end



return UIAlertWindowController