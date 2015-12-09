
-----------------------------------------------------------
-- This class provides a implementation of a double circle 
-- list that can be used for any datatype.
-- @Author:Created by Chuck, Nov 16,2015
-----------------------------------------------------------

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

function List:getNodeByValue(node,comp)
  if self.first == nil then
    return nil
  end
  
  if comp(self.last,node)==0 then
    return self.last
  end
  
  local iter = self.first
  while (iter ~= self.last) and comp(iter,node)~=0 do
    iter = iter.next
  end
  if comp(iter,node)==0 then
    return iter
  end
  
  return nil
end


function List:setCurrentNode(node,comp)
  assert(self.first,"List:setCurrentNode(view),error: list is null")
  local v = self:getNodeByValue(node,comp)
  assert(v,"List:setCurrentNode(view),error: view is not found")
  self.current = v
end


function List:currentNode()
  if self.current then
    return self.current.value;
  else
    return nil
  end
end
function List:nextNode()
  self.current = self.current.next
  return self.current.value
end

function List:nextDifferNode(comp)
  local currentPre = self.current.pre
  local iter = self.current
  while ((iter~=currentPre) and (comp(iter,iter.next)==0)) do
    iter = iter.next
  end
  
  self.current = iter.next
  return self.current
end

function List:preDifferNode(comp)
  local currentNext = self.current
  local iter = self.current.pre
  
   
  while ((iter~=currentNext) and (comp(iter,iter.pre)==0)) do
    iter = iter.pre
  end
  
  self.current = iter
  return self.current
end


function List:preNode()
  self.current = self.current.pre
  return self.current.value
end

return List
