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
-- This class is the class for containing a UIView object, such 
-- as a UIButtonView object. Since UICollectionView can only manage
-- UICollectionCellView, which is a medium between UICollectionView and
-- UIView
--
-- @Author:Created by Chuck, NOV 19,2015
-----------------------------------------------------------

local UIView = require("toolkit.UIKit.UIView")
local UICollectionCellView = extends(UIView)

function UICollectionCellView:new(args)
  local o = UICollectionCellView:super{frame=nil,container=args.container}
  --@member view that is managed by this cell
  o.view = args.view
  --@member view type, for future developing
  o.viewType = args.viewType
  return UICollectionCellView:init(o)
end

---- Combine setContainer and setFrame method in UIView 
function UICollectionCellView:fitToCollection(collectionView,frame)
  self.container = collectionView
  self.frame = frame
  self:updateGlobalFrame()  
end

---- @override UIView hook method to update position of child view
function UICollectionCellView:afterUpdateGlobalFrame()
  self.view.container = self
  self.view.frame = {x=0,y=0,w=self.frame.w,h=self.frame.h}
  self.view:updateGlobalFrame()
end

function UICollectionCellView:show()
  self.view:show()
end

return UICollectionCellView