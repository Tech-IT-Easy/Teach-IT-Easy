local UIWindowViewController = require("toolkit.UIKit.UIWindowViewController")
local UIStartWindowController = extends(UIWindowViewController)

function UIStartWindowController:new(window)
  local o = UIStartWindowController:super(window)
  return UIStartWindowController:init(o)
end

function UIStartWindowController:onClickEvent(focusingView)
  if focusingView then
    print("I know who are you:"..focusingView.identity)
  end
end


return UIStartWindowController