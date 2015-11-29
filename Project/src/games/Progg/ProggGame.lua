-------------------------------
--The highest level for the game. Creates the parts of the game and
--tells the parts to update.
-------------------------------

local rightMenu = require('games.Progg.RightMenu')
local BottomMenu = require('games.Progg.BottomMenu')
local Game = require('toolkit.Game')
--Will have to include the classes of the other components here
local ProggGame = extends(Game)


-----------------------------------------------------------
-- Constructor method, see 'toolkit.Game'. Called by GameFactory.
-- @param context:PlatformContext - A pointer to the context that the game exists in
-- @return a new game:ProggGame instance
-----------------------------------------------------------
function ProggGame:new(context, level)
  local o = ProggGame:super()

  -- @member BottomMenu:BottomMenu
  -- @member map:Map
  local levelData = context.proggGameLevels[2]
  print(levelData.maxCommands.queue)
--  o.bottomMenu = BottomMenu:new(levelData, context)
  o.bottomMenu = BottomMenu:new(levelData, context)
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
-- @author Ludwig Wikblad, changed by others when needed
-----------------------------------------------------------
function ProggGame:load()
  -----------------------
  -- call load on all resources e.g.
  -- UI:load()
  -----------------------
  --self.map:load()
  self.bottomMenu:load()
end

-----------------------
--When the platform launches the game it calls this function
-- @author Chuck
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
-- @author Chuck
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
