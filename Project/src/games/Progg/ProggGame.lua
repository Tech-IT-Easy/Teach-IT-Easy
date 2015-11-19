-------------------------------
--The highest level for the game. Creates the parts of the game and
--tells the parts to update.
-------------------------------

local rightMenu = require('games.Progg.RightMenu')
local BottomMenu = require('games.Progg.BottomMenu')

local map = require('games.Progg.Map')

local Game = require('toolkit.Game')
--Will have to include the classes of the other components here
--local inputHandler = require('games.Progg.GameInputHandler')
local ProggGame = extends(Game)





local Position = require('games.Progg.Position')

-----------------------------------------------------------
-- Constructor method, see 'toolkit.Game'
-- @param context - A pointer to the context that the game exists in
-- @return a new queue instance
-----------------------------------------------------------
function ProggGame:new(context)
  local o = ProggGame:super()
  
  -- @member Position:Position
  -- @member rightMenu:RightMenu
  -- @member BottomMenu:BottomMenu
  -- @member map:Map
  o.bottomMenu = BottomMenu:new({["queue"] = 9, ["loop"] = 11, ["P1"] = 13, ["P2"] = 16 },context)
  o.rightMenu = rightMenu:new()
  --o.map = map:new()
  --------------------------------
  -- super characters
  --------------------------------
  self.platformContext = context
  self:initListener()
  --self.gameEventListener:attach(o.inputHandler)
  self.gameEventListener:attach(o.rightMenu)
  self.gameEventListener:attach(o.bottomMenu)
  
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
  --self.map:load()
  self.bottomMenu:load()
  self.rightMenu:load()
  self.rightMenu:show()
  --self.rightMenu:show()
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
  -----------------------
  --Calls update on all objects, e.g.
  --UI:update()
  self.bottomMenu:show()
 
  --self.buildArea:show()
  --self.inputHandler:show()
end

return ProggGame
