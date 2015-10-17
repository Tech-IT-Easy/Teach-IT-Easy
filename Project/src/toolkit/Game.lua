-----------------------------------------------------------
-- This class is for avoiding system cohesion. It is super class
-- of all specific game.
--
-- @Author:Created by Chuck, Aug 16,2015
-- @Author:Updated by author,date
-----------------------------------------------------------

local EventListener = require('toolkit.EventListener')
local Object = require('toolkit.Object')

local Game = extends(Object.class())

-----------------------------------------------------------
-- Construct method
-----------------------------------------------------------
function Game:new()

  -- A game need to know current paltform context 
  self.platformContext = nil
  self.gameEventListener = nil
  return self.class()
end

function Game:initListener()
  -- Default event listener
  if self.platformContext ~= nil then
    self.gameEventListener = EventListener:new(self)
    self.platformContext.platformEventListener:addChainListener(self.gameEventListener)
  else
    print("add listener error");
  end
end

return Game