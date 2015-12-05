-- Created by chuck, now it doesn't affect anything.
-- Don't consider this file, just keep it.

local UIWindowViewController = require("toolkit.UIKit.UIWindowViewController")
local UICatchLevelWindow = require('games.Catch.UICatchLevelWindow')
local Event = require('toolkit.Event')
local UILabel = require("toolkit.UIKit.UILabel")
local THEME = require("games/Catch/data/theme")


local UICatchLevelWindowController = extends(UIWindowViewController)

function UICatchLevelWindowController:new(args)
  local o = UICatchLevelWindowController:super(UICatchLevelWindow:new())
  o.game = args.game
  o.window:initialize{levels=o.game.levels}
  o.immediateResponse = args.immediateResponse
  return UICatchLevelWindowController:init(o)
end

function UICatchLevelWindowController:onClickEvent(sender)
  if immediateResponse then
    local levelNumber = sender.label.text
    print(levelNumber)
    self.game:windowOpen({windowName="mainWindow",windowArgs={level=levelNumber}})
  else
    immediateResponse = true
  end
end

return UICatchLevelWindowController
