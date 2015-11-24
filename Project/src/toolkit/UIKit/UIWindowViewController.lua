local Controllable = require("toolkit.Controllable")
local Event = require("toolkit.Event")

local UIWindowViewController = extends(Controllable)

function UIWindowViewController:new(window)
  local o = UIWindowViewController:super()
  o.window = window
  o.window.delegate = o
  return UIWindowViewController:init(o)
end

function UIWindowViewController:presentView()--[[sender]]--)
  self.window:show()
end

-----------------------------------------------------------
-- Judge whether a event is interested by this controllable
-- object,this is typically used when listener notifies
-- @event which will be judged
-----------------------------------------------------------
function UIWindowViewController:interestInEvent(event)
  return true
end

-----------------------------------------------------------
-- Get event inform form listener
-- @listener which is the listener who send notify message,
--           it is kept for future extention
-- @event which will be judged
-----------------------------------------------------------
function UIWindowViewController:process(listener,event)
  if event.key == Event.KEY_LEFT and event.state == Event.KEY_STATE_DOWN then
    self.window:moveToPreFocus()
  elseif event.key == Event.KEY_RIGHT and event.state == Event.KEY_STATE_DOWN then
    self.window:moveToNextFocus()
  elseif event.key == Event.KEY_OK and event.state == Event.KEY_STATE_DOWN then
    self:onClickEvent(self.window.focusingView)
    if self.window.focusingView and self.window.focusingView.delegate then
      self.window.focusingView.delegate:onClickEvent()
    end
  end
end


function UIWindowViewController:initWindow()
  -- load data 
  -- add more components with program
end

function UIWindowViewController:onClickEvent(sender)
  -- event process
end

return UIWindowViewController

