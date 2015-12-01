-------------------------------
--The highest level for the game. Creates the parts of the game and
--tells the parts to update.
-------------------------------

local Game = require('toolkit.Game')
local Catch = extends(Game)

local UIImage = require('toolkit.UIKit.UIImage')

local Thief = require('games.Catch.Thief')
local Cop = require('games.Catch.Cop')

local UICatchMainWindow = require('games.Catch.UICatchMainWindow')
local UICatchMainWindowController = require('games.Catch.UICatchMainWindowController')
local UIAlertWindowController = require("toolkit.UIKit.UIAlertWindowController")


local words = {
  "Anka",
  "Kaka"
}


-----------------------------------------------------------
-- Constructor method, see 'toolkit.Game'
-- @param context - A pointer to the context that the game exists in
-- @return a new queue instance
-----------------------------------------------------------
function Catch:new(context)
  local o = Catch:super()
  o.levels = {
    {word="anka",maxNumberOfGuesses = 10},
    {word="anka",maxNumberOfGuesses = 10},
    {word="anka",maxNumberOfGuesses = 10}
  }
  
  self.platformContext = context
  self:initListener()
  
  o.windowController = UICatchMainWindowController:new({levels = o.levels,game=o})
  self.gameEventListener:attach(o.windowController)
  
  return Catch:init(o)
end

-----------------------------------------------------------
-- Loading resources, only called when the game starts
-- as of right now.
-----------------------------------------------------------
function Catch:load()
  self.correctWord = words[math.random(#words)]
  self.numberCorrect = 0
  print("Correct answer: " .. self.correctWord)
end

-----------------------
--When the platform launches the game it calls this function
-----------------------
function Catch:start()
  print("Starting game Catch...")
  self:load()
end


------------------------
--Updates all objects that are part of the game
-- and are displayed on the screen
------------------------
function Catch:update()
  if self:completed() then
    print("Game completed!")
  else
    print("Game not completed!")
  end

  self.windowController:presentView()
  if self.alertController then
    self.alertController:presentView()
  end
end


function Catch:alertWindowOpen(args)
  self.alertController = UIAlertWindowController:new{title=args.title,
  callback=function(sender)
    args.callback(sender)
    self:alertWindowClose()
  end
  }
  self.gameEventListener:remove(self.windowController)
  self.gameEventListener:attach(self.alertController)
end

function Catch:alertWindowClose()
  self.gameEventListener:attach(self.windowController)
  self.gameEventListener:remove(self.alertController)
  self.alertController = nil
end

function Catch:exit()
  self.platformContext.platformEventListener:removeChainListener()
  self.platformContext:createNewMenu()
  self.platformContext.game = nil
end

function Catch:completed()
  return #self.correctWord == self.guessedWord;
end

return Catch
