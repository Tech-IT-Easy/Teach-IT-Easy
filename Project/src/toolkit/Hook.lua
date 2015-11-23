-----------------------------------------------------------
-- This class is for hook function to make object capable to do
-- something before some function happens. It will know all the 
-- hook function in whole game
--
-- @Author:Created by Chuck, Aug 16,2015
-- @Author:Updated by Chuck, Nov 11,2015 fit to new structure
-----------------------------------------------------------
local Object = require("toolkit.Object")
local Hook = extends(Object)

-----------------------------------------------------------
-- Hook function for listener when updating, which owns same parameters 
-- @param context:PlatformContext which specific context where event happens
-- @param event:Event which is event currently happening
-- @author Chuck
-----------------------------------------------------------
function Hook:beforeListenerUpdate(conext,event)
  -- do some events process in specific object, never change here
end

return Hook