local Object = require("toolkit.Object")
local LifeBar = extends(Object)


function LifeBar:new()
  local o = LifeBar:super()

  return LifeBar:init(o)
end

return LifeBar
