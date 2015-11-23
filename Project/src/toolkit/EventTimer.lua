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

