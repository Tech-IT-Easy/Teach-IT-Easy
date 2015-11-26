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
--Commands.IF_START = "if-start"
--Commands.IF_END = "if-end"
Commands.IF = "if"
Commands.P1 = "P1"
Commands.P2 = "P2"
-------------------------------------
--Constructor to create a new command-object.
-- Not currently used 19/11
-- @param action:Commands the action to save in the command
-- @return command:Commands
-- @author Vilhelm Granath
------------------------------------
function Commands:new(action)
  local o = Commands:super()
  o.command = action
  return Commands:init(o)
end

return Commands