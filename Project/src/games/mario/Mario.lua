-- this is a context of game which is responsible for the game objects creating


require('toolkit.Game')
require('toolkit.Hook')

Mario = Game:new()



----------------------------------------------------
-- create event listener hook to swap listen context to Mario context
----------------------------------------------------
beforeUpdateHook = Hook:new()
function beforeUpdateHook:beforeListenerUpdate(context,event)
  Mario.platformContext = context
  self.context = Mario
end
Mario.gameEventListener.beforeUpdateHook = beforeUpdateHook


----------------------------------------------------
-- Mario context responsible for all the game specific things
----------------------------------------------------
function Mario:new()

  -- override hook function to make some changes for mario, we need to change platform context to game context
  --function Mario.gameEventListener:beforeUpdate(context,event)
  --  Mario.platformContext = context
  --  self.context = Mario
  -- end
  
  -- create all the objects related in game
  
  -- attach all object to delegate
  
end




function Mario:start()
  self:load()
  
  -- start game
  print("start game")
  
end


function Mario:load()
  -- load resources 
  print("load action")
end


function Mario:update()
  -- object code update
  
  
  -- inform platform to update
  self.platformContext.update()
end



return Mario