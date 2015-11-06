--
-- Created by IntelliJ IDEA.
-- User: Ludwig
-- Date: 2015-11-06
-- Time: 16:17
-- To change this template use File | Settings | File Templates.

--This is not using the toolkit.Object, instead it implements it's own OOP. But it works^^
--

New_queue = {}

function New_queue:new()
  local newObj = {actions = {}}
  self.__index = self
  return setmetatable(newObj, self)
end

function New_queue:pop()
  table.remove(self.actions)
end

function New_queue:push(obj)
  table.insert(self.actions, obj)
end

function New_queue:getExecutionQueue()
  local newObj = New_queue:new()
  for i = 1, #self.actions do
    table.insert(newObj.actions, i, self.actions[#self.actions - i])
  end
  return newObj
end

return New_queue