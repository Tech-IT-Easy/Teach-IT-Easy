local Object = require("toolkit.Object")
local Character = extends(Object.class())
local Commands = require('games.Progg.Commands')



----
--Constructor of the character
----
function Character:new()
return self.class()
end


---
--Executes the given command
---
function Character:execute(command)

    if(command == Commands.MOVE) then
    --Moving up
    end

    if(command == Commands.TURN_LEFT) then
    --Moving left
    end

    if(command == Commands.TURN_RIGHT) then
    --moving right
    end

end


return Character