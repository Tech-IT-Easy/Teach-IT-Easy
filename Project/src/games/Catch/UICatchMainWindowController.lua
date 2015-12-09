-----------------------------------------------------------
-- This is window controller that is responsible for managing 
-- the game main window such as creating and initializing and 
-- also controlling game logic
--
-- @Author:Created by Chuck, Nov 16,2015
-----------------------------------------------------------

local UIWindowViewController = require("toolkit.UIKit.UIWindowViewController")
local UICatchMainWindow = require('games.Catch.UICatchMainWindow')
local Event = require('toolkit.Event')


local UICatchMainWindowController = extends(UIWindowViewController)

function UICatchMainWindowController:new(args)

  local o = UICatchMainWindowController:super(UICatchMainWindow:new(args.context))
  --assert(args and args.game,"UICatchMainWindowController:new:error game parameter is nil")
  o.game = args.game
  o.levels = o.game.levels
  o.currentLevel = tonumber(args.level)
  o.context = args.context
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

      -- start if self.numberOfGuesses <= self.maxNumberOfGuesses then
      if self.numberOfGuesses <= self.maxNumberOfGuesses then
        self.window:updateTryCountText(self.maxNumberOfGuesses-self.numberOfGuesses)
      end

      if self.numberOfGuesses == self.maxNumberOfGuesses and (self:checkLetter(keyLetter) == false or self.numberOfCorrect ~= string.len(self.correctWord)-1) then -- if (self.numberOfGuesses == self.maxNumberOfGuesses and self.numberOfCorrect <= string.len(self.correctWord)
        self.game:alertWindowOpen{title="You failed,Do you want to try again?", OK="Again",Cancel="No",
          callback=function(sender)
            if sender.identity=="OK" then
              self:initialize()
            else
              self.game:windowOpen{windowName="levelWindow",immediateResponse=true}
            end
          end
        }
      -- if start for check letter
      elseif self:checkLetter(keyLetter) == true then 
        flag = true
        self.numberOfCorrect = self.numberOfCorrect + 1
        self.window:updateWindowWords(self.numberOfCorrect)
        -- start if self.numberOfCorrect == string.len(self.correctWord)
        if self.numberOfCorrect == string.len(self.correctWord) then
          -- start if self.currentLevel == #self.levels then
          if self.currentLevel == #self.levels then
            -- open Congratulations window to say success
            self:updateProgress()
            self.game:alertWindowOpen{title="Congratulations, mission completed! ", OK="Done",Cancel="Exit",
              callback=function(sender)
                if sender.identity=="OK" then
                    
                  self.game:windowOpen{windowName="levelWindow",immediateResponse=true}
                else
                  self.game:exit()
                end
              end
            }
            --end open Congratulations window
          else  -- else if self.currentLevel ~= #self.levels then
            -- open window
            self:updateProgress()
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
        -- end if end for check letter
      end
      -- end self:checkLetter(keyLetter) ~= false
      if self.numberOfGuesses <= self.maxNumberOfGuesses then
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
    self.game:windowOpen{windowName="levelWindow",immediateResponse=true}
  end
end

function UICatchMainWindowController:updateProgress()
    if self.currentLevel < #self.levels then
      local progress = self.context.profile.gameprogress:getProgress("games.Catch.Catch")
      if progress.level < self.currentLevel then
        progress.level = self.currentLevel
        if (progress.level == 2) then
            progress.catchABC = true
        elseif (progress.level == 4) then
            progress.catchKindergarten = true
        elseif (progress.level == 6) then
            progress.catchElementary = true
        elseif (progress.level == 8) then
            progress.catchPhd = true
        end
        self.context.profile.gameprogress:setProgress("games.Catch.Catch", progress)
      end
    end
end

return UICatchMainWindowController
