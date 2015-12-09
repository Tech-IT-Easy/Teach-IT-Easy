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
-- This is a Level Selection window with eight boxes
--
-- @Author:Created by Chuck, Nov 16,2015
-----------------------------------------------------------

local UIWindowView = require("toolkit.UIKit.UIWindowView")
local UIPanelView = require("toolkit.UIKit.UIPanelView")
local UIRectangleView = require("toolkit.UIKit.UIRectangleView")
local UICollectionView = require("toolkit.UIKit.UICollectionView")
local UICollectionCellView = require("toolkit.UIKit.UICollectionCellView")
local UIButtonView = require("toolkit.UIKit.UIButtonView")
local UILabelView = require("toolkit.UIKit.UILabelView")
local UILabel = require("toolkit.UIKit.UILabel")
local UIImage = require("toolkit.UIKit.UIImage")
local Event = require("toolkit.Event")
local THEME = require("games.Catch.data.theme")

-- This is a instance window, which is created for using when required
local UICatchLevelWindow = extends(UIWindowView)

function UICatchLevelWindow:new(args)
  local window = UICatchLevelWindow:super{title="Window Title",backgroundImage=UIImage:new(THEME.IMAGE.GAME_BACKGROUND)}

  -- private data model with <local>
  -- components
  window.levelNumber = args.levelNumber
  window.lockImage = UIImage:new(THEME.IMAGE.LOCK_LEVEL)
  
  window.buttons = {}
  local textLabel = UILabel:new{identity="CHOOSE LEVEL",text="CHOOSE LEVEL",color=THEME.COLOR.WHITE,size=70,font=UILabel.FONT_GROBOLD} 
  window.title = UILabelView:new{identity="catachWindowTitle",frame={x=400,y=20,w=0,h=0},label=textLabel}

  -- calculate menuPanel width,height,pisition based on menu item size
  local menuPanelWidth = (THEME.LEVEL.RECTANGLE_SIZE + THEME.LEVEL.RECTANGLE_SPACE) * THEME.LEVEL.COLUMNS - THEME.LEVEL.RECTANGLE_SPACE
  local menuPanelHeight = (THEME.LEVEL.RECTANGLE_SIZE + THEME.LEVEL.RECTANGLE_SPACE) * THEME.LEVEL.ROWS - THEME.LEVEL.RECTANGLE_SPACE
  local menuPanelAlignCenterPosition = {x=(screen:get_width()-menuPanelWidth)/2,y = (screen:get_height()-menuPanelHeight)/2}
  
  window.menuPanel = UIPanelView:new{frame={x=menuPanelAlignCenterPosition.x, y = menuPanelAlignCenterPosition.y,w=menuPanelWidth,h=menuPanelHeight}}--,backgroundColor=THEME.COLOR.DARK_GRAY}
  window.collectionPanel = UICollectionView:new{frame={x=0,y=0,w=menuPanelWidth,h=menuPanelHeight},space=THEME.LEVEL.RECTANGLE_SPACE,cols=THEME.LEVEL.COLUMNS,rows=THEME.LEVEL.ROWS}--,backgroundColor=THEME.COLOR.LIGHT_GRAY}
  window.menuPanel:addChildView(window.collectionPanel)
  --layout menu items with collection layout view
  local labels = {}
  local cells = {}
  local modReplaceList = {1,3,5,7,2,4,6,8}
  local textAlignCenterPosition = {x=(THEME.LEVEL.RECTANGLE_SIZE - THEME.LEVEL.FONT_SIZE)/2,y=(THEME.LEVEL.RECTANGLE_SIZE - THEME.LEVEL.FONT_SIZE)/2}
  for i = 1, THEME.LEVEL.ROWS do
    for j = 1, THEME.LEVEL.COLUMNS do
      local index = (i-1) * THEME.LEVEL.COLUMNS + j
        labels[index] = UILabel:new{identity="level"..index,text=index.."",color=THEME.COLOR.DARK_GRAY_1,size=THEME.MENU.FONT_SIZE,font=UILabel.FONT_GROBOLD }
        if index <= window.levelNumber then
           window.buttons[index] = UIButtonView:new{identity="catchWindowLevelSelect"..index,enableFocus=true,frame=THEME.FRAME.BUTTON,borderColor=THEME.COLOR.DARK_GRAY_1,borderWidth = THEME.MENU.BORDER_WIDTH,label=labels[index],labelPosition=textAlignCenterPosition}
           window:setFocusWeight{view=window.buttons[index], hWeight=index, vWeight=modReplaceList[index]}
        else
          window.buttons[index] = UIButtonView:new{identity="catchWindowLevelSelect"..index,enableFocus=false,frame=THEME.FRAME.BUTTON,borderColor=THEME.COLOR.DARK_GRAY_1,borderWidth = THEME.MENU.BORDER_WIDTH,backgroundImage=window.lockImage}--label=labels[index],labelPosition=textAlignCenterPosition}
        end
        cells[index] = UICollectionCellView:new{view=window.buttons[index],viewType="UIButtonView" }
        window.collectionPanel:fillWithCell(cells[index],i-1,j-1)
    end
  end
  window:setFocusView(window.buttons[1])
  window:addChildView(window.menuPanel)
  window:addChildView(window.title)
 
  return UICatchLevelWindow:init(window)
end

function UICatchLevelWindow:initialize(args)
  self.levels = args.levels
  --.. do some layout based on levels
end
return UICatchLevelWindow
