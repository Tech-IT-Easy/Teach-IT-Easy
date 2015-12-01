-- Created by chuck, now it doesn't affect anything. 
-- Don't consider this file, just keep it.

local UIWindowViewController = require("toolkit.UIKit.UIWindowViewController")
local UICatchMainWindow = require('games.Catch.UICatchMainWindow')


local UICatchMainWindowController = extends(UIWindowViewController)

function UICatchMainWindowController:new(args)
  local o = UICatchMainWindowController:super(UICatchMainWindow:new())
  o.window.cop:print()

  o.levels = args.levels
  o.currentLevel = 1

  o.correctWord = args.levels[o.currentLevel].word
  o.maxNumberOfGuesses = args.levels[o.currentLevel].maxNumberOfGuesses

  o.numberofGuesses = 0
  o.numberCorrect = 0
  o.characters = {
    "a", "b", "c",
    "d", "e", "f",
    "g", "h", "i"
  }
  print("Correct answer: " .. self.correctWord)

  --o.window.button1.delegate = o
  --o.window.button2.delegate = o

  o.window.cop:print()

  return UICatchMainWindowController:init(o)
end

function UICatchMainWindowController:checkLetter(letter)
  return self.level.word:byte(self.guessedLettersCount+1) == letter
end

function UICatchMainWindowController:updateWindowWords(number)
  for i = 1,number do
    --a[self.level.word:byte[i]] = UIRectangleView:new{frame={x=300,y=20,w=80,h=80},borderColor={r=255,g=29,b=25},borderWidth = 4,label=textlabel},
    --['b'] = UIRectangleView:new{frame={x=400,y=20,w=80,h=80},borderColor={r=255,g=29,b=25},borderWidth = 4}
     --add rectangle and text to window
  end
end

function UICatchMainWindowController:onClickEvent(sender)
  if sender.identity == "button1" then
    print("I know who you are:"..sender.identity)
  elseif sender.identity == "button2" then
    print("I know who you are:"..sender.identity)
  end
end

function UICatchMainWindowController:button1_OnClickEvent()
  print("button 1 delegate")
end

function UICatchMainWindowController:button2_OnClickEvent()
  print("button 2 delegate")
end

--[[

local GameWindowController = require("games.Catch.UICatchMainWindowController")
local UILabel = require("toolkit.UIKit.UILabel")
local THEME = require("games/Catch/data/theme")
GameWindowController:new():presentView()

]]--

return UICatchMainWindowController