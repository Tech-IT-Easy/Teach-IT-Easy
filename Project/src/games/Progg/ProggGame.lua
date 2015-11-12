-------------------------------
--The highest level for the game. Creates the parts of the game and
--tells the parts to update.
-------------------------------

local rightMenu = require('games.Progg.RightMenu')
local BottomMenu = require('games.Progg.BottomMenu')
local buildArea = require('games.Progg.BuildArea')
local map = require('games.Progg.Map')

local Game = require('toolkit.Game')
--Will have to include the classes of the other components here
local inputHandler = require('games.Progg.GameInputHandler')
local ProggGame = extends(Game.class())

local Queue = require('games.Progg.Queue')
local Character = require('games.Progg.Character')
local Position = require('games.Progg.Position')
-----------------------------------------------------------
-- Constructor method, see toolkit.Game
-----------------------------------------------------------
function ProggGame:new(context)
  self.platformContext = context
  self:initListener()
  self.bottomMenu = BottomMenu:new(16)
  self.buildArea = buildArea:new(16)
  self.queue = Queue:new(self.bottomMenu, self.buildArea)
  self.character = Character:new(Position:new(0,0))
  self.rightMenu = rightMenu:new()

  --------------------------------
  -- attach all object to delegate, in this case the input handler
  --------------------------------
  self.inputHandler = inputHandler:new(self.platformContext, self.queue, self.character, self.rightMenu, self.buildArea)
  self.gameEventListener:attach(self.inputHandler)
  self.map = map:new()
  return self.class()
end

-----------------------------------------------------------
-- Loading resources, only called when the game starts
-- as of right now.
-----------------------------------------------------------
local function load()
  -----------------------
  -- call load on all resources e.g.
  -- UI:load()
  -----------------------
  ProggGame.inputHandler:load()
  ProggGame.map:load()
  ProggGame.bottomMenu:load()
  --ProggGame.bottomMenu:show()
  ProggGame.buildArea:load()
  ProggGame.buildArea:show()
  ProggGame.rightMenu:load()
  ProggGame.rightMenu:show()
end

-----------------------
--When the platform launches the game it calls this function
-----------------------
function ProggGame:start()
  load()
  ----------------------
  --We might need to do more here as well
  ----------------------
end


------------------------
--Updates the parts of the game
------------------------
function ProggGame:update()
  -----------------------
  --Calls update on all objects, e.g.
  --UI:update()
    self.bottomMenu:show()
    self.buildArea:show()
  self.inputHandler:show()
end

return ProggGame
