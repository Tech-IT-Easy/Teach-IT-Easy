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
      word="car",
      maxNumberOfGuesses = 10,
      wordImage = {imagePath="games/Catch/data/car.png",imageType="png"}
    },
    {
      word="chair",
      maxNumberOfGuesses = 15,
      wordImage = {imagePath="games/Catch/data/chair.png",imageType="png"}
    },
    {
      word="fruit",
      maxNumberOfGuesses = 20,
      wordImage = {imagePath="games/Catch/data/fruit.png",imageType="png"}
    },
    {
      word="parrot",
      maxNumberOfGuesses = 25,
      wordImage = {imagePath="games/Catch/data/parrot.png",imageType="png"}
    },
    {
      word="banana",
      maxNumberOfGuesses = 30,
      wordImage = {imagePath="games/Catch/data/banana.png",imageType="png"}
    },
    {
      word="airplane",
      maxNumberOfGuesses = 35,
      wordImage = {imagePath="games/Catch/data/airplane.png",imageType="png"}
    },
    {
      word="elephant",
      maxNumberOfGuesses = 40,
      wordImage = {imagePath="games/Catch/data/elephant.png",imageType="png"}
    },
    {
      word="butterfly",
      maxNumberOfGuesses = 45,
      wordImage = {imagePath="games/Catch/data/butterfly.png",imageType="png"}
    }
  }
end

-----------------------
--When the platform launches the game it calls this function
-----------------------
--
 script_path = nil
  title = nil
function Catch:start()
  self:load()
  self.windowController = UICatchLevelWindowController:new({game=self,immediateResponse=false}) --UICatchMainWindowController
  self.gameEventListener:attach(self.windowController)
  print("Starting game Catch...")
 
  if ADConfig.isSimulator then
  script_path = ""
else
  script_path = sys.root_path()
end
title = sys.new_freetype({g=255, r=255, b=255, a=255}, 70, {x= 20, y=20}, script_path..'data/GROBOLD.ttf')
end


------------------------
-- Updates all objects that are part of the game
-- and are displayed on the screen
------------------------
function Catch:update()
  if self.windowController then
    self.windowController:presentView()
    
title:draw_over_surface(screen, "Choose Level")
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
