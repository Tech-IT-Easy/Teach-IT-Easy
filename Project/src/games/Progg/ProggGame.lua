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
local ProggGame = extends(Game)

local Queue = require('games.Progg.Queue')
local Character = require('games.Progg.Character')
local Position = require('games.Progg.Position')

-----------------------------------------------------------
-- Constructor method, see 'toolkit.Game'
-- @param context - A pointer to the context that the game exists in
-- @return a new queue instance
-----------------------------------------------------------
function ProggGame:new(context)
  local o = ProggGame:super()
  o.bottomMenu = BottomMenu:new(16)
  o.buildArea = buildArea:new(16)
  o.queue = Queue:new(o.bottomMenu, o.buildArea)
  o.character = Character:new(Position:new(0,0))
  o.rightMenu = rightMenu:new()
  o.map = map:new()
  o.inputHandler = inputHandler:new(context, o.queue, o.character, o.rightMenu, o.buildArea, o.bottomMenu)
  --------------------------------
  -- super characters
  --------------------------------
  self.platformContext = context
  self:initListener()
  self.gameEventListener:attach(o.inputHandler)
  return ProggGame:init(o)
end

-----------------------------------------------------------
-- Loading resources, only called when the game starts
-- as of right now.
-----------------------------------------------------------
function ProggGame:load()
  -----------------------
  -- call load on all resources e.g.
  -- UI:load()
  -----------------------
  self.inputHandler:load()
  self.map:load()
  self.bottomMenu:load()
  self.buildArea:load()
  self.rightMenu:load()
  self.rightMenu:show()
end

-----------------------
--When the platform launches the game it calls this function
-----------------------
function ProggGame:start()
  self:load()
  ----------------------
  --We might need to do more here as well
  ----------------------
end


------------------------
--Updates all objects that are part of the game
-- and are displayed on the screen
------------------------
function ProggGame:update()
  self.bottomMenu:show(self.inputHandler:getinputArea())
  self.buildArea:show()
  self.inputHandler:show()
end

return ProggGame
