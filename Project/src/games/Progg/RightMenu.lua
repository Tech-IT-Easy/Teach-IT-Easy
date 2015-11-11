-----------------------------------------------------------
-- This class keeps track of the images and the position
-- of the marker to properly display the right menu.
--
-- @Author:Created by Mikael Ögren, Nov 04,2015
-- @Author:Updated by Vilhelm Granath, Nov 10, 2015
-----------------------------------------------------------

local Object = require("toolkit.Object")
local RightMenu = extends(Object.class())
skin = require('games/Progg/progg_skin')

-- Variale to keep track of a highlighted command
highlight = nill

-- Available commands
commands = {"move","turn-left","turn-right","action","if-wall","loop","P1","P2"}


-------------------------------------
-- Creates the Right-hand screen in the programming game
-- @return self. The created object.
-- @author Vilhelm
-------------------------------------
function RightMenu:new()
    --Draw right-hand side
    screen:clear({ r = 92, g = 128, b = 149 }, { x = screen:get_width() * 0.75, y = 0, w = screen:get_width() * 0.25, h = screen:get_height()*0.65 })
    return self.class()
end

-------------------------------------
-- Loads all images
-- @author Vilhelm
-------------------------------------
function RightMenu:load()
    self.move = gfx.loadpng('data/progg_game_icons/arrow_up.png')
    self.turnLeft = gfx.loadpng('data/progg_game_icons/turn_left.png')
    self.turnRight = gfx.loadpng('data/progg_game_icons/turn_right.png')
    self.action = gfx.loadpng('data/progg_game_icons/action.png')
    self.ifWall = gfx.loadpng('data/progg_game_icons/if_wall.png')
    self.loop = gfx.loadpng('data/progg_game_icons/loop.png')
    self.p1 = gfx.loadpng('data/progg_game_icons/P1.png')
    self.p2 = gfx.loadpng('data/progg_game_icons/P2.png')
    self.images = { ["move"]=self.move, ["turn-left"]=self.turnLeft, ["turn-right"]=self.turnRight, ["action"]=self.action,
        ["if-wall"]=self.ifWall, ["loop"]=self.loop, ["P1"]=self.p1, ["P2"]=self.p2 }

    self.inf_loop = gfx.loadpng('data/progg_game_icons/infinity_loop.png')
end

-------------------------------------
-- Shows all elements in the menu
-- Also tests certain commands
-- @author Vilhelm
-------------------------------------
function RightMenu:show()
    self:drawRow(1)
    self:drawRow(2)
    self:drawRow(3)
    self:drawFullRow(4,78,113,215)
    self:addNumbers()
    self:addImages()
    self:highlight("action")
    self:highlight("P2")
    self:play()
    self:loopLayout()
end

-------------------------------------
-- Assigns commands to numbers
--
-- @params command: name of the action
-- @returns corresponding position in the grid
-- @author Vilhelm
-------------------------------------
function RightMenu:getPosition(command)
    if command == "move" then
        return 1
    elseif command == "turn-left" then
        return 2
    elseif command == "turn-right" then
        return 3
    elseif command == "action" then
        return 4
    elseif command == "if-wall" then
        return 5
    elseif command == "loop" then
        return 6
    elseif command == "P1" then
        return 7
    elseif command == "P2" then
        return 8
    end
end

-------------------------------------
-- Draws a row of 3 command-boxes
-- @author Vilhelm
-------------------------------------
function RightMenu:drawRow(row)
    self:drawBox(34,59,94,203,212,214,first_column,first_row+(row-1)*(command_height+col_spacing),command_width,command_height)
    self:drawBox(34,59,94,203,212,214,first_column+(command_width+row_spacing),first_row+(row-1)*(command_height+col_spacing),command_width,command_height)
    self:drawBox(34,59,94,203,212,214,first_column+2*(command_width+row_spacing),first_row+(row-1)*(command_height+col_spacing),command_width,command_height)
end

-------------------------------------
-- Adds images for all commands
-- to the 9-command layout
-- @author Vilhelm
-------------------------------------
function RightMenu:addImages()
    local i = 1
    while commands[i] do
        print(commands[i])
        self:addImage(commands[i])
        i = i + 1
    end
end

-------------------------------------
-- Adds a images for a specified
-- command in the 9-command layout
-- @author Vilhelm
-------------------------------------
function RightMenu:addImage(command)
    local position=self:getPosition(command)
    local xvalue = first_column+((position-1)%3)*(command_width+row_spacing)+6
    local yvalue = first_row+math.floor((position-1)/3)*(command_height+col_spacing)+6
    screen:copyfrom(self.images[command], nil, { x = xvalue, y = yvalue, w=command_width-12, h = command_height-12 }, true)
