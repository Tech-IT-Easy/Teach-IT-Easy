local People = require("games.Catch.People")
local Cop = extends(People)


function Cop:new(args)
  local o = Cop:super(args)
  return Cop:init(o)
end

function Cop:catch(thief)
  if self.frame.x == thief.frame.x then
    return true
  end
  return false
end 

return Cop
