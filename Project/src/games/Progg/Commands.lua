------------------------------
--Class for containing the different commands to be executed.
--Defines the action for each key-input.
------------------------------

local Object = require("toolkit.Object")

local Commands = extends(Object)

Commands.MOVE = "move"
Commands.TURN_LEFT = "turn-left"
Commands.TURN_RIGHT = "turn-right"
Commands.LOOP = "loop"
Commands.IF_START = "if-start"
Commands.IF_END = "if-end"
Commands.P1 = "P1"
Commands.P2 = "P2"
-------------------------------------
--Constructor to create a new command-object.
------------------------------------
function Commands:new(action)
  local o = Commands:super()
  o.command = action
  return Commands:init(o)
end

return Commands