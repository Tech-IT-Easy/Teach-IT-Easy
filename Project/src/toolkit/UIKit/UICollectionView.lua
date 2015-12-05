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