-----------------------------------------------------------
-- This class keeps track of the images and the position
-- of the marker to properly display the right menu.
--
-- @Author:Created by Mikael Ögren, Nov 04,2015
-- @Author:Updated by Vilhelm Granath,Nov 09, 2015
-----------------------------------------------------------


local Object = require("toolkit.Object")
local RightMenu = extends(Object.class())
--RightMenu.ImageArray = {}

skin = require('games/Progg/progg_skin')

-- images
img1 = gfx.loadpng('data/progg_game_icons/arrow_up.png')
img2 = gfx.loadpng('data/progg_game_icons/turn_left.png')
img3 = gfx.loadpng('data/progg_game_icons/turn_right.png')
img4 = gfx.loadpng('data/progg_game_icons/action.png')
img5 = gfx.loadpng('data/progg_game_icons/if_wall.png')
img6 = gfx.loadpng('data/progg_game_icons/loop.png')
img7 = gfx.loadpng('data/progg_game_icons/P1.png')
img8 = gfx.loadpng('data/progg_game_icons/P2.png')
img9 = gfx.loadpng('data/progg_game_icons/P2.png')
images = { img1, img2, img3, img4, img5, img6, img7, img8, img9 }


-------------------------------------
-- Creates the Right-hand screen in the programming game
-- @return self. The created object.
-- @author Vilhelm
-------------------------------------
function RightMenu:new()
    --Draw right-hand side
    screen:clear({ r = 92, g = 128, b = 149 }, { x = screen:get_width() * 0.75, y = 0, w = screen:get_width() * 0.25, h = screen:get_height()*0.65 })
    self:drawRow(1)
    self:drawRow(2)
    self:drawRow(3)
    self:drawFullRow(4,78,113,215)
    self:addNumbers()
    return self.class()
end

-------------------------------------
-- Draws a row of 3 command-boxes
-- @author Vilhelm
-------------------------------------
function RightMenu:drawRow(row)
     self:drawBox(34,59,94,203,212,214,first_column,first_row+(row-1)*(command_height+col_spacing),command_width,command_height)
     screen:copyfrom(images[(row-1)*3+1], nil, { x = first_column+6, y = first_row+(row-1)*(command_height+col_spacing)+6, w=command_width-12, h = command_height-12 }, true)
     
     self:drawBox(34,59,94,203,212,214,first_column+(command_width+row_spacing),first_row+(row-1)*(command_height+col_spacing),command_width,command_height)
     screen:copyfrom(images[(row-1)*3+2], nil, { x = first_column+(command_width+row_spacing)+6, y = first_row+(row-1)*(command_height+col_spacing)+6, w=command_width-12, h = command_height-12 }, true)
     
     self:drawBox(34,59,94,203,212,214,first_column+2*(command_width+row_spacing),first_row+(row-1)*(command_height+col_spacing),command_width,command_height)
     screen:copyfrom(images[(row-1)*3+3], nil, { x = first_column+2*(command_width+row_spacing)+6, y = first_row+(row-1)*(command_height+col_spacing)+6, w=command_width-12, h = command_height-12 }, true)
end

-------------------------------------
-- Adds numbers to the 9-command layout
-- @author Vilhelm
-------------------------------------
function RightMenu:addNumbers()
     command_1:draw_over_surface(screen, "1")
     command_2:draw_over_surface(screen, "2")
     command_3:draw_over_surface(screen, "3")
     command_4:draw_over_surface(screen, "4")
     command_5:draw_over_surface(screen, "5")
     command_6:draw_over_surface(screen, "6")
     command_7:draw_over_surface(screen, "7")
     command_8:draw_over_surface(screen, "8")
     command_9:draw_over_surface(screen, "9")
     command_play:draw_over_surface(screen, "0  Play!")
end

-------------------------------------
-- Draws a wide box covering a full row
-- Filling color is specified in rgb 
-- @author Vilhelm
-------------------------------------
function RightMenu:drawFullRow(row,r,g,b)
    self:drawBox(34,59,94,r,g,b,first_column,first_row+(row-1)*(command_height+col_spacing),3*command_width+2*row_spacing,command_height)
end

-------------------------------------
-- Draws a box with a border
-- r1,g1,b1 specifies border color
-- r2,g2,b2 specifies filling color
-- @author Vilhelm
-------------------------------------
function RightMenu:drawBox(r1,g1,b1,r2,g2,b2,x,y,w,h)

    if w>h
    then
      f=h
    else
      f=w
    end
    
    b=3
    x2=x+b
    y2=y+b
    h2=h-2*b
    w2=w-2*b
      
    screen:clear({ r = r1, g = g1, b = b1 }, { x = x, y = y, w = w, h = h})
    screen:clear({ r = r2, g = g2, b = b2 }, { x = x2, y = y2, w = w2, h = h2})
     
end

-- Unsure how to be used /Vilhelm
-- Used to load images
function RightMenu:load()

end

--To be added
--Highlights the image/position the user has selected
function RightMenu:highlight(position)

end

-------------------------------------
-- Changes the play-button to a stop-button when 
-- the play-button is pressed
-- @author Vilhelm
-------------------------------------
function RightMenu:play()
    self:drawFullRow(4,245,45,120)
    command_play:draw_over_surface(screen, "0  Stop!")
end

-------------------------------------
-- Changes the stop-button to a play-button when 
-- the stop-button is pressed
-- @author Vilhelm
-------------------------------------
function RightMenu:stop()
    self:drawFullRow(4,78,113,215)
    command_play:draw_over_surface(screen, "0  Play!")
end

return RightMenu