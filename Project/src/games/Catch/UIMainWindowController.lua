-- Created by chuck, now it doesn't affect anything. 
-- Don't consider this file, just keep it.

local UIWindowViewController = require("toolkit.UIKit.UIWindowViewController")
local UIMainWindowController = extends(UIWindowViewController)

function UIMainWindowController:new(window)
  local o = UIMainWindowController:super(window)
  return UIMainWindowController:init(o)
end

function UIMainWindowController:onClickEvent(focusingView)
  if focusingView then
    print("I know who are you:"..focusingView.identity)
  end
end


return UIMainWindowController