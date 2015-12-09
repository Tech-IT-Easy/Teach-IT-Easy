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
local UILayoutView = require("toolkit.UIKit.UILayoutView")
local UICollectionView = extends(UILayoutView)
-- 
function UICollectionView:new(args)
  local o = UICollectionView:super{frame=args.frame,container=args.container}
  --@member space between two cells
  o.space = args.space
  --@member rows
  o.rows = args.rows
  --@member cols
  o.cols = args.cols
  --@member background color default {r=0,g=255,b=255}
  o.backgroundColor = args.backgroundColor-- or {r=0,g=255,b=255}
  --@member cell size calculated automatically
  o.cell = {
    width = (o.frame.w-(o.cols-1)*o.space)/o.cols,
    height = (o.frame.h-(o.rows-1)*o.space)/o.rows
  }
  --@member cells managed by this layout view
  o.cells = {}
  
  return UICollectionView:init(o)
end


function UICollectionView:fillWithCell(cell,row,col)
  if(self.cells[row] == nil) then
    self.cells[row] = {}
  end
  if cell then
    -- set cell container is this collection view
    cellFrame = {
      x = (self.cell.width + self.space) * col,
      y = (self.cell.height + self.space) * row,
      w = self.cell.width,
      h = self.cell.height
    }
    cell:fitToCollection(self,cellFrame)
    -- adjust frame of content view based on col and row
    self.cells[row][col] = cell
  end
end


function UICollectionView:show()
  -- draw background
  if self.backgroundColor then
    screen:clear(self.backgroundColor, self.globalFrame)
  end
  -- draw cells
  for i = 0,self.rows do
    for j = 0,self.cols do
      if(self.cells[i]~=nil and self.cells[i][j]~=nil) then
        self.cells[i][j]:show()
      end
    end
  end
end

function UICollectionView:getChildViews()
  local children = {}
  for i = 0,self.rows do
    for j = 0,self.cols do
      if(self.cells[i]~=nil and self.cells[i][j]~=nil) then
        children[i*self.rows+j] = self.cells[i][j].view
      end
    end
  end
  return children
end

return UICollectionView