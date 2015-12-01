local Object = require("toolkit.Object")

local List = extends(Object)
function List:new()
  local o = List:super()
  o.first = nil
  o.current = nil
  o.last = nil
  return List:init(o)
end

function List:push(listNode,comp)
  -- list is nil, insert into first position
  if self.first == nil then 
    self.first = listNode
    self.last = listNode
    listNode.pre = listNode
    listNode.next = listNode
    
  -- listNode > first or listNode < last, insert into position between first and last
  elseif(comp(self.last,listNode) <= 0) or comp(self.first,listNode) > 0 then
    self.last.next = listNode
    listNode.pre = self.last
    listNode.next = self.first
    self.first.pre = listNode
    if comp(self.last,listNode) <= 0 then
      self.last = listNode
    elseif comp(self.first,listNode) > 0 then
      self.first = listNode
    end
  -- or rather, find the position whose value > listNode
  else
    local iter = self.first
    while(iter ~= self.last) do
      if comp(iter,listNode) <= 0 then --iter <= listNode
        iter = iter.next
      else
        break
      end
    end
    iter.pre.next = listNode
    listNode.pre = iter.pre
    listNode.next = iter
    iter.pre = listNode
  end

  self.current = self.first
end
function List:currentNode()
  if self.current then
    return self.current.value
  else 
    return nil
  end
end
function List:nextNode()
  self.current = self.current.next
  return self.current.value
end

function List:preNode()
  self.current = self.current.pre
  return self.current.value
end

return List
