-----------------------------------------------------------
-- This class can show a people player with a image
--
-- @Author:Created by Chuck, Nov 16,2015
-----------------------------------------------------------

local UIView = require("toolkit.UIKit.UIView")
local People = extends(UIView)


function People:new(args)
  local o = People:super{frame=args.frame,container=args.container}
  o.image = args.image
  o.moveUnit = args.moveUnit or 0
  o.bonusMoveUnit = args.bonusMoveUnit or 0
  return People:init(o)
end

function People:show()
  screen:copyfrom(self.image.imageData, nil, self.globalFrame, true)
end

function People:run(bonus)
  if bonus==nil or bonus == false then
    self.frame.x = self.frame.x + self.moveUnit   
  else
    self.frame.x = self.frame.x + self.moveUnit + self.bonusMoveUnit
  end
  self:updateGlobalFrame()
end

return People
