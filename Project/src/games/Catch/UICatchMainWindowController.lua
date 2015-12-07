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

  function o:initialize()
    --self.characters = based on letter, random some characters
    self.correctWord = self.levels[self.currentLevel].word
    self.maxNumberOfGuesses = self.levels[self.currentLevel].maxNumberOfGuesses
    self.wordImage = self.levels[self.currentLevel].wordImage
    self.numberOfGuesses = 0
    self.numberOfCorrect = 0
    self.correctChar = self.correctWord:sub(self.numberOfCorrect+1,self.numberOfCorrect+1)

    self.window:configure{correctWord=self.correctWord,wordImage=self.wordImage,maxNumberOfGuesses=self.maxNumberOfGuesses,currentLevel=self.currentLevel}
    self.window:initialize()
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
  -- start  if sender and sender.label
  if sender and sender.label then
       keyLetter = sender.label.text
    -- start  if keyletter is not nil
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
        -- start if self.numberOfCorrect == string.len(self.correctWord)
        if self.numberOfCorrect == string.len(self.correctWord) then
          -- start if self.currentLevel == #self.levels then
          if self.currentLevel == #self.levels then
            -- open Congratulations window to say success
            self.game:alertWindowOpen{title="Congratulations, mission completed! ", OK="Exit",Cancel="Retry",
              callback=function(sender)
                if sender.identity=="OK" then
                  self.game:exit()
                else
                  self.game:windowOpen{windowName="levelWindow"}
                end
              end
            }
            --end open Congratulations window
          else  -- else if self.currentLevel ~= #self.levels then
            -- open window
            self.game:alertWindowOpen{title="You win, Next level or Retry?", OK="Next",Cancel="Retry",
              callback=function(sender)
                if sender.identity=="OK" then
                  self.currentLevel = self.currentLevel + 1
                  self.window:updateLevelText(self.currentLevel)
                  self:initialize()
                else
                  self:initialize()
                end
              end
            }
            -- end open window
          end -- end if self.currentLevel == #self.levels then
        else  --else if self.numberOfCorrect ~= string.len(self.correctWord)
          self.window:updateMenuLabels(self:getNextCorrectChar())
        end
        -- end if start for check letter
     
      elseif self.numberOfGuesses >= self.maxNumberOfGuesses then -- self:checkLetter(keyLetter) ~= false and self.numberOfGuesses >= self.maxNumberOfGuesses
        self.game:alertWindowOpen{title="You failed,Do you want to try again?", OK="Again",Cancel="No",
          callback=function(sender)
            if sender.identity=="OK" then
              self:initialize()
            else
              self.game:windowOpen{windowName="levelWindow"}
            end
          end
        }
      end
      -- end self:checkLetter(keyLetter) ~= false 

      if self.numberOfGuesses < self.maxNumberOfGuesses then
        self.window.cop:run(flag)
        self.window.thief:run()
      end
    end
    -- end if keyletter is not nil
  end
  -- end if sender and sender.label
end

function UICatchMainWindowController:onKeyEvent(event)
  if event.key == Event.KEY_BACK and event.state == Event.KEY_STATE_DOWN then
    self.game:exit()
  end
end

return UICatchMainWindowController
