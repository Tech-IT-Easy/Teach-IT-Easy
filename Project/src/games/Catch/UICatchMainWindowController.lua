-- Created by chuck, now it doesn't affect anything.
-- Don't consider this file, just keep it.

local UIWindowViewController = require("toolkit.UIKit.UIWindowViewController")
local UICatchMainWindow = require('games.Catch.UICatchMainWindow')
local Event = require('toolkit.Event')
local UILabel = require("toolkit.UIKit.UILabel")
local UIAlertWindowController = require("toolkit.UIKit.UIAlertWindowController")
local THEME = require("games/Catch/data/theme")


local UICatchMainWindowController = extends(UIWindowViewController)

function UICatchMainWindowController:new(args)
  local o = UICatchMainWindowController:super(UICatchMainWindow:new())
  o.window.cop:print()

  o.levels = args.levels
  o.currentLevel = 1

  o.correctWord = args.levels[o.currentLevel].word

  o.maxNumberOfGuesses = args.levels[o.currentLevel].maxNumberOfGuesses

  o.numberOfGuesses = 0

  o.numberOfCorrect = 0

  o.characters = {
    "a", "b", "c",
    "d", "e", "f",
    "g", "h", "i"
  }
  --print("Correct answer: " .. self.correctWord)

  --o.window.button1.delegate = o
  --o.window.button2.delegate = o

  o.window.cop:print()
  o.game = args.game
  return UICatchMainWindowController:init(o)
end

function UICatchMainWindowController:checkLetter(letter)
  return self.correctWord:sub(self.numberOfCorrect+1,self.numberOfCorrect+1) == letter
end

function UICatchMainWindowController:updateWindowWords(number)
  if self.window.words[number] then
    local textlabel = UILabel:new{text=self.correctWord:sub(self.numberOfCorrect,self.numberOfCorrect),color=THEME.COLOR.DARK_GRAY,size=50,font=UILabel.FONT_GROBOLD}
    self.window.words[number]:setLabel(textlabel)
  end
end
--[[
function UICatchMainWindowController:onClickEvent(sender)
  if sender.identity == "button1" then
    print("I know who you are:"..sender.identity)
  elseif sender.identity == "button2" then
    print("I know who you are:"..sender.identity)
  end
end
]]--
function UICatchMainWindowController:onKeyEvent(listener,event)
  print("key down in UICatchMainWindowController")
  if event.state == Event.KEY_DOWN then
    -- add number of guesses
    self.numberOfGuesses = self.numberOfGuesses+1

    -- identify whether it's correct
    local flag = false
    if self:checkLetter("a") == true then
      flag = true
      self.numberOfCorrect = self.numberOfCorrect + 1
      self:updateWindowWords(self.numberOfCorrect)
      if self.numberOfCorrect == string.len(self.correctWord) then
        -- show another window to say success
      end
    elseif self.numberOfGuesses >= self.maxNumberOfGuesses then
      self.game:alertWindowOpen{title="You are failed,Do you want to try again?",
        callback=function(sender)
          if sender.identity=="OK" then
            --initialize window and controller
          else 
            self.game:exit()
          end
        end
      }
    end

    self.window.cop:run(flag)
    self.window.thief:run()
  end

end
--[[

local GameWindowController = require("games.Catch.UICatchMainWindowController")
local UILabel = require("toolkit.UIKit.UILabel")
local THEME = require("games/Catch/data/theme")
GameWindowController:new():presentView()

]]--

return UICatchMainWindowController
