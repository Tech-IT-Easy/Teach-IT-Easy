local Object = require("toolkit.Object")
local People = extends(Object)

local LifeBar = require("games.Catch.LifeBar")


function People:new(args)
  local o = People:super()

  o.lifeBar = LifeBar:new()
  o.image = args.image
  o.frameSize = args.frameSize

  return People:init(o)
end

return People
