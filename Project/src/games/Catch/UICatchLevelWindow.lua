local UIWindowView = require("toolkit.UIKit.UIWindowView")
local UIPanelView = require("toolkit.UIKit.UIPanelView")
--[[local UIRectangleView = require("toolkit.UIKit.UIRectangleView")
local UICollectionView = require("toolkit.UIKit.UICollectionView")
local UICollectionCellView = require("toolkit.UIKit.UICollectionCellView")
local UIButtonView = require("toolkit.UIKit.UIButtonView")
]]--
local UILabelView = require("toolkit.UIKit.UILabelView")

local UILabel = require("toolkit.UIKit.UILabel")

local UIImage = require("toolkit.UIKit.UIImage")
local Event = require("toolkit.Event")
local THEME = require("games/Catch/data/theme")

-- This is a instance window, which is created for using when required
local UICatchLevelWindow = extends(UIWindowView)

function UICatchLevelWindow:new()
  local window = UICatchLevelWindow:super{title="Window Title",backgroundImage=UIImage:new(THEME.IMAGE.GAME_BACKGROUND)}

  -- private data model with <local>
  -- components
  window.buttons = {}
  --local textLabel = UILabel:new{text="CHOOSE LEVEL",color=THEME.COLOR.WHITE,size=70,font=UILabel.FONT_GROBOLD} 
  --window.title = UILabelView:new{frame={x=400,y=20,w=0,h=0},label=textLabel}

  -- calculate menuPanel width,height,pisition based on menu item size
  local menuPanelWidth = (THEME.LEVEL.RECTANGLE_SIZE + THEME.LEVEL.RECTANGLE_SPACE) * THEME.LEVEL.COLUMNS - THEME.LEVEL.RECTANGLE_SPACE
  local menuPanelHeight = (THEME.LEVEL.RECTANGLE_SIZE + THEME.LEVEL.RECTANGLE_SPACE) * THEME.LEVEL.ROWS - THEME.LEVEL.RECTANGLE_SPACE
  local menuPanelAlignCenterPosition = {x=(screen:get_width()-menuPanelWidth)/2,y = (screen:get_height()-menuPanelHeight)/2}
  
  window.menuPanel = UIPanelView:new{frame={x=menuPanelAlignCenterPosition.x, y = menuPanelAlignCenterPosition.y,w=menuPanelWidth,h=menuPanelHeight}}--,backgroundColor=THEME.COLOR.DARK_GRAY}
  --window.collectionPanel = UICollectionView:new{frame={x=0,y=0,w=menuPanelWidth,h=menuPanelHeight},space=THEME.LEVEL.RECTANGLE_SPACE,cols=THEME.LEVEL.COLUMNS,rows=THEME.LEVEL.ROWS}--,backgroundColor=THEME.COLOR.LIGHT_GRAY}
  --window.menuPanel:addChildView(window.collectionPanel)
  --layout menu items with collection layout view
  --[[local labels = {}
  local cells = {}
  local textAlignCenterPosition = {x=(THEME.LEVEL.RECTANGLE_SIZE - THEME.LEVEL.FONT_SIZE)/2,y=(THEME.LEVEL.RECTANGLE_SIZE - THEME.LEVEL.FONT_SIZE)/2}
  for i = 1, THEME.LEVEL.ROWS do
    for j = 1, THEME.LEVEL.COLUMNS do
      local index = (i-1) * THEME.LEVEL.COLUMNS + j
        labels[index] = UILabel:new{text=index.."",color=THEME.COLOR.DARK_GRAY_1,size=THEME.MENU.FONT_SIZE,font=UILabel.FONT_GROBOLD }
        window.buttons[index] = UIButtonView:new{identity="button"..i,enableFocus=true,frame=THEME.FRAME.BUTTON,borderColor=THEME.COLOR.DARK_GRAY_1,borderWidth = THEME.MENU.BORDER_WIDTH,label=labels[index],labelPosition=textAlignCenterPosition}
        cells[index] = UICollectionCellView:new{view=window.buttons[index],viewType="UIButtonView" }
        window:setFocusWeight{view=window.buttons[index], hWeight=index, vWeight=i}
        window.collectionPanel:fillWithCell(cells[index],i-1,j-1)
    end
  end
  window:setFocusView(window.buttons[1])]]--
  window:addChildView(window.menuPanel)
  --window:addChildView(window.title)

  return UICatchLevelWindow:init(window)
end

function UICatchLevelWindow:initialize(args)
  self.levels = args.levels
  --.. do some layout based on levels
end
return UICatchLevelWindow
