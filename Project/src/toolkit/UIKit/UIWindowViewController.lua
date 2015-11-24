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
-- A window is delegate of itself and is interested in every event
-----------------------------------------------------------
function UIWindowViewController:interestInEvent(event)
  return true
end

-----------------------------------------------------------
-- Get event inform form listener and do some default behaviour
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
    local sender = self.window.focusingView
    if sender then
      self:onClickEvent(sender)
      local identity = sender.identity
      if identity and sender.delegate and sender.delegate[identity.."_OnClickEvent"] then
        sender.delegate[identity.."_OnClickEvent"]()
      end
    end
  end
  
  self.window:moveTofocusByKey(event.key)
end

---------------------------------------------------------------
--

function UIWindowViewController:initWindow()
-- load data
-- add more components with program
end

function UIWindowViewController:onClickEvent(sender)
-- event process
end

return UIWindowViewController

