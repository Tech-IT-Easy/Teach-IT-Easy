local UIWindowView = require("toolkit.UIKit.UIWindowView")
local UIPanelView = require("toolkit.UIKit.UIPanelView")
local UIRectangleView = require("toolkit.UIKit.UIRectangleView")
local UIImage = require("toolkit.UIKit.UIImage")
local UILabel = require("toolkit.UIKit.UILabel")
local THEME = require("games/Catch/data/theme")
local Thief = require("games.Catch.Thief")
local Cop = require("games.Catch.Cop")
-- This is a instance window, which is created for using when required



local UIMainWindowView = UIWindowView:new{title="Window Title",backgroundColor=THEME.COLOR.GREEN}
mainPanel = UIPanelView:new{frame={x=0, y = 0,w=screen:get_width()*0.8,h=screen:get_height()*0.8}}
rightPanel = UIPanelView:new{frame={x=screen:get_width()*0.8, y = 0,w=screen:get_width()*0.2,h=screen:get_height()*0.8},backgroundColor=THEME.COLOR.BLUE}
bottomPanel = UIPanelView:new{frame={x=0, y = screen:get_height() * 0.8,w=screen:get_width(),h=screen:get_height() * 0.2},backgroundColor=THEME.COLOR.RED}
textPanel = UIPanelView:new{frame={x= bottomPanel.frame.w*0.1, y = bottomPanel.frame.h*0.1,w=bottomPanel.frame.w*0.8,h=bottomPanel.frame.h*0.8},backgroundColor=THEME.COLOR.GREEN}
thiefImage = UIImage:new(THEME.IMAGE.THIEF_BACKGROUND)
copImage = UIImage:new(THEME.IMAGE.COP_BACKGROUND)

thief = Thief:new{frame={x=100,y=20,w=100,y=100},image=thiefImage,moveUnit=20}
cop = Cop:new{frame={x=20,y=20,w=100,y=100},image=copImage,moveUnit=20}

mainPanel:addChildView(thief)
mainPanel:addChildView(cop)
UIMainWindowView:addView(mainPanel,2)
UIMainWindowView:addView(rightPanel,2)
local textlabel = UILabel:new{text="A",color=THEME.COLOR.BLUE,size=50,font=UILabel.FONT_GROBOLD}
UIMainWindowView.words = {
  ['a'] = UIRectangleView:new{frame={x=300,y=20,w=80,h=80},borderColor={r=255,g=29,b=25},borderWidth = 4,label=textlabel},
  ['b'] = UIRectangleView:new{frame={x=400,y=20,w=80,h=80},borderColor={r=255,g=29,b=25},borderWidth = 4}
}

for _,v in pairs(UIMainWindowView.words) do
  textPanel:addChildView(v)
end

bottomPanel:addChildView(textPanel)
UIMainWindowView:addView(bottomPanel)
--textlabel = UILabel:new{text="+ profile",color=COLOR.RED,size=40,font=UILabel.FONT_GROBOLD}
--button5 = UIButtonView:new{identity="button4",enableFocus = true,frame={x=500,y=400,w=300,h=100},borderWidth = 2,label = textlabel}
--UIMainWindowView:addView(button5,21)

return UIMainWindowView
