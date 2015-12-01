-- Created by chuck, now it doesn't affect anything. 
-- Don't consider this file, just keep it.

local UIWindowViewController = require("toolkit.UIKit.UIWindowViewController")
local UICatchMainWindow = require('games.Catch.UICatchMainWindow')


local UICatchMainWindowController = extends(UIWindowViewController)

function UICatchMainWindowController:new()
  local o = UICatchMainWindowController:super(UICatchMainWindow:new())
  --o.window.button1.delegate = o
  --o.window.button2.delegate = o
  o.window.cop:print()
  return UICatchMainWindowController:init(o)
end

function UICatchMainWindowController:onClickEvent(sender)
  if sender.identity == "button1" then
    print("I know who you are:"..sender.identity)
  elseif sender.identity == "button2" then
    print("I know who you are:"..sender.identity)
  end
end

function UICatchMainWindowController:button1_OnClickEvent()
  print("button 1 delegate")
end

function UICatchMainWindowController:button2_OnClickEvent()
  print("button 2 delegate")
end

--[[

local GameWindowController = require("games.Catch.UICatchMainWindowController")
local UILabel = require("toolkit.UIKit.UILabel")
local THEME = require("games/Catch/data/theme")
GameWindowController:new():presentView()

]]--

return UICatchMainWindowController