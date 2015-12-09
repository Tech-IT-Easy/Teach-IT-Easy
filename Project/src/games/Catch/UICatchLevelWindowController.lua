--[[TEACH IT EASY, an educational games platform
    Copyright (C) 2015  Linköping University

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.


    MIT LICENSE:
    Copyright (c) 2015 Zenterio AB

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:



    The above copyright notice and this permission notice shall be included in
    all copies or substantial portions of the Software.


    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
    THE SOFTWARE.


    ]]
-----------------------------------------------------------
-- This is window controller that is responsible for managing 
-- the Level Selection window such as creating and initializing
--
-- @Author:Created by Chuck, Nov 16,2015
-----------------------------------------------------------

local UIWindowViewController = require("toolkit.UIKit.UIWindowViewController")
local UICatchLevelWindow = require('games.Catch.UICatchLevelWindow')
local Event = require('toolkit.Event')


local UICatchLevelWindowController = extends(UIWindowViewController)

function UICatchLevelWindowController:new(args)
  local unlockedLevels = args.context.profile.gameprogress:getProgress("games.Catch.Catch").level
  if unlockedLevels < 8 then 
    unlockedLevels = unlockedLevels + 1
  end
  local o = UICatchLevelWindowController:super(UICatchLevelWindow:new{levelNumber=unlockedLevels})
  o.game = args.game
  o.window:initialize{levels=o.game.levels}
  o.immediateResponse = args.immediateResponse -- some wired key press when enter window for first time 
  return UICatchLevelWindowController:init(o)
end

function UICatchLevelWindowController:onClickEvent(sender)
  if self.immediateResponse then
    local levelNumber = sender.label.text
    self.game:windowOpen({windowName="mainWindow",windowArgs={level=levelNumber}})
  else
    self.immediateResponse = true
  end
end

function UICatchLevelWindowController:onKeyEvent(event)
  if event.key == Event.KEY_BACK and event.state == Event.KEY_STATE_DOWN then
    self.game:exit()
  end
end

return UICatchLevelWindowController
