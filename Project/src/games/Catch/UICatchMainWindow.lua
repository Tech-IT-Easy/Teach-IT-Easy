local UIWindowView = require("toolkit.UIKit.UIWindowView")
local UIPanelView = require("toolkit.UIKit.UIPanelView")
local UIRectangleView = require("toolkit.UIKit.UIRectangleView")
local UICollectionView = require("toolkit.UIKit.UICollectionView")
local UICollectionCellView = require("toolkit.UIKit.UICollectionCellView")
local UIButtonView = require("toolkit.UIKit.UIButtonView")
local UIImageView = require("toolkit.UIKit.UIImageView")
local UILabelView = require("toolkit.UIKit.UILabelView")
local UIImage = require("toolkit.UIKit.UIImage")
local UILabel = require("toolkit.UIKit.UILabel")
local Event = require("toolkit.Event")
local THEME = require("games/Catch/data/theme")
local People = require("games.Catch.People")

-- This is a instance window, which is created for using when required
local UICatchMainWindow = extends(UIWindowView)

function UICatchMainWindow:new(context)
  local window = UICatchMainWindow:super{title="Window Title" }
  -- private data model with <local>
  window.gameBackground = UIImage:new(THEME.IMAGE.GAME_BACKGROUND)
  window.thiefImage = UIImage:new(THEME.IMAGE.THIEF_BACKGROUND)
  window.copImage = UIImage:new({imagePath = context.profile.images.RIGHT, imageType="png"})


 -- member components
  window.enterEnable = false
  window.buttons = {}
  window.words = {}
  window.letters = {"a", "b", "c","d", "e", "f","g", "h", "i","j", "k", "l","m", "n", "o","p", "q", "r","s", "t", "u","v", "w", "x","y", "z"}
  
  -- layout panel components
  local proportion = 0.8
  window.mainPanel = UIPanelView:new{frame={x=0, y = 0,w = screen:get_width()*proportion,h=screen:get_height()*proportion},backgroundImage=window.gameBackground }
  window.thief = People:new{frame=THEME.FRAME.THIEF,image=window.thiefImage,moveUnit=THEME.DEFAULT.MOVE_UNIT}
  window.cop = People:new{frame=THEME.FRAME.COP,image=window.copImage,moveUnit=THEME.DEFAULT.MOVE_UNIT}
  window.tryCountLabelView = UILabelView:new{identity="tryCountLabel",frame={x=20,y=20,w=0,h=0},label=UILabel:new{identity="20 / 20",text="20 / 20",color=THEME.COLOR.WHITE,size=30,font=UILabel.FONT_GROBOLD}}
  window.mainPanel:addChildView(window.thief)
  window.mainPanel:addChildView(window.cop)
  window.mainPanel:addChildView(window.tryCountLabelView)
  window.rightPanel = UIPanelView:new{frame={x=screen:get_width()*proportion,y=0,w=screen:get_width()*(1-proportion),h=screen:get_height()*proportion},backgroundColor=THEME.COLOR.LIGHT_GRAY }
  window.collectionPanel = UICollectionView:new{frame={x=0,y=80,w=screen:get_width()*(1-proportion),h=screen:get_width()*(1-proportion)},space=10,cols=THEME.MENU.COLUMNS,rows=THEME.MENU.ROWS,backgroundColor=THEME.COLOR.LIGHT_GRAY}
  window.wordImageView = UIImageView:new{image=nil,frame={x=10,y=window.collectionPanel.frame.h+100,w=window.rightPanel.frame.w-40,h=window.rightPanel.frame.w-40}}
  window.levelLabelView = UILabelView:new{identity="levelLabel",frame={x=25,y=10,w=0,h=0},label=UILabel:new{identity="LEVEL 1",text="LEVEL 1",color=THEME.COLOR.WHITE,size=50,font=UILabel.FONT_GROBOLD}}
  
  window.rightPanel:addChildView(window.collectionPanel)
  window.rightPanel:addChildView(window.wordImageView)
  window.rightPanel:addChildView(window.levelLabelView)
  
  window.bottomPanel = UIPanelView:new{frame={x=0, y = screen:get_height()*proportion,w=screen:get_width(),h=screen:get_height() * (1-proportion)},backgroundColor=THEME.COLOR.DARK_GRAY}
  window:addChildView(window.mainPanel)
  window:addChildView(window.rightPanel)
  window:addChildView(window.bottomPanel)
  
  
  -- layout right menu
  local textAlignCenterPosition = {x=(THEME.MENU.RECTANGLE_SIZE - THEME.MENU.FONT_SIZE)/2,y=(THEME.MENU.RECTANGLE_SIZE - THEME.MENU.FONT_SIZE)/2}
  window.labels = {}
  window.tipLabels = {}
  window.cells = {}
  for i = 1, THEME.MENU.ROWS do
    for j = 1, THEME.MENU.COLUMNS do
      local index = (i-1) * THEME.MENU.ROWS + j
        window.labels[index] = UILabel:new{identity="menuRow"..i.."Col"..j,text='-',color=THEME.COLOR.DARK_GRAY_1,size=THEME.MENU.FONT_SIZE,font=UILabel.FONT_GROBOLD }
        window.tipLabels[index] = UILabel:new{identity="menuRowTip"..i.."Col"..j,text=index,color=THEME.COLOR.WHITE,size=THEME.MENU.TIP_FONT_SIZE,font=UILabel.FONT_GROBOLD }
        window.buttons[index] = UIButtonView:new{identity="button"..index,enableFocus=true,frame=THEME.FRAME.BUTTON,borderColor=THEME.COLOR.DARK_GRAY_1,focusedBorderColor=THEME.COLOR.DARK_GRAY_1,focusedBackgroundColor=THEME.COLOR.WHITE_HALF,borderWidth = THEME.MENU.BORDER_WIDTH,label=window.labels[index],labelPosition=textAlignCenterPosition,tipLabel=window.tipLabels[index]}
        window.cells[index] = UICollectionCellView:new{view=window.buttons[index],viewType="UIButtonView" }
        window:setShortcutKey(window.buttons[index], Event.formatSystemKey[""..index])
        window:setFocusWeight{view=window.buttons[index], hWeight=1, vWeight=1}
        window.collectionPanel:fillWithCell(window.cells[index],i-1,j-1)
    end
  end
 
  return UICatchMainWindow:init(window)
