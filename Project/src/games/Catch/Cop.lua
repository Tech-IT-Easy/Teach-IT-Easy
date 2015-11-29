local People = require("games.Catch.People")
local Cop = extends(People)


function Cop:new(args)
  local o = Cop:super(args)

  return Cop:init(o)
end

return Cop
