-- Created by chuck, now it doesn't affect anything.
-- Don't consider this file, just keep it.

local UIWindowView = require("toolkit.UIKit.UIWindowView")
local List = require("toolkit.Utils.List")
local UIPanelView = require("toolkit.UIKit.UIPanelView")
local UIButtonView = require("toolkit.UIKit.UIButtonView")
local UIImage = require("toolkit.UIKit.UIImage")
local UILabel = require("toolkit.UIKit.UILabel")
local Event = require("toolkit.Event")
require("Config/theme")

-- This is a instance window, which is created for using when required

local UIStartWindowView = extends(UIWindowView)

function UIStartWindowView:new()
  local window = UIStartWindowView:super{title="Window Title",backgroundImage=UIImage:new(IMAGE.PLATFORM_BACKGROUND)}

  local bowserImage = UIImage:new{imagePath="data/bowser.png",imageType="png"}
  local marioImage = UIImage:new{imagePath="data/mario.png",imageType="png"}
  local toadImage = UIImage:new{imagePath="data/toad.png",imageType="png"}

  -- create member UIView
  -- if you want button1 accessed, make button1 as member of window
  window.button1 = UIButtonView:new{identity="button1",enableFocus = true,frame={x=0,y=1,w=100,h=100},backgroundImage = bowserImage,button1_click}
  window.button2 = UIButtonView:new{identity="button2",enableFocus = true,frame={x=100,y=1,w=100,h=100},borderWidth = 2,backgroundImage = marioImage}
  window.button3 = UIButtonView:new{identity="button3",enableFocus = true,frame={x=300,y=1,w=100,h=100},borderWidth = 2,backgroundImage = toadImage}
  window.button4 = UIButtonView:new{identity="button4",enableFocus = true,frame={x=500,y=1,w=100,h=100},borderWidth = 2}
  -- this button can't be easy find when accessed from window
  buttonLabel = UILabel:new{text="+ profile",color=COLOR.RED,size=40,font=UILabel.FONT_GROBOLD}
  button5 = UIButtonView:new{identity="button4",enableFocus = true,frame={x=500,y=400,w=300,h=100},borderWidth = 2,label = buttonLabel}
  
  
  -- create layout view to organization them
  local bottomPanel = UIPanelView:new{frame={x=screen:get_width() * 0.05, y = screen:get_height() * 0.3,w=800,h=200}}
  local buttonFrame = {x=10,y=1, w = screen:get_width() * 0.42, h = screen:get_height() * 0.61}
  bottomPanel:addChildView(window.button1)--layout view as member is unnecessary
  bottomPanel:addChildView(window.button2)
  bottomPanel:addChildView(window.button3)
  bottomPanel:addChildView(window.button4)
  window:addChildView(bottomPanel)
  window:addChildView(button5)
  
  -- set properties
  -- two objects with equal hWeight, only the first will be navigated horizontally
  -- two objects with equal vWeight, only the first will be navigated vertically
  -- I should explain more if you don't understand
  window:setFocusWeight{view=window.button1,hWeight=20,vWeight=20}
  window:setFocusWeight{view=window.button2,hWeight=21,vWeight=20}
  window:setFocusWeight{view=window.button3,hWeight=22,vWeight=20}
  window:setFocusWeight{view=window.button4,hWeight=23,vWeight=20}
  window:setFocusWeight{view=button5,hWeight=24,vWeight=23}
  window:setFocusView(window.button2)
  
  window:setShortcutKey(window.button1,Event.KEY_ONE)
  window:setShortcutKey(window.button2,Event.KEY_TWO)
  window:setShortcutKey(window.button3,Event.KEY_THREE)
  window:setShortcutKey(window.button4,Event.KEY_FOUR)
  
  return UIStartWindowView:init(window)
end
return UIStartWindowView