end
function UICatchMainWindow:configure(args)
   self.correctWord = args.correctWord
    self.wordImage = UIImage:new(args.wordImage)
    self.maxNumberOfGuesses = args.maxNumberOfGuesses
    self.currentLevel = args.currentLevel
end

function UICatchMainWindow:initialize()
  self:setPlayers()
  self:setMenu()
  self:setGuessWordBox()
  self:setGuessImage()
  self:updateLevelText(self.currentLevel)
  self:updateTryCountText(self.maxNumberOfGuesses)
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
      while differ[tmp] or self.letters[tmp] == self.correctChar do
        tmp = math.random(1,26)
      end
      self.characters[i] = self.letters[tmp]
      differ[tmp] = true
    end
  end
end

function UICatchMainWindow:updateWindowWords(number)
  if self.words[number] and self.words[number].label then
    self.words[number].label.text = self.correctWord:sub(number,number)
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
  self:setFocusView(self.buttons[1])
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
  --assert(self.correctWord,"UICatchMainWindow:setGuessWordBox, self.correctWord is nil")
  -- initialize players
  self.thief:setFrame(copy(THEME.FRAME.THIEF))
  self.cop:setFrame(copy(THEME.FRAME.COP))
  self.moveUnit = (self.mainPanel.frame.w - self.thief.frame.x - self.thief.frame.w) / self.maxNumberOfGuesses
  self.cop.moveUnit = self.moveUnit
  self.thief.moveUnit = self.moveUnit
  self.cop.bonusMoveUnit = (self.thief.frame.x - self.cop.frame.x - self.cop.frame.w + 50) / string.len(self.correctWord)
end

function UICatchMainWindow:setGuessWordBox()
  assert(self.characters,"UICatchMainWindow:setGuessWordBox, self.characters is nil")
  local count = string.len(self.correctWord)
  local boxesLength = (THEME.WORDBOX.RECTANGLE_SIZE + THEME.WORDBOX.RECTANGLE_SPACE) * (count-1) + THEME.WORDBOX.RECTANGLE_SIZE
  local startX = (self.bottomPanel.frame.w - boxesLength) / 2
  self.bottomPanel:emptyChildView()
  local borderWidth = 4
  local fontSize=50
  local RectangleSize = THEME.FRAME.RECTANGLE.w - 2 * THEME.MENU.BORDER_WIDTH
  local textAlignCenterPosition = {x=(RectangleSize-fontSize)/2,y=(RectangleSize-fontSize)/2}
  self.wordlabel = {}
  for i = 1,count do
    self.wordlabel[i] = UILabel:new{identity="mainWindowChar"..i, text=" ",color=THEME.COLOR.DARK_GRAY,size=fontSize,font=UILabel.FONT_GROBOLD}
    self.words[i] = UIButtonView:new{identity="setGuessWordBox"..i,frame={x=startX + THEME.WORDBOX.RECTANGLE_SIZE*(i-1),y=THEME.FRAME.RECTANGLE.y,w=THEME.FRAME.RECTANGLE.w,h=THEME.FRAME.RECTANGLE.h},borderColor=THEME.COLOR.LIGHT_BLUE,borderWidth = THEME.MENU.BORDER_WIDTH,label= self.wordlabel[i],labelPosition=textAlignCenterPosition}
    self.bottomPanel:addChildView(self.words[i])
  end
end

function UICatchMainWindow:setGuessImage()
  assert(self.wordImage,"UICatchMainWindow:setGuessImage, self.wordImage is nil")
  self.wordImageView:setImage(self.wordImage)
end

function UICatchMainWindow:updateLevelText(currentLevel)
  self.levelLabelView.label.identity = "LEVEL "..currentLevel
  self.levelLabelView.label.text = "LEVEL "..currentLevel
end

function UICatchMainWindow:updateTryCountText(cur)
  self.tryCountLabelView.label.text = cur.." / "..self.maxNumberOfGuesses
end
return UICatchMainWindow
