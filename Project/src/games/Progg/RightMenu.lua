-----------------------------------------------------------
-- This class keeps track of the images and the position
-- of the marker to properly display the right menu.
--
-- @Author:Created by Mikael Ögren, Nov 04,2015
-- @Author:Updated by author,date
-----------------------------------------------------------


local Object = require("toolkit.Object")
local RightMenu = extends(Object.class())
RightMenu.ImageArray = {}

row_spacing = screen:get_width() * 0.25 * 0.25 * 0.25
col_spacing = screen:get_height() * 0.65 * (1/17)
command_width = screen:get_width() * 0.25 * 0.25
command_height = screen:get_width() * 0.25 * 0.25
first_row = col_spacing
first_column = screen:get_width() * 0.75 + row_spacing



--Constructor method
function RightMenu:new()
    --Draw right-hand side
    screen:clear({ r = 92, g = 128, b = 149 }, { x = screen:get_width() * 0.75, y = 0, w = screen:get_width() * 0.25, h = screen:get_height()*0.65 })
    self:drawRow(1)
    self:drawRow(2)
    self:drawRow(3)
    self:drawFullRow(4)
    return self.class()
end

function RightMenu:drawRow(row)
     self:drawBox(34,59,94,203,212,214,first_column,first_row+(row-1)*(command_height+col_spacing),command_width,command_height)
     self:drawBox(34,59,94,203,212,214,first_column+(command_width+row_spacing),first_row*(row-1)*(command_height+col_spacing),command_width,command_height)
     self:drawBox(34,59,94,203,212,214,first_column+2*(command_width+row_spacing),first_row*(row-1)*(command_height+col_spacing),command_width,command_height)
end

function RightMenu:drawFullRow(row)
    self:drawBox(34,59,94,78,113,215,first_column,first_row+(row-1)*(command_height+col_spacing),3*command_width+2*row_spacing,command_height)
end

function RightMenu:drawBox(r1,g1,b1,r2,g2,b2,x,y,w,h)

    if w>h
    then
      f=h
    else
      f=w
    end
    
    b=0.07*f
    x2=x+b+1
    y2=y+b+1
    h2=h-2*b
    w2=w-2*b
      
    screen:clear({ r = r1, g = g1, b = b1 }, { x = x, y = y, w = w, h = h})
    screen:clear({ r = r2, g = g2, b = b2 }, { x = x2, y = y2, w = w2, h = h2})
     
end


-- Used to load images
function RightMenu:load()

end

--Highlights the image/position the user has selected
function RightMenu:highlight(position)

end

function RightMenu:play()

end

function RightMenu:stop()

end

return RightMenu