end

-------------------------------------
-- Adds all numbers to the 9-command layout
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
-- Adds a single numbers to the 9-command layout
-- @author Vilhelm
-------------------------------------
function RightMenu:addSingleNumber(position)
    if position == 1 then
        command_1:draw_over_surface(screen, "1")
    elseif position == 2 then
        command_2:draw_over_surface(screen, "2")
    elseif position == 3 then
        command_3:draw_over_surface(screen, "3")
    elseif position == 4 then
        command_4:draw_over_surface(screen, "4")
    elseif position == 5 then
        command_5:draw_over_surface(screen, "5")
    elseif position == 6 then
        command_6:draw_over_surface(screen, "6")
    elseif position == 7 then
        command_7:draw_over_surface(screen, "7")
    elseif position == 8 then
        command_8:draw_over_surface(screen, "8")
    elseif position == 9 then
        command_9:draw_over_surface(screen, "9")
    end
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

    --[[if w>h
    then
      local f=h
    else
      local f=w
    end]]

    local b=3
    local x2=x+b
    local y2=y+b
    local h2=h-2*b
    local w2=w-2*b

    screen:clear({ r = r1, g = g1, b = b1 }, { x = x, y = y, w = w, h = h})
    screen:clear({ r = r2, g = g2, b = b2 }, { x = x2, y = y2, w = w2, h = h2})

end

-------------------------------------
-- Highlights the command in the
-- specified position.
--
-- Needs to implement a timed call to remove
-- the highlight again
--
-- @author Vilhelm
-------------------------------------
function RightMenu:highlight(command)
    if highlight ~= nill then
        self:removeHighlight(highlight)
    end

    local position = self:getPosition(command)
    local xvalue = first_column+((position-1)%3)*(command_width+row_spacing)
    local yvalue = first_row+math.floor((position-1)/3)*(command_height+col_spacing)

    self:drawBox(255,192,0,203,212,214,xvalue,yvalue,command_width,command_height)
    screen:copyfrom(self.images[command], nil, { x = xvalue+6, y = yvalue+6, w=command_width-12, h = command_height-12 }, true)
    self:addSingleNumber(position)

    highlight = command

end

-------------------------------------
-- Removes the highlight on the command in the
-- specified position.
-- @author Vilhelm
-------------------------------------
function RightMenu:removeHighlight(command)
    local position = self:getPosition(command)

    local xvalue = first_column+((position-1)%3)*(command_width+row_spacing)
    local yvalue = first_row+math.floor((position-1)/3)*(command_height+col_spacing)

    self:drawBox(34,59,94,203,212,214,xvalue,yvalue,command_width,command_height)
    screen:copyfrom(self.images[command], nil, { x = xvalue+6, y = yvalue+6, w=command_width-12, h = command_height-12 }, true)
    self:addSingleNumber(position)

    highlight = nill

end

-------------------------------------
-- Changes the play-button to a stop-button when
-- the play-button is pressed
-- Also removes any highlight on the commands
--
-- Needs to stop the timer if there is one
--
-- @author Vilhelm
-------------------------------------
function RightMenu:play()
    if highlight ~= nill then
        self:removeHighlight(highlight)
    end

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

-------------------------------------
-- Called to replace buttons for loops
-- @author Vilhelm
-------------------------------------
function RightMenu:loopLayout()
    self:drawRow(1)
    self:drawRow(2)
    self:drawRow(3)
    -- add numbers in boxes
    self:drawFullRow(4,78,113,215)
    self:addNumbers()
    nr_1:draw_over_surface(screen, "1")
    nr_2:draw_over_surface(screen, "2")
    nr_3:draw_over_surface(screen, "3")
    nr_4:draw_over_surface(screen, "4")
    nr_5:draw_over_surface(screen, "5")
    nr_6:draw_over_surface(screen, "6")
    nr_7:draw_over_surface(screen, "7")
    nr_8:draw_over_surface(screen, "8")
    nr_9:draw_over_surface(screen, "9")
    self:drawFullRow(4,78,113,215)
    command_play:draw_over_surface(screen, "0")
    screen:copyfrom(self.inf_loop, nil, { x = first_column+(command_width+row_spacing)+6,
        y = first_row+3*(command_height+col_spacing)+6, w=command_width-12, h = command_height-12 }, true)
end

return RightMenu