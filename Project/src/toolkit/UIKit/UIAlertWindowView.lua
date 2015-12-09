-----------------------------------------------------------
-- This class can show a popup window with a message and two 
-- button, one of buttons is Cancel and another is OK
--
-- @Author:Created by Chuck, Nov 16,2015
-----------------------------------------------------------

local UIWindowView = require("toolkit.UIKit.UIWindowView")
local List = require("toolkit.Utils.List")
local UIPanelView = require("toolkit.UIKit.UIPanelView")
local UIButtonView = require("toolkit.UIKit.UIButtonView")
local UIImage = require("toolkit.UIKit.UIImage")
local UILabel = require("toolkit.UIKit.UILabel")
local UILabelView = require("toolkit.UIKit.UILabelView")
local Event = require("toolkit.Event")
require("Config/theme")

-- This is a instance window, which is created for using when required

local UIAlertWindowView = extends(UIWindowView)

function UIAlertWindowView:new(args)
  local window = UIAlertWindowView:super{title=args.title,frame={x=(screen:get_width()-400)/2,y=(screen:get_height()-200)/2-100,w=400,h=200},backgroundColor=COLOR.RED}
  
  -- create member UIView
  local titleLabel = UILabel:new{identity="titleLabel",text=args.title,color=COLOR.RED,size=20,font=UILabel.FONT_GROBOLD}
  window.titleLabelView = UILabelView:new{identity="alterWindowTitleLabel",frame={x=20,y=50,w=200,h=80},label=titleLabel}
  
  local OKLabel = UILabel:new{identity="OKLabel",text=args.OK or "OK",color=COLOR.DARK_GRAY,size=20,font=UILabel.FONT_GROBOLD}
  window.OKButton = UIButtonView:new{identity="OK",enableFocus = true,frame={x=200,y=10,w=80,h=30},borderWidth = 2,label=OKLabel,labelPosition={x=10,y=5}}
  local CancelLabel = UILabel:new{identity="CancelLabel",text=args.Cancel or "Cancel",color=COLOR.DARK_GRAY,size=20,font=UILabel.FONT_GROBOLD}
  window.CancelButton = UIButtonView:new{identity="Cancel",enableFocus = true,frame={x=80,y=10,w=80,h=30},borderWidth = 2,label = CancelLabel,labelPosition={x=10,y=5}}
  
  -- create layout view to organization them
  local titlePanel = UIPanelView:new{frame={x=0, y = 0, w=400, h = 150},backgroundColor=COLOR.DARK_GRAY}
  titlePanel:addChildView(window.titleLabelView)
  window:addChildView(titlePanel)
  
  local buttonPanel = UIPanelView:new{frame={x=0, y = 150, w=400, h = 50},backgroundColor=COLOR.LIGHT_GRAY}
  buttonPanel:addChildView(window.OKButton)
  buttonPanel:addChildView(window.CancelButton)
  window:addChildView(buttonPanel)
  
  -- set properties
  window:setFocusWeight{view=window.OKButton,hWeight=2,vWeight=20}
  window:setFocusWeight{view=window.CancelButton,hWeight=1,vWeight=20}
  window:setFocusView(window.OKButton)
  
  return UIAlertWindowView:init(window)
end
return UIAlertWindowView
