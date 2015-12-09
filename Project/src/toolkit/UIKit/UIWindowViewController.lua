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
-- This class manage UIWindowView, create it and show it
--
-- @Author:Created by Chuck, Nov 16,2015
-----------------------------------------------------------

local Controllable = require("toolkit.Controllable")
local Event = require("toolkit.Event")

local UIWindowViewController = extends(Controllable)

function UIWindowViewController:new(window)
  assert(window,"UIWindowViewController(window),error:window parameter can't be nil")
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
  elseif event.key == Event.KEY_UP and event.state == Event.KEY_STATE_DOWN then
    self.window:moveToUpFocus()
  elseif event.key == Event.KEY_DOWN and event.state == Event.KEY_STATE_DOWN then
    self.window:moveToDownFocus()
  elseif event.key == Event.KEY_OK and event.state == Event.KEY_STATE_DOWN then
    if self.window.enterEnable == true then
      local sender = self.window.focusingView
      if sender then
        self:onClickEvent(sender)
        local identity = sender.identity
        if identity and sender.delegate and sender.delegate[identity.."_OnClickEvent"] then
          sender.delegate[identity.."_OnClickEvent"]()
        end
      end
    end
  elseif event.state == Event.KEY_STATE_DOWN then
    -- if there is shortcut key then make a click event 
    local isKey = self.window:moveTofocusByKey(event.key)
    if isKey then
      local sender = self.window.focusingView
      self:onClickEvent(sender)
    end
  end
  self:onKeyEvent(event)
end
function UIWindowViewController:onKeyEvent(event)
  -- subclass can implemented this as customer
end

function UIWindowViewController:intialize()
-- load data
-- add more components with program
end

function UIWindowViewController:onClickEvent(sender)
-- event process
end

return UIWindowViewController

