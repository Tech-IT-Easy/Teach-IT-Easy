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
-- This class can show a popup window with a message and two 
-- button, one of buttons is Cancel and another is OK
--
-- @Author:Created by Chuck, Nov 16,2015
-----------------------------------------------------------

local UIWindowView = require("toolkit.UIKit.UIWindowView")
local List = require("toolkit.Utils.List")
local UIPanelView = require("toolkit.UIKit.UIPanelView")
local UIButtonView = require("toolkit.UIKit.UIButtonView")
local UIImage = require("toolkit.UIKit.UIImage")
local UILabel = require("toolkit.UIKit.UILabel")
local UILabelView = require("toolkit.UIKit.UILabelView")
local Event = require("toolkit.Event")
require("Config/theme")

-- This is a instance window, which is created for using when required

local UIAlertWindowView = extends(UIWindowView)

function UIAlertWindowView:new(args)
  local window = UIAlertWindowView:super{title=args.title,frame={x=(screen:get_width()-400)/2,y=(screen:get_height()-200)/2-100,w=400,h=200},backgroundColor=COLOR.RED}
  
  -- create member UIView
  local titleLabel = UILabel:new{identity="titleLabel",text=args.title,color=COLOR.RED,size=20,font=UILabel.FONT_GROBOLD}
  window.titleLabelView = UILabelView:new{identity="alterWindowTitleLabel",frame={x=20,y=50,w=200,h=80},label=titleLabel}
  
  local OKLabel = UILabel:new{identity="OKLabel",text=args.OK or "OK",color=COLOR.DARK_GRAY,size=20,font=UILabel.FONT_GROBOLD}
  window.OKButton = UIButtonView:new{identity="OK",enableFocus = true,frame={x=200,y=10,w=80,h=30},borderWidth = 2,label=OKLabel,labelPosition={x=10,y=5}}
  local CancelLabel = UILabel:new{identity="CancelLabel",text=args.Cancel or "Cancel",color=COLOR.DARK_GRAY,size=20,font=UILabel.FONT_GROBOLD}
  window.CancelButton = UIButtonView:new{identity="Cancel",enableFocus = true,frame={x=80,y=10,w=80,h=30},borderWidth = 2,label = CancelLabel,labelPosition={x=10,y=5}}
  
  -- create layout view to organization them
  local titlePanel = UIPanelView:new{frame={x=0, y = 0, w=400, h = 150},backgroundColor=COLOR.DARK_GRAY}
  titlePanel:addChildView(window.titleLabelView)
  window:addChildView(titlePanel)
  
  local buttonPanel = UIPanelView:new{frame={x=0, y = 150, w=400, h = 50},backgroundColor=COLOR.LIGHT_GRAY}
  buttonPanel:addChildView(window.OKButton)
  buttonPanel:addChildView(window.CancelButton)
  window:addChildView(buttonPanel)
  
  -- set properties
  window:setFocusWeight{view=window.OKButton,hWeight=2,vWeight=20}
  window:setFocusWeight{view=window.CancelButton,hWeight=1,vWeight=20}
  window:setFocusView(window.OKButton)
  
  return UIAlertWindowView:init(window)
end
return UIAlertWindowView
