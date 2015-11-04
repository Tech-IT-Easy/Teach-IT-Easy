------------------------------
--Class for containing the different commands to be executed.
--Defines the action for each key-input.
------------------------------

local Object = require("toolkit.Object")

local Commands = extends(Object.class())

Commands.KEY_ONE = "move"
Commands.KEY_TWO = "turn-c"
Commands.KEY_THREE = "turn-cc"
Commands.KEY_FOUR = "action"
Commands.KEY_FIVE = "if"
Commands.KEY_SIX = "loop"
Commands.KEY_SEVEN = "p1"
Commands.KEY_EIGHT = "p2"
Commands.KEY_NINE = "placeholder"

-------------------------------------
--Constructor to create a new command-object.
------------------------------------
function Commands:new(key,state)
  self.command = key
  return self.class()
end

return Commands