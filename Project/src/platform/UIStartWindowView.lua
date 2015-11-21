local UIWindowView = require("toolkit.UIKit.UIWindowView")
local List = require("toolkit.Utils.List")
local UIPanelView = require("toolkit.UIKit.UIPanelView")
local UIButtonView = require("toolkit.UIKit.UIButtonView")
local UIImage = require("toolkit.UIKit.UIImage")
--local Controllable = require("toolkit.Controllable")

local UIStartWindowView = UIWindowView:new{title="Window Title"}

bottomPanel = UIPanelView:new{frame={x=0,y=120,w=800,h=80}}
image = UIImage:new{imagePath="games/mario/data/arrow_up.png",imageType="png"}
button1 = UIButtonView:new{enableFocus = true,frame={x=1,y=1,w=100,h=100},borderColor={r=255,g=29,b=25},borderWidth = 6,backgroundImage=image}
button2 = UIButtonView:new{enableFocus = true,frame={x=100,y=1,w=100,h=100},borderColor={r=255,g=29,b=25},borderWidth = 6,backgroundImage=image}
button3 = UIButtonView:new{enableFocus = true,frame={x=200,y=1,w=100,h=100},borderColor={r=255,g=29,b=25},borderWidth = 6,backgroundImage=image}
button4 = UIButtonView:new{enableFocus = true,frame={x=300,y=1,w=100,h=100},borderColor={r=255,g=29,b=25},borderWidth = 6,backgroundImage=image}
bottomPanel:addChildView(button1)
bottomPanel:addChildView(button2)
bottomPanel:addChildView(button3)
bottomPanel:addChildView(button4)
UIStartWindowView:addView(bottomPanel,20)

button5 = UIButtonView:new{enableFocus = true,frame={x=300,y=400,w=100,h=100},borderColor={r=255,g=29,b=25},borderWidth = 6,backgroundImage=image}
UIStartWindowView:addView(button5,5)

return UIStartWindowView
