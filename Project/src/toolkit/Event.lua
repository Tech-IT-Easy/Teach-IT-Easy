-----------------------------------------------------------
-- This class is for the system events translating to make all
-- events consistent 
--
-- @Author:Created by Chuck, Aug 16,2015
-- @Author:Updated by author,date
-----------------------------------------------------------

local Object = require('toolkit.Object')

local Event = extends(Object.class())

Event.KEY_UP = 1
Event.KEY_DOWN = 2
Event.KEY_LEFT = 3
Event.KEY_RIGHT = 4

Event.KEY_STATE_DOWN = 1
Event.KEY_STATE_UP = 2
Event.KEY_STATE_BOTH = 3
--- Other events we are interested need to be added here


Event.formatSystemKey = {
["up"] = Event.KEY_UP,
["down"] = Event.KEY_DOWN,
["left"] = Event.KEY_LEFT,
["right"] = Event.KEY_RIGHT

--- Other events we are interested need to be added here
}

Event.formatSystemState = {
["up"] = Event.KEY_STATE_UP,
["down"] = Event.KEY_STATE_DOWN,
--- Other events we are interested need to be added here
}

function Event:new(key,state)
  self.key = self.formatSystemKey[key]
  self.state = self.formatSystemState[state]
  return self.class()
end





return Event