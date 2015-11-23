local Controllable = require("toolkit.Controllable")
local UIWindowViewController = extends(Controllable)

function UIWindowViewController:new(window)
  local o = UIWindowViewController:super()
  o.window = window
  o.window.delegate = o
  self:initWindow()
  return UIWindowViewController:init(o)
end

function UIWindowViewController:presentView(sender)
  self.window:show()
end

-----------------------------------------------------------
-- Judge whether a event is interested by this controllable
-- object,this is typically used when listener notifies
-- @event which will be judged
-----------------------------------------------------------
function UIWindowView:interestInEvent(event)
  return true
end

-----------------------------------------------------------
-- Get event inform form listener
-- @listener which is the listener who send notify message,
--           it is kept for future extention
-- @event which will be judged
-----------------------------------------------------------
function UIWindowView:process(listener,event)
  if event.key == Event.KEY_LEFT and event.state == Event.KEY_STATE_DOWN then
    self.window:moveToPreFocus()
  elseif event.key == Event.KEY_RIGHT and event.state == Event.KEY_STATE_DOWN then
    self.window:moveToNextFocus()
  elseif event.key == Event.KEY_OK and event.state == Event.KEY_STATE_DOWN then
    self:onOKEvent(focusingView)
  end
end


function UIWindowViewController:initWindow()
  -- load data 
  -- add more components with program
end

function UIWindowViewController:clickOKEvent(sender)
  
end

