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


-- performance is slow
function List:reset(listNode,comp)
  local v = self:getNodeByValue(listNode)
  if v then
    remove(listNode)
  end
  self:push(listNode,comp)
end

function List:remove(listNode)
  if listNode then
    if self.first == self.last then
      self.first = nil
      self.last = nil
      self.current = nil
    else
      if listNode == self.current then
        self.current = self.current.next
      end
      listNode.pre.next = listNode.next
      listNode.next.pre = listNode.pre
    end
  end
end

function List:getNodeByValue(view)
  if self.first == nil then
    return nil
  end
  
  if self.last.view == view then
    return self.last
  end
  
  local iter = self.first
  while (iter ~= self.last) and (iter.value.view ~= view) do
    iter = iter.next
  end
  if iter.value.view == view then
    return iter
  end
  
  return nil
end


function List:setCurrentNode(view)
  assert(self.first,"List:setCurrentNode(view),error: list is null")
  local v = self:getNodeByValue(view)
  if v then
    self.current = v
  end
end


function List:currentNode()
  return self.current.value;
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
