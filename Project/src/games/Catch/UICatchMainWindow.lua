local UIWindowView = require("toolkit.UIKit.UIWindowView")
local UIPanelView = require("toolkit.UIKit.UIPanelView")
local UIRectangleView = require("toolkit.UIKit.UIRectangleView")
local UICollectionView = require("toolkit.UIKit.UICollectionView")
local UICollectionCellView = require("toolkit.UIKit.UICollectionCellView")
local UIButtonView = require("toolkit.UIKit.UIButtonView")
local UIImage = require("toolkit.UIKit.UIImage")
local UILabel = require("toolkit.UIKit.UILabel")
local Event = require("toolkit.Event")

local THEME = require("games/Catch/data/theme")
local Thief = require("games.Catch.Thief")
local Cop = require("games.Catch.Cop")

-- This is a instance window, which is created for using when required
local UICatchMainWindow = extends(UIWindowView)

function UICatchMainWindow:new()
  --assert(args.word,"UICatchMainWindow:new(args={word=''}) is nil ")
  local gameBackground = UIImage:new(THEME.IMAGE.GAME_BACKGROUND)
  local window = UICatchMainWindow:super{title="Window Title",backgroundImage=gameBackground}
  -- private data model with <local>
  local thiefImage = UIImage:new(THEME.IMAGE.THIEF_BACKGROUND)
  local copImage = UIImage:new(THEME.IMAGE.COP_BACKGROUND)

  -- components
  window.thief = Thief:new{frame={x=100,y=20,w=100,h=100},image=thiefImage,moveUnit=20}
  window.cop = Cop:new{frame={x=20,y=20,w=100,h=100},image=copImage,moveUnit=20,bonusMoveUnit=20}



  window.words = {
    [1] = UIRectangleView:new{frame={x=300,y=20,w=80,h=80},borderColor=THEME.COLOR.LIGHT_BLUE,borderWidth = 4},
    [2] = UIRectangleView:new{frame={x=400,y=20,w=80,h=80},borderColor=THEME.COLOR.LIGHT_BLUE,borderWidth = 4}
  }

  -- layouts
  local mainPanel = UIPanelView:new{frame={x=0, y = 0,w=screen:get_width()*0.8,h=screen:get_height()*0.8} }


  local bottomPanel = UIPanelView:new{frame={x=0, y = screen:get_height() * 0.8,w=screen:get_width(),h=screen:get_height() * 0.2},backgroundColor=THEME.COLOR.DARK_GRAY}

  mainPanel:addChildView(window.thief)
  mainPanel:addChildView(window.cop)
  window:addChildView(mainPanel)

  for _,v in pairs(window.words) do
    bottomPanel:addChildView(v)
  end
  window:addChildView(bottomPanel)
  
  -- properties of compnents
  ---- code
  -- 
  -- 
  return UICatchMainWindow:init(window)
end

function UICatchMainWindow:initialize(args)
 local characters = args.characters

 local rows = 3
 local columns = 3
 local rightPanel = UICollectionView:new{frame={x=800,y=20,w=400,h=400},space=20,cols=columns,rows=rows,backgroundColor=THEME.COLOR.LIGHT_GRAY}

 local labels = {}
 self.buttons = {}
 local cells = {}

 for i = 1, rows do
   for j = 1, columns do
     local index = (i-1)*rows+j
     labels[index] = UILabel:new{text=characters[index],color=THEME.COLOR.RED,size=50,font=UILabel.FONT_GROBOLD }
     self.buttons[index] = UIButtonView:new{identity="button"..i,enableFocus=true,frame={x=1,y=1,w=100,h=100},borderColor={r=255,g=29,b=25},borderWidth = 6,backgroundImage=nil,label=labels[index] }
     cells[index] = UICollectionCellView:new{view=self.buttons[index],viewType="UIButtonView" }
     self:setShortcutKey(self.buttons[index], Event.formatSystemKey[""..index])
     self:setFocusWeight{view=self.buttons[index], hWeight=1, vWeight=1}
     rightPanel:fillWithCell(cells[index],i-1,j-1)
   end
 end
 self:setFocusView(self.buttons[1]) --Chuck's Magic number :) Dont blame Daniel.
 self:addChildView(rightPanel)
 
 local word = args.word

end

return UICatchMainWindow
