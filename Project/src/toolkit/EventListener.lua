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
-- This class is for the event listener, usually a
-- context object will have a listener to transfer event to 
-- specific observers or add a chain listener.
--
-- @Author:Created by Chuck, Aug 16,2015
-- @Author:Updated by Chuck, Nov 11,2015 fit to new structure
-----------------------------------------------------------
local Object = require("toolkit.Object")

local EventListener = extends(Object)

-----------------------------------------------------------
-- Constructor method
-- @param context:Context (either PlatformContext or Game)
-- @return :EventListener new instance
-- @Author Chuck
-----------------------------------------------------------
function EventListener:new(context)
  local o = EventListener:super()
  
  -- Object which owns this listener
  o.context = context
  
  -- Objects which are registered in this listener
  o.observers = {}
  
  -- Chain listener which will be notified when this listener finishes updating
  o.chainListener = nil
  
  -- Hook for doing something before notifying
  -- self.beforeUpdateHook = nil
  return EventListener:init(o)
end


-----------------------------------------------------------
-- Add a chain listener to this listener. It will be notified
-- of every event this eventListener gets.
-- @param listener:EventListener
-- @Author Chuck
-----------------------------------------------------------
function EventListener:addChainListener(listener)
  self.chainListener = listener
end

-----------------------------------------------------------
-- Remove the chain listener from this listener
-- @Author Ludwig Wikblad
-----------------------------------------------------------
function EventListener:removeChainListener()
  self.chainListener = nil
end

-----------------------------------------------------------
-- Attach a object to this listener
-- @param object:Object which is being attached object
-----------------------------------------------------------
function EventListener:attach(object)
   table.insert(self.observers,object)
end

-----------------------------------------------------------
-- Remove an object from this listener.
-- @param object:Object which is being removed
-- @Author Ludwig Wikblad
-----------------------------------------------------------
function EventListener:remove(object)
  for _,obj in pairs(self.observers) do
    if obj == object then
      table.remove(self.observers, _)
    end
  end
end
-----------------------------------------------------------
-- Notify all the observers which has been attached to this listener
-- @param event:Event which is event currently happening
-- @Author Chuck
-----------------------------------------------------------
function EventListener:notifyAllObservers(event)
  for _,object in pairs(self.observers) do
    if object:interestInEvent(event) == true then
      object:process(self,event)
    end
  end
end

-----------------------------------------------------------
-- Some event trigger this listener in specific context 
-- @param context:PlatformContext;Game which specific context where event happens
-- @param event:Event which is event currently happening
-- @author Chuck
-----------------------------------------------------------
function EventListener:update(event)  
  -- do some thing before notify, such as change context content
  -- if beforeUpdateHook ~= nil then
    -- self.beforeUpdateHook:beforeListenerUpdate(context,event)  
  -- end
  
  -- notify all observers the events
  self:notifyAllObservers(event)
  
  -- notify chain listener which is usually a game listener
  if self.chainListener ~= nil then
    self.chainListener:update(event)
  end

end

return EventListener
