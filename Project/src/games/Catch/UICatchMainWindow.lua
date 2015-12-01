local UIWindowView = require("toolkit.UIKit.UIWindowView")
local UIPanelView = require("toolkit.UIKit.UIPanelView")
local UIRectangleView = require("toolkit.UIKit.UIRectangleView")
local UIImage = require("toolkit.UIKit.UIImage")
local UILabel = require("toolkit.UIKit.UILabel")
local THEME = require("games/Catch/data/theme")
local Thief = require("games.Catch.Thief")
local Cop = require("games.Catch.Cop")

-- This is a instance window, which is created for using when required
local UICatchMainWindow = extends(UIWindowView)

function UICatchMainWindow:new()
  --assert(args.word,"UICatchMainWindow:new(args={word=''}) is nil ")
  local window = UICatchMainWindow:super{title="Window Title",backgroundColor=THEME.COLOR.GREEN}
  -- private data model with <local>
  local thiefImage = UIImage:new(THEME.IMAGE.THIEF_BACKGROUND)
  local copImage = UIImage:new(THEME.IMAGE.COP_BACKGROUND)
  local textlabel = UILabel:new{text="A",color=THEME.COLOR.BLUE,size=50,font=UILabel.FONT_GROBOLD}
  
  -- components
  window.thief = Thief:new{frame={x=100,y=20,w=100,y=100},image=thiefImage,moveUnit=20}
  window.cop = Cop:new{frame={x=20,y=20,w=100,y=100},image=copImage,moveUnit=20,bonusMoveUnit=80}
  --window.word = args.word
  window.cop:run(true)
  window.thief:run(false)
  
  print(window.cop:catch(window.thief))
  
  --[[for i=0,string.len(window.word) do
    window.wordsRectangle[i] = UIRectangleView:new{frame={x=300,y=20,w=80,h=80},borderColor={r=255,g=29,b=25},borderWidth = 4},
  end
  ]]--
  
  window.words = {
    ['a'] = UIRectangleView:new{frame={x=300,y=20,w=80,h=80},borderColor={r=255,g=29,b=25},borderWidth = 4,label=textlabel},
    ['b'] = UIRectangleView:new{frame={x=400,y=20,w=80,h=80},borderColor={r=255,g=29,b=25},borderWidth = 4}
  }

  -- layouts
  local mainPanel = UIPanelView:new{frame={x=0, y = 0,w=screen:get_width()*0.8,h=screen:get_height()*0.8}}
  local rightPanel = UIPanelView:new{frame={x=screen:get_width()*0.8, y = 0,w=screen:get_width()*0.2,h=screen:get_height()*0.8},backgroundColor=THEME.COLOR.BLUE}
  local bottomPanel = UIPanelView:new{frame={x=0, y = screen:get_height() * 0.8,w=screen:get_width(),h=screen:get_height() * 0.2},backgroundColor=THEME.COLOR.RED}
  local textPanel = UIPanelView:new{frame={x= bottomPanel.frame.w*0.1, y = bottomPanel.frame.h*0.1,w=bottomPanel.frame.w*0.8,h=bottomPanel.frame.h*0.8},backgroundColor=THEME.COLOR.GREEN}

  mainPanel:addChildView(window.thief)
  mainPanel:addChildView(window.cop)
  window:addChildView(mainPanel)
  
  window:addChildView(rightPanel)

  for _,v in pairs(window.words) do
    textPanel:addChildView(v)
  end
  bottomPanel:addChildView(textPanel)
  window:addChildView(bottomPanel)
  
  -- properties of compnents
  ---- code
  -- 
  -- 
  return UICatchMainWindow:init(window)
end

return UICatchMainWindow
