-----------------------------------------------------------
-- This class is for avoiding system cohesion. It is super class
-- of all specific game.
--
-- @Author:Created by Chuck, Aug 16,2015
-- @Author:Updated by Chuck, Nov 11,2015 fit to new structure
-----------------------------------------------------------

local EventListener = require('toolkit.EventListener')
local Object = require('toolkit.Object')

local Game = extends(Object)

-----------------------------------------------------------
-- Construct method
-- @param context:PlatformContext which specific context the game belongs to
-- @return :Game a new instance of a game
-----------------------------------------------------------
function Game:new(context)
  local o = Game:super()
  
  -- A game need to know current paltform context 
  o.platformContext = nil
  
  -- Game owns itself listener to know what events are happening
  o.gameEventListener = nil
  
  return Game:init(o)
end

-----------------------------------------
-- Adds the Games listener as a chainListener to the PlatformContext's listener
-- @author Chuck
-----------------------------------------
function Game:initListener()
  -- Default event listener
  if self.platformContext ~= nil then
    self.gameEventListener = EventListener:new(self)
    self.platformContext.platformEventListener:addChainListener(self.gameEventListener)
  else
    print("add listener error")
  end
end

return Game