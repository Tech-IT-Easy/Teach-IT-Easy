local UIWindowView = require("toolkit.UIKit.UIWindowView")
local List = require("toolkit.Utils.List")
local UIPanelView = require("toolkit.UIKit.UIPanelView")
local UIButtonView = require("toolkit.UIKit.UIButtonView")
local UIImage = require("toolkit.UIKit.UIImage")
local UILabel = require("toolkit.UIKit.UILabel")
require("Config/theme")

-- This is a instance window, which is created for using when required



local UIStartWindowView = UIWindowView:new{title="Window Title",backgroundImage=UIImage:new(IMAGE.PLATFORM_BACKGROUND)}

bottomPanel = UIPanelView:new{frame={x=screen:get_width() * 0.05, y = screen:get_height() * 0.3,w=800,h=200}}
buttonFrame = {x=10,y=1, w = screen:get_width() * 0.42, h = screen:get_height() * 0.61}

bowserImage = UIImage:new{imagePath="data/bowser.png",imageType="png"}
marioImage = UIImage:new{imagePath="data/mario.png",imageType="png"}
toadImage = UIImage:new{imagePath="data/toad.png",imageType="png"}
button1 = UIButtonView:new{identity="button1",enableFocus = true,frame={x=0,y=1,w=100,h=100},backgroundImage = bowserImage,button1_click}
button2 = UIButtonView:new{identity="button2",enableFocus = true,frame={x=100,y=1,w=100,h=100},borderWidth = 2,backgroundImage = marioImage}
button3 = UIButtonView:new{identity="button3",enableFocus = true,frame={x=300,y=1,w=100,h=100},borderWidth = 2,backgroundImage = toadImage}
button4 = UIButtonView:new{identity="button4",enableFocus = true,frame={x=500,y=1,w=100,h=100},borderWidth = 2}
bottomPanel:addChildView(button1)
bottomPanel:addChildView(button2)
bottomPanel:addChildView(button3)
bottomPanel:addChildView(button4)
UIStartWindowView:addView(bottomPanel,20)

textlabel = UILabel:new{text="+ profile",color=COLOR.RED,size=40,font=UILabel.FONT_GROBOLD}
button5 = UIButtonView:new{identity="button4",enableFocus = true,frame={x=500,y=400,w=300,h=100},borderWidth = 2,label = textlabel}
UIStartWindowView:addView(button5,21)

return UIStartWindowView
