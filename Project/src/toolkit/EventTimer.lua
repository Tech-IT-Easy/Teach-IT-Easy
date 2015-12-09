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
-- This class is for the event timer, usually a
-- timer is created with interval time and a callback which is a 
-- global function for doing some specific thing.
--
-- @Author:Created by Chuck, Nov 23,2015
-----------------------------------------------------------
  
local Object = require("toolkit.Object")
local EventTimer = extends(Object)

function EventTimer:new(args)
  local o = EventTimer:super()
  o.intervalMillisec = args.intervalMillisec
  o.callback = args.callback
  o.timer = sys.new_timer(o.intervalMillisec,o.callback)
  o.isStop = false;
  return EventTimer:init(o)
end

function EventTimer:setInterval(intervalMillisec)
  self.intervalMillisec = intervalMillisec
  self.timer:set_interval(intervalMillisec)
end

function EventTimer:stop()
  if self.isStop==false then
    self.timer:stop()
    self.isStop = true
  end
  ADLogger.trace("EventTimer:("..self.callback.." is stopped)")
end

function EventTimer:start()
  if self.isStop then
    self.timer:start()
    self.isStop = false
  end

  ADLogger.trace("EventTimer:("..self.callback.." is started)")
end

function EventTimer.updateScreen()
  gfx.update()
end

return EventTimer

