local UIWindowView = require("toolkit.UIKit.UIWindowView")
local UIPanelView = require("toolkit.UIKit.UIPanelView")
local UIRectangleView = require("toolkit.UIKit.UIRectangleView")
local UICollectionView = require("toolkit.UIKit.UICollectionView")
local UICollectionCellView = require("toolkit.UIKit.UICollectionCellView")
local UIButtonView = require("toolkit.UIKit.UIButtonView")
local UIImageView = require("toolkit.UIKit.UIImageView")
local UIImage = require("toolkit.UIKit.UIImage")
local UILabel = require("toolkit.UIKit.UILabel")
local Event = require("toolkit.Event")
local THEME = require("games/Catch/data/theme")
local Thief = require("games.Catch.Thief")
local Cop = require("games.Catch.Cop")

-- This is a instance window, which is created for using when required
local UICatchMainWindow = extends(UIWindowView)

function UICatchMainWindow:new()
  local window = UICatchMainWindow:super{title="Window Title"}

  -- private data model with <local>
  local gameBackground = UIImage:new(THEME.IMAGE.GAME_BACKGROUND)
  local thiefImage = UIImage:new(THEME.IMAGE.THIEF_BACKGROUND)
  local copImage = UIImage:new(THEME.IMAGE.COP_BACKGROUND)

 -- member components
  window.buttons = {}
  window.words = {}
  window.letters = {
    "a", "b", "c",
    "d", "e", "f",
    "g", "h", "i",
    "j", "k", "l",
    "m", "n", "o",
    "p", "q", "r",
    "s", "t", "u",
    "v", "w", "x",
    "y", "z"
  }
  
  -- layout panel components
  local proportion = 0.8
  window.mainPanel = UIPanelView:new{frame={x=0, y = 0,w = screen:get_width()*proportion,h=screen:get_height()*proportion},backgroundImage=gameBackground }
  window.thief = Thief:new{frame=THEME.FRAME.THIEF,image=thiefImage,moveUnit=THEME.DEFAULT.MOVE_UNIT}
  window.cop = Cop:new{frame=THEME.FRAME.COP,image=copImage,moveUnit=THEME.DEFAULT.MOVE_UNIT,bonusMoveUnit=0}
  window.mainPanel:addChildView(window.thief)
  window.mainPanel:addChildView(window.cop)
  window.rightPanel = UIPanelView:new{frame={x=screen:get_width()*proportion,y=0,w=screen:get_width()*(1-proportion),h=screen:get_height()*proportion},backgroundColor=THEME.COLOR.LIGHT_GRAY }
  window.collectionPanel = UICollectionView:new{frame={x=0,y=40,w=screen:get_width()*(1-proportion),h=screen:get_width()*(1-proportion)},space=10,cols=THEME.MENU.COLUMNS,rows=THEME.MENU.ROWS,backgroundColor=THEME.COLOR.LIGHT_GRAY}
  window.wordImageView = UIImageView:new{image=nil,frame={x=10,y=window.rightPanel.frame.w+80,w=window.rightPanel.frame.w-40,h=window.rightPanel.frame.w-40}}
  window.rightPanel:addChildView(window.collectionPanel)
  window.rightPanel:addChildView(window.wordImageView)
  window.bottomPanel = UIPanelView:new{frame={x=0, y = screen:get_height()*proportion,w=screen:get_width(),h=screen:get_height() * (1-proportion)},backgroundColor=THEME.COLOR.DARK_GRAY}
  window:addChildView(window.mainPanel)
  window:addChildView(window.rightPanel)
  window:addChildView(window.bottomPanel)
  
  
  -- layout right menu
  local textAlignCenterPosition = {x=(THEME.MENU.RECTANGLE_SIZE - THEME.MENU.FONT_SIZE)/2,y=(THEME.MENU.RECTANGLE_SIZE - THEME.MENU.FONT_SIZE)/2}
  local labels = {}
  local cells = {}
  for i = 1, THEME.MENU.ROWS do
    for j = 1, THEME.MENU.COLUMNS do
      local index = (i-1) * THEME.MENU.ROWS + j
        labels[index] = UILabel:new{text='-',color=THEME.COLOR.DARK_GRAY_1,size=THEME.MENU.FONT_SIZE,font=UILabel.FONT_GROBOLD }
        window.buttons[index] = UIButtonView:new{identity="button"..i,enableFocus=true,frame=THEME.FRAME.BUTTON,borderColor=THEME.COLOR.DARK_GRAY_1,borderWidth = THEME.MENU.BORDER_WIDTH,label=labels[index],labelPosition=textAlignCenterPosition}
        cells[index] = UICollectionCellView:new{view=window.buttons[index],viewType="UIButtonView" }
        window:setShortcutKey(window.buttons[index], Event.formatSystemKey[""..index])
        window:setFocusWeight{view=window.buttons[index], hWeight=1, vWeight=1}
        window.collectionPanel:fillWithCell(cells[index],i-1,j-1)
    end
  end
  window:setFocusView(window.buttons[1]) --Chuck's Magic number :) Dont blame Daniel.
  
 
  return UICatchMainWindow:init(window)
end
function UICatchMainWindow:configure(args)
   self.correctWord = args.correctWord
    self.wordImage = UIImage:new(args.wordImage)
    self.moveUnit = args.moveUnit or THEME.DEFAULT.MOVE_UNIT
end

function UICatchMainWindow:initialize()
  self:setPlayers()
  self:setMenu()
  self:setGuessWordBox()
  self:setGuessImage()
end

function UICatchMainWindow:generateRandomCharacters()
  assert(self.correctChar,"UICatchMainWindow:generateRandomCharacters(),self.correctChar is nil")
  self.characters = {}
  math.randomseed(os.time())
  local rightLetterIndex = math.random(1,9)
  self.characters[rightLetterIndex] = self.correctChar
  local tmp = 0
  local differ = {}
  for i=1,9 do
    -- generate characters except correctChar
    if i ~= rightLetterIndex then
      -- generate a unique character that is not equal to correctChar
      tmp = math.random(1,26)
      while differ[tmp] and self.letters[tmp] ~= self.correctChar do
        tmp = math.random(1,26)
      end
      self.characters[i] = self.letters[tmp]
      differ[tmp] = true
    end
  end
end

function UICatchMainWindow:updateWindowWords(number)
  if self.words[number] then
    local borderWidth = 4
    local RectangleSize = self.words[number].frame.w - 2*borderWidth
    local fontSize=50
    local textAlignCenterPosition = {x=(RectangleSize-fontSize)/2,y=(RectangleSize-fontSize)/2}
    local textlabel = UILabel:new{text=self.correctWord:sub(number,number),color=THEME.COLOR.DARK_GRAY,size=50,font=UILabel.FONT_GROBOLD}
    self.words[number]:setLabel(textlabel,textAlignCenterPosition)
  end
end

function UICatchMainWindow:updateMenuLabels(correctChar)
  self.correctChar = correctChar 
  self:generateRandomCharacters()
  for i = 1, THEME.MENU.ROWS do
    for j = 1, THEME.MENU.COLUMNS do
      local index = (i-1) * THEME.MENU.ROWS + j
      if self.buttons[index]~=nil and self.buttons[index].label~=nil then
        self.buttons[index].label.text = self.characters[index]
      end
    end
  end
end

function UICatchMainWindow:setMenu()
  local correctChar = self.correctWord:sub(1,1)
  self:updateMenuLabels(correctChar)
end


local function copy(obj)
  if type(obj) ~= 'table' then return obj end
  local res = {}
  for k, v in pairs(obj) do res[copy(k)] = copy(v) end
  return res
end

function UICatchMainWindow:setPlayers()
  assert(self.correctWord,"UICatchMainWindow:setGuessWordBox, self.correctWord is nil")
  -- initialize players
  self.thief:setFrame(copy(THEME.FRAME.THIEF))
  self.thief.moveUnit = self.moveUnit
  self.cop:setFrame(copy(THEME.FRAME.COP))
  self.thief.moveUnit = self.moveUnit
  self.cop.bonusMoveUnit = (self.thief.frame.x - self.cop.frame.x) / string.len(self.correctWord)
end

function UICatchMainWindow:setGuessWordBox()
  assert(self.characters,"UICatchMainWindow:setGuessWordBox, self.characters is nil")
  local count = string.len(self.correctWord)
  local boxesLength = (THEME.FRAME.RECTANGLE.w + THEME.FRAME.RECTANGLE.x) * (count-1) + THEME.FRAME.RECTANGLE.w
  local startX = (self.bottomPanel.frame.w - boxesLength) / 2
  self.bottomPanel:emptyChildView()
  for i =1,count do
    self.words[i] = UIRectangleView:new{frame={x=THEME.FRAME.RECTANGLE.w*i + startX,y=THEME.FRAME.RECTANGLE.y,w=THEME.FRAME.RECTANGLE.w,h=THEME.FRAME.RECTANGLE.h},borderColor=THEME.COLOR.LIGHT_BLUE,borderWidth = THEME.MENU.BORDER_WIDTH}
    self.bottomPanel:addChildView(self.words[i])
  end
end

function UICatchMainWindow:setGuessImage()
  assert(self.wordImage,"UICatchMainWindow:setGuessImage, self.wordImage is nil")
  self.wordImageView:setImage(self.wordImage)
end

return UICatchMainWindow
