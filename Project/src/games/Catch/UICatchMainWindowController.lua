-- Created by chuck, now it doesn't affect anything.
-- Don't consider this file, just keep it.

local UIWindowViewController = require("toolkit.UIKit.UIWindowViewController")
local UICatchMainWindow = require('games.Catch.UICatchMainWindow')
local Event = require('toolkit.Event')


local UICatchMainWindowController = extends(UIWindowViewController)

function UICatchMainWindowController:new(args)
  
  local o = UICatchMainWindowController:super(UICatchMainWindow:new())
  --assert(args and args.game,"UICatchMainWindowController:new:error game parameter is nil")
  o.game = args.game
  o.levels = o.game.levels
  o.currentLevel = tonumber(args.level)
  
  function o:initialize(flag)
    --o.characters = based on letter, random some characters
    o.correctWord = o.levels[o.currentLevel].word
    o.maxNumberOfGuesses = o.levels[o.currentLevel].maxNumberOfGuesses
    o.wordImage = o.levels[o.currentLevel].wordImage
    o.numberOfGuesses = 0
    o.numberOfCorrect = 0
    o.correctChar = o.correctWord:sub(o.numberOfCorrect+1,o.numberOfCorrect+1)
    
    o.window:configure{correctWord=o.correctWord,wordImage=o.wordImage,maxNumberOfGuesses=o.maxNumberOfGuesses,currentLevel=o.currentLevel}
    o.window:initialize()
  end
  o:initialize()
  return UICatchMainWindowController:init(o)
end

function UICatchMainWindowController:getNextCorrectChar()
  self.correctChar = self.correctWord:sub(self.numberOfCorrect+1,self.numberOfCorrect+1)
  return self.correctChar
end
function UICatchMainWindowController:checkLetter(letter)
  return self:getNextCorrectChar() == letter
end

function UICatchMainWindowController:updateWindowWords(number)
  if self.window.words[number] then
    local borderWidth = 4
    local RectangleSize = self.window.words[number].frame.w - 2*borderWidth
    local fontSize=50
    local textAlignCenterPosition = {x=(RectangleSize-fontSize)/2,y=(RectangleSize-fontSize)/2}
    local textlabel = UILabel:new{text=self.correctWord:sub(self.numberOfCorrect,self.numberOfCorrect),color=THEME.COLOR.DARK_GRAY,size=50,font=UILabel.FONT_GROBOLD}
    self.window.words[number]:setLabel(textlabel,textAlignCenterPosition)
  end
end

function UICatchMainWindowController:onClickEvent(sender)
  keyLetter = sender.label.text
  --print(sender.label.text)
  if keyLetter then
    self.numberOfGuesses = self.numberOfGuesses+1
    -- identify whether it's correct
    local flag = false
    self.window:updateTryCountText(self.maxNumberOfGuesses-self.numberOfGuesses)
    
    -- if start for check letter
    if self:checkLetter(keyLetter) == true then
      flag = true
      self.numberOfCorrect = self.numberOfCorrect + 1
      self.window:updateWindowWords(self.numberOfCorrect)
      if self.numberOfCorrect == string.len(self.correctWord) then
        -- show another window to say success
        if self.currentLevel == #self.levels then
          self.game:alertWindowOpen{title="Congratulations, mission completed! ", OK="Exit",Cancel="Retry",
          callback=function(sender)
            if sender.identity=="OK" then
              self.game:exit()
              return
            else
              self.game:windowOpen{windowName="levelWindow"}
              return
            end
          end
        }
        else
        self.game:alertWindowOpen{title="You win, Next level or Retry?", OK="Next",Cancel="Retry",
          callback=function(sender)
            if sender.identity=="OK" then
              self.currentLevel = self.currentLevel + 1
              self.window:updateLevelText(self.currentLevel)
              self:initialize()
              return
            else
              self:initialize()
              return
            end
          end
        }
        end
      else
        self.window:updateMenuLabels(self:getNextCorrectChar())
      end
    -- end if start for check letter
    -- if start for check numberOfGuesses
    elseif self.numberOfGuesses >= self.maxNumberOfGuesses then
      self.game:alertWindowOpen{title="You failed,Do you want to try again?", OK="Again",Cancel="No",
        callback=function(sender)
          if sender.identity=="OK" then
            self:initialize()
            return
          else
            self.game:windowOpen{windowName="levelWindow"}
            return
          end
        end
      }
    end
    -- end if start for check numberOfGuesses
    self.window.cop:run(flag)
    self.window.thief:run()
  end
end

return UICatchMainWindowController
