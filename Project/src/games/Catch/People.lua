local UIView = require("toolkit.UIKit.UIView")
local People = extends(UIView)


function People:new(args)
  local o = People:super{frame=args.frame,container=args.container}
  o.image = args.image
  o.moveUnit = args.moveUnit
  return People:init(o)
end

function People:show()
  screen:copyfrom(self.image.imageData, nil, self.globalFrame, true)
end

function People:run()
  self.frame.x = self.frame.x + self.moveUnit   
  self:updateGlobalFrame()
end

return People
