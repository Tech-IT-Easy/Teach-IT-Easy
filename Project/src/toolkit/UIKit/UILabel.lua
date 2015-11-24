-----------------------------------------------------------
-- This class is a data type which define text properties
--
-- @Author:Created by Chuck, NOV 19,2015
-----------------------------------------------------------

local Object = require("toolkit.Object")
local UILabel = extends(Object)

UILabel.FONT_GROBOLD = 'data/GROBOLD.ttf'

function UILabel:new(args)
  local o = UILabel:super()
  --@memeber text string e.g. "label"
  o.text = args.text
  --@member color e.g. {r=2,g=2,b=2}
  o.color = args.color
  --@member size integer e.g. 20
  o.size = args.size
  --@member font e.g. UILabel.FONT_GROBOLD
  o.font = args.font
  return UILabel:init(o)
end

return UILabel