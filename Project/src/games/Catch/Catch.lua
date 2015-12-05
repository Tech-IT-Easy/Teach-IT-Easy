-------------------------------
--The highest level for the game. Creates the parts of the game and
--tells the parts to update.
-------------------------------

local Game = require('toolkit.Game')
local Catch = extends(Game)

local UICatchMainWindowController = require('games.Catch.UICatchMainWindowController')
local UICatchLevelWindowController = require('games.Catch.UICatchLevelWindowController')
local UIAlertWindowController = require("toolkit.UIKit.UIAlertWindowController")
local UILabelView = require("toolkit.UIKit.UILabelView")
local UILabel = require("toolkit.UIKit.UILabel")
local THEME = require("games/Catch/data/theme")
-----------------------------------------------------------
-- Constructor method, see 'toolkit.Game'
-- @param context - A pointer to the context that the game exists in
-- @return a new queue instance
-----------------------------------------------------------
function Catch:new(context)
  local o = Catch:super()
  self.platformContext = context
  self:initListener()
  return Catch:init(o)
end

-----------------------------------------------------------
-- Loading resources, only called when the game starts
-- as of right now.
-----------------------------------------------------------
function Catch:load()
  self.levels = {
    {
      word="cat",
      maxNumberOfGuesses = 10,
      wordImage = {imagePath="data/mario.png",imageType="png"}
    },
    {
      word="goat",
      maxNumberOfGuesses = 15,
      wordImage = {imagePath="data/bowser.png",imageType="png"}
    },
    {
      word="horse",
      maxNumberOfGuesses = 20,
      wordImage = {imagePath="data/toad.png",imageType="png"}
    }
  }
end

-----------------------
--When the platform launches the game it calls this function
-----------------------
function Catch:start()
  self:load()
  self.windowController = UICatchLevelWindowController:new({game=self,immediateResponse=false}) --UICatchMainWindowController
  self.gameEventListener:attach(self.windowController)
  print("Starting game Catch...")
end


------------------------
-- Updates all objects that are part of the game
-- and are displayed on the screen
------------------------
function Catch:update()
  if self.windowController then
    self.windowController:presentView()
  end
  if self.alertController then
    self.alertController:presentView()
  end
end

--args={windowName='',windowArgs={}}
function Catch:windowOpen(args)
  --self.lastWindowController = self.windowController
  self.gameEventListener:remove(self.windowController)
  if args == nil or args.windowName == "levelWindow" then
    self.windowController = UICatchLevelWindowController:new({game=self,immediateResponse=false})
  elseif args.windowName == "mainWindow" then
    self.windowController = UICatchMainWindowController:new({level = args.windowArgs.level,game=self})
  end
  self.gameEventListener:attach(self.windowController)
  self.newWindow = true
  collectgarbage()
end

function Catch:windowClose(args)
  self.gameEventListener:attach(self.lastWindowController)
  self.gameEventListener:remove(self.windowController)
  self.windowController = self.lastWindowController
end

function Catch:alertWindowOpen(args)
  self.newWindow = false
  self.gameEventListener:remove(self.windowController)
  self.alertController = UIAlertWindowController:new{title=args.title,OK=args.OK,Cancel=args.Cancel,
    callback=function(sender)
      args.callback(sender)
      self:alertWindowClose()
    end
  }
  self.gameEventListener:attach(self.alertController)
end

function Catch:alertWindowClose()
  -- avoid double attach problem
  if self.newWindow~= true then
    self.gameEventListener:attach(self.windowController)
  end
  self.gameEventListener:remove(self.alertController)
  self.alertController = nil
end

function Catch:exit()
  self.platformContext.platformEventListener:removeChainListener()
  self.platformContext:createNewMenu()
  self.platformContext.game = nil
  collectgarbage()
end

return Catch
