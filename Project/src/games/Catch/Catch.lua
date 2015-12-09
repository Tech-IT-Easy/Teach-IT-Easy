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
-------------------------------
--The highest level for the game. Creates the parts of the game and
--tells the parts to update.
-------------------------------

local Game = require('toolkit.Game')
local Catch = extends(Game)

local UICatchMainWindowController = require('games.Catch.UICatchMainWindowController')
local UICatchLevelWindowController = require('games.Catch.UICatchLevelWindowController')
local UIAlertWindowController = require("toolkit.UIKit.UIAlertWindowController")
local UIButtonView = require("toolkit.UIKit.UIButtonView")
local UILabel = require("toolkit.UIKit.UILabel")
local THEME = require("games.Catch.data.theme")

-----------------------------------------------------------
-- Constructor method, see 'toolkit.Game'
-- @param context - A pointer to the context that the game exists in
-- @return a new queue instance
-----------------------------------------------------------
function Catch:new(context)
  local o = Catch:super()
  self.platformContext = context
  self:initListener()
  return Catch:init(o)
end

-----------------------------------------------------------
-- Loading resources, only called when the game starts
-- as of right now.
-----------------------------------------------------------
function Catch:load()
  self.levels = require("games.Catch.data.levels.Levels")
end

-----------------------
--When the platform launches the game it calls this function
-----------------------

function Catch:start()
  self:load()
  self.windowController = UICatchLevelWindowController:new({game=self,immediateResponse=false,context=self.platformContext}) --UICatchMainWindowController
  self.gameEventListener:attach(self.windowController)
  print("Starting game Catch...")

end


------------------------
-- Updates all objects that are part of the game
-- and are displayed on the screen
------------------------
function Catch:update()
  if self.windowController then
    self.windowController:presentView()
  end
  if self.alertController then
    self.alertController:presentView()
  end
end

--args={windowName='',windowArgs={}}
function Catch:windowOpen(args)
  --self.lastWindowController = self.windowController
  self.gameEventListener:remove(self.windowController)
  if args == nil or args.windowName == "levelWindow" then
    self.windowController = UICatchLevelWindowController:new({game=self,immediateResponse=args.immediateResponse or false,context=self.platformContext})
  elseif args.windowName == "mainWindow" then
    self.windowController = UICatchMainWindowController:new({level = args.windowArgs.level,game=self,context=self.platformContext} )
  end
  self.gameEventListener:attach(self.windowController)
  self.newWindow = true
  collectgarbage()
end

function Catch:windowClose(args)
  self.gameEventListener:attach(self.lastWindowController)
  self.gameEventListener:remove(self.windowController)
  self.windowController = self.lastWindowController
end

function Catch:alertWindowOpen(args)
  self.newWindow = false
  self.gameEventListener:remove(self.windowController)
  self.alertController = UIAlertWindowController:new{title=args.title,OK=args.OK,Cancel=args.Cancel,
    callback=function(sender)
      args.callback(sender)
      self:alertWindowClose()
    end
  }
  self.gameEventListener:attach(self.alertController)
end

function Catch:alertWindowClose()
  -- avoid double attach problem
  if self.newWindow~= true then
    self.gameEventListener:attach(self.windowController)
  end
  self.gameEventListener:remove(self.alertController)
  self.alertController = nil
end

function Catch:exit()
  self.platformContext.platformEventListener:removeChainListener()
  self.platformContext:createNewMenu("games")
  self.platformContext.game = nil
  collectgarbage()
end

return Catch
