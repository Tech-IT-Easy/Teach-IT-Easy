--[[TEACH IT EASY, an educational games platform
    Copyright (C) 2015  Linköping University

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.


    MIT LICENSE:
    Copyright (c) 2015 Zenterio AB

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:



    The above copyright notice and this permission notice shall be included in
    all copies or substantial portions of the Software.


    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
    THE SOFTWARE.


    ]]
-----------------------------------------------------------
-- This class is for the system events translating to make all
-- events consistent 
--
-- @Author:Created by Chuck, Aug 16,2015
-- @Author:Updated by Chuck, Nov 11,2015 fit to new structure
-----------------------------------------------------------

local Object = require('toolkit.Object')

local Event = extends(Object)

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
Event.KEY_OK = 15
Event.KEY_BACK = 16

Event.KEY_STATE_DOWN = 1
Event.KEY_STATE_UP = 2
Event.KEY_STATE_BOTH = 3
--- Other events we are interested need to be added here

---------------------------------
-- A way to format a key to a Constant,
-- for consistent use in the entire program
-- @author Chuck
---------------------------------
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
["0"] = Event.KEY_ZERO,
["ok"] = Event.KEY_OK,
["back"] = Event.KEY_BACK

--- Other events we are interested need to be added here
}
---------------------------------
-- A way to format a state to a Constant
-- for consistent use in the entire program
-- @author Chuck
---------------------------------
Event.formatSystemState = {
["up"] = Event.KEY_STATE_UP,
["down"] = Event.KEY_STATE_DOWN,
--- Other events we are interested need to be added here
}
--------------------------------------------
-- Constructor method for Event.
-- @param key:String the pressed key
-- @param state:String the state of the key, e.g. "up" or "down"
-- @return event:Event new instance of an event
-- @author Chuck
--------------------------------------------
function Event:new(key,state)
  local o = Event:super()
  o.key = self.formatSystemKey[key]
  o.state = self.formatSystemState[state]
  return Event:init(o)
end

return Event