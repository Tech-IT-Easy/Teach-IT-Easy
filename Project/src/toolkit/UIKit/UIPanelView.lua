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
-- This class is a collection layout which automatically calculate 
-- the width and height based on given rows and cols. Through filled with
-- different cells, a UICollectionView object can manage different UIViews
--
-- @Author:Created by Chuck, NOV 19,2015
-----------------------------------------------------------
local UIView = require("toolkit.UIKit.UIView")
local UIPanelView = extends(UIView)

function UIPanelView:new(args)
  local o = UIPanelView:super{frame=args.frame,container=args.container}
  --@member background color {r=2,g=2,b=3}
  o.backgroundColor = args.backgroundColor-- or {r=255,g=255,b=255}
  --@member background image.Type of UIImage
  o.backgroundImage = args.backgroundImage
  --@member 
  o.children = {}
  return UIPanelView:init(o)
end

-- @override UIView hook method to update position of child view
function UIPanelView:afterUpdateGlobalFrame()
  for _,view in pairs(self.children) do
    view:updateGlobalFrame()
  end
end

function UIPanelView:emptyChildView()
  self.children = {}
end

function UIPanelView:addChildView(view)
  table.insert(self.children,view)
  view:setContainer(self)
end

function UIPanelView:show()
  -- draw background
  if self.backgroundColor then
    screen:clear(self.backgroundColor,self.globalFrame)
  end
  -- draw background image
  if self.backgroundImage then
    screen:copyfrom(self.backgroundImage.imageData, nil, self.globalFrame, true)
  end
  --
  for _,view in pairs(self.children) do
    view:show()
  end
end

function UIPanelView:getChildViews()
  return self.children
end

return UIPanelView