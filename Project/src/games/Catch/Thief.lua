local People = require("games.Catch.People")
local Thief = extends(People)


function Thief:new(args)
  local o = Thief:super(args)

  return Thief:init(o)
end


return Thief
