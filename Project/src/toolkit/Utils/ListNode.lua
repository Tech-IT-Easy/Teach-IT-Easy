local Object = require("toolkit.Object")

local ListNode = extends(Object)
function ListNode:new(args)
  local o = ListNode:super()
  o.value = args
  o.next = nil
  o.pre = nil
  return ListNode:init(o)
end

return ListNode