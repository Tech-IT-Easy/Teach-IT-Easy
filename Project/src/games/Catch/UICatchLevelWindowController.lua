-- Created by chuck, now it doesn't affect anything.
-- Don't consider this file, just keep it.

local UIWindowViewController = require("toolkit.UIKit.UIWindowViewController")
local UICatchLevelWindow = require('games.Catch.UICatchLevelWindow')
local Event = require('toolkit.Event')


local UICatchLevelWindowController = extends(UIWindowViewController)

function UICatchLevelWindowController:new(args)
  local o = UICatchLevelWindowController:super(UICatchLevelWindow:new())
  o.game = args.game
  o.window:initialize{levels=o.game.levels}
  o.immediateResponse = args.immediateResponse -- some wired key press when enter window for first time 
  return UICatchLevelWindowController:init(o)
end

function UICatchLevelWindowController:onClickEvent(sender)
  if immediateResponse then
    local levelNumber = sender.label.text
    self.game:windowOpen({windowName="mainWindow",windowArgs={level=levelNumber}})
  else
    immediateResponse = true
  end
end

function UICatchLevelWindowController:onKeyEvent(event)
  if event.key == Event.KEY_ZERO and event.state == Event.KEY_STATE_DOWN then
    self.game:exit()
  end
end

return UICatchLevelWindowController
