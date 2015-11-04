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
Event.KEY_ONE = 5
Event.KEY_TWO = 6
Event.KEY_THREE = 7
Event.KEY_FOUR = 8
Event.KEY_FIVE = 9
Event.KEY_SIX = 10
Event.KEY_SEVEN = 11
Event.KEY_EIGHT = 12
Event.KEY_NINE = 13
Event.KEY_ZERO = 14

Event.KEY_STATE_DOWN = 1
Event.KEY_STATE_UP = 2
Event.KEY_STATE_BOTH = 3
--- Other events we are interested need to be added here


Event.formatSystemKey = {
["up"] = Event.KEY_UP,
["down"] = Event.KEY_DOWN,
["left"] = Event.KEY_LEFT,
["right"] = Event.KEY_RIGHT,
["1"] = Event.KEY_ONE,
["2"] = Event.KEY_TWO,
["3"] = Event.KEY_THREE,
["4"] = Event.KEY_FOUR,
["5"] = Event.KEY_FIVE,
["6"] = Event.KEY_SIX,
["7"] = Event.KEY_SEVEN,
["8"] = Event.KEY_EIGHT,
["9"] = Event.KEY_NINE,
["0"] = Event.KEY_ZERO
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