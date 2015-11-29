-------------------------------
--The highest level for the game. Creates the parts of the game and
--tells the parts to update.
-------------------------------

local Game = require('toolkit.Game')
local Catch = extends(Game)

local UIImage = require('toolkit.UIKit.UIImage')

local Thief = require('games.Catch.Thief')
local Cop = require('games.Catch.Cop')

local UIMainWindowView = require('games.Catch.UIMainWindowView')
local UIMainWindowController = require('games.Catch.UIMainWindowController')



local words = {"Anka", "Kaka", "Banan", "Apa"}


-----------------------------------------------------------
-- Constructor method, see 'toolkit.Game'
-- @param context - A pointer to the context that the game exists in
-- @return a new queue instance
-----------------------------------------------------------
function Catch:new(context)
  local o = Catch:super()

  self.platformContext = context
  self:initListener()

  self.thief = Thief:new{
    image=UIImage:new{imagePath="data/bowser.png",imageType="png"},
    frame={x=0,y=1,w=100,h=100}
  }
  self.cop = Cop:new{
    image=UIImage:new{imagePath="data/mario.png",imageType="png"},
    frame={x=0,y=1,w=100,h=100}
  }

  o.window = UIMainWindowView
  o.windowController = UIMainWindowController:new(o.window)

  self.gameEventListener:attach(o.windowController)


  return Catch:init(o)
end

-----------------------------------------------------------
-- Loading resources, only called when the game starts
-- as of right now.
-----------------------------------------------------------
function Catch:load()
  self.selectedWord = words[math.random(#words)]
  print("Correct answer: " .. self.selectedWord)
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
    self.windowController:presentView()
end

return Catch
