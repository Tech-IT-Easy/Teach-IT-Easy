local Controllable = require("toolkit.Controllable")
local UIWindowViewController = extends(Controllable)

function UIWindowViewController:new()
  local o = UIWindowViewController:super()
  o.window = args.window
  return UIWindowViewController:init(o)
end

function UIWindowViewController:new()

end



