-------------------------------
--The highest level for the game. Creates the parts of the game and
--calls the parts to update them.
-------------------------------

local Game = require('toolkit.Game')
--Will have to include the classes of the other components here
local ExampleActor = require('games.mario.ExampleActor')

local ProggGame = extends(Game.class())

-----------------------------------------------------------
-- Constructor method, see toolkit.Game
-----------------------------------------------------------
function ProggGame:new(context)
  self.platformContext = context
  self:initListener()
  --------------------------------
  -- attach all object to delegate
  --------------------------------
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
end


function Mario:start()
  load()
  ----------------------
  --We might need to do more here as well
  ----------------------
end


------------------------
--Updates 
------------------------
function Mario:update()
-----------------------
--Calls update on all objects, e.g.
--UI:update()
end


return ProggGame