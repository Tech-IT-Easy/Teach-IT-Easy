-----------------------------------------------------------
-- This class keeps contains functions to draw elements
-- in the right-hand menu
--
-- @Author:Created by Vilhelm Granath, Nov 16,2015
-----------------------------------------------------------

local Object = require("toolkit.Object")

local DrawRightMenu = extends(Object)
skin = require('games.Progg.progg_skin')


-------------------------------------
-- Creates the draw functions for
-- the right menu
-- @return self. The created object.
-- @author Vilhelm
-------------------------------------
function DrawRightMenu:new(maxCommands)
   local o = DrawRightMenu:super()
   o.maxCommands = maxCommands
   o.commands = {"move","turn-left","turn-right","action","if-wall","loop","P1","P2"}
   return DrawRightMenu:init(o)
end

-------------------------------------
-- Assigns commands to numbers
--
-- @params command: name of the action
-- @returns corresponding position in the grid
-- @author Vilhelm
-------------------------------------
function DrawRightMenu:getPosition(command)
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
-- Gets the file name for a specified
-- command
-- @author Vilhelm
-------------------------------------
function DrawRightMenu:getFileName(action)
    if action == "move" then
        return "data/progg_game_icons/arrow_up.png"
    elseif action == "turn-left" then
        return "data/progg_game_icons/turn_left.png"
    elseif action == "turn-right" then
        return "data/progg_game_icons/turn_right.png"
    elseif action == "action" then
        return "data/progg_game_icons/action.png"
    elseif action == "if-wall" then
        return "data/progg_game_icons/if_wall.png"
    elseif action == "loop" then
        return "data/progg_game_icons/loop.png"
    elseif action == "P1" then
        return "data/progg_game_icons/P1.png"
    elseif action == "P2" then
        return "data/progg_game_icons/P2.png"
    end
end

-------------------------------------
-- Draws a highlighted box for the
-- specified command
-- @author Vilhelm
-------------------------------------
function DrawRightMenu:drawHighlight(command)
    local position = self:getPosition(command)
    local xvalue = first_column+((position-1)%3)*(command_width+row_spacing)
    local yvalue = first_row+math.floor((position-1)/3)*(command_height+col_spacing)

    self:drawBox(255,192,0,203,212,214,xvalue,yvalue,command_width,command_height)

    self.image = gfx.loadpng(self:getFileName(command))
    self.image:premultiply()
    screen:copyfrom(self.image, nil, { x = xvalue+6, y = yvalue+6, w=command_width-12, h = command_height-12 }, true)
    self.image:destroy()

    self:addSingleNumber(position)
end

-------------------------------------
-- Draws a un-highlighted box for the
-- specified command
-- @author Vilhelm
-------------------------------------
function DrawRightMenu:drawRemoveHighlight(command)
    local position = self:getPosition(command)
    local xvalue = first_column+((position-1)%3)*(command_width+row_spacing)
    local yvalue = first_row+math.floor((position-1)/3)*(command_height+col_spacing)

    self:drawBox(34,59,94,203,212,214,xvalue,yvalue,command_width,command_height)

    self.image = gfx.loadpng(self:getFileName(command))
    self.image:premultiply()
    screen:copyfrom(self.image, nil, { x = xvalue+6, y = yvalue+6, w=command_width-12, h = command_height-12 }, true)
    self.image:destroy()

    self:addSingleNumber(position)
    gfx.update()
end

-------------------------------------
-- Draws a row of 3 command-boxes
-- @author Vilhelm
-------------------------------------
function DrawRightMenu:drawRow(row)
    self:clearRow(row)
    self:drawBox(34,59,94,203,212,214,first_column,first_row+(row-1)*(command_height+col_spacing),command_width,command_height)
    self:drawBox(34,59,94,203,212,214,first_column+(command_width+row_spacing),first_row+(row-1)*(command_height+col_spacing),command_width,command_height)
    self:drawBox(34,59,94,203,212,214,first_column+2*(command_width+row_spacing),first_row+(row-1)*(command_height+col_spacing),command_width,command_height)
end

-------------------------------------
-- Draws two boxes covering a row
-- Filling color is specified in rgb
--
-- Button corresponding to Back needs
-- to be added
--
-- @author Vilhelm
-------------------------------------
function DrawRightMenu:drawTwoBoxRow(row,r,g,b)
    self:clearRow(row)
    self:drawBox(34,59,94,r,g,b,first_column,first_row+(row-1)*(command_height+col_spacing),(1.33)*command_width+row_spacing,command_height)
    self:drawBox(34,59,94,r,g,b,first_column+(1.66)*command_width+row_spacing,first_row+(row-1)*(command_height+col_spacing),(1.33)*command_width+row_spacing,command_height)
end

-------------------------------------
-- Draws a wide box covering a full row
-- Filling color is specified in rgb
-- @author Vilhelm
-------------------------------------
function DrawRightMenu:drawFullRow(row,r,g,b)
    self:clearRow(row)
    self:drawBox(34,59,94,r,g,b,first_column,first_row+(row-1)*(command_height+col_spacing),3*command_width+2*row_spacing,command_height)
end

-------------------------------------
-- Adds images for all commands
-- to the 9-command layout
-- @author Vilhelm
-------------------------------------
function DrawRightMenu:addImages()
    local i = 1
    while self.commands[i] do
        if self.maxCommands[self.commands[i]]== nil or self.maxCommands[self.commands[i]] > 0 then
            self:addImage(self.commands[i])
            print(self.commands[i])
        end
        i = i + 1
    end
    clear_on_nr9_top:draw_over_surface(screen, "Clear")  -- Keep as long as key 9 clears the queue
    clear_on_nr9_bot:draw_over_surface(screen, "Queue")  -- Keep as long as key 9 clears the queue
end

-------------------------------------
-- Adds a image for a specified
-- command in the 9-command layout
--
-- @params command: command to add image for
-- @author Vilhelm
-------------------------------------
function DrawRightMenu:addImage(command)
    self.image = gfx.loadpng(self:getFileName(command))
    self.image:premultiply()
    local position= self:getPosition(command)
    local xvalue = first_column+((position-1)%3)*(command_width+row_spacing)+6
    local yvalue = first_row+math.floor((position-1)/3)*(command_height+col_spacing)+6
    screen:copyfrom(self.image, nil, { x = xvalue, y = yvalue, w=command_width-12, h = command_height-12 }, true)
    self.image:destroy()
end

-------------------------------------
-- Adds all numbers to the 9-command layout
-- @author Vilhelm
-------------------------------------
function DrawRightMenu:addNumbers()
    command_1:draw_over_surface(screen, "1")
    command_2:draw_over_surface(screen, "2")
    command_3:draw_over_surface(screen, "3")
    command_4:draw_over_surface(screen, "4")
    command_5:draw_over_surface(screen, "5")
    command_6:draw_over_surface(screen, "6")
    command_7:draw_over_surface(screen, "7")
    command_8:draw_over_surface(screen, "8")
    command_9:draw_over_surface(screen, "9")
end

-------------------------------------
-- Adds a single numbers to the 9-command layout
--
-- @params position: position to add number to
-- @author Vilhelm
-------------------------------------
function DrawRightMenu:addSingleNumber(position)
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
-- Adds the play text to a single wide
-- button in the 9-command layout
-- @author Vilhelm
-------------------------------------
function DrawRightMenu:addPlay()
    self:drawFullRow(4,78,113,215)
    command_play:draw_over_surface(screen, "0  Play!")
end

-------------------------------------
-- Adds the stop text to a single wide
-- button in the 9-command layout
-- @author Vilhelm
-------------------------------------
function DrawRightMenu:addStop()
    self:drawFullRow(4,245,45,120)
    command_play:draw_over_surface(screen, "0  Stop!")
    --gfx.update()
end

-------------------------------------
-- Adds the play & back text to the
-- two-buttons row in the 9-command
-- layout
-- @author Vilhelm
-------------------------------------
function DrawRightMenu:addBack()
    self:drawFullRow(4,78,113,215)
    command_play:draw_over_surface(screen, "0  Back")
end

-------------------------------------
-- Adds if false text to the
-- two-buttons row in the 9-command
-- layout.
-- @author Tobias Lundell
-------------------------------------
function DrawRightMenu:addIfFalse(preventFalse)
    self:clearRow(4)
    if (preventFalse == true) then
        print ("preventFalse")
        self:drawFullRow(4,135,156,161)
    else
        print ("don't preventFalse")
        self:drawFullRow(4,78,113,215)
    end
    command_play:draw_over_surface(screen, "0 If false")

end

function DrawRightMenu:addConfirm()
    self:clearRow(1)
    self:clearRow(2)
    self:clearRow(3)
    self:clearRow(4)
    self:drawFullRow(2,78,113,215)
    self:drawFullRow(3,78,113,215)
    command_4:draw_over_surface(screen, "1")
    command_7:draw_over_surface(screen, "2")
    clearAll:draw_over_surface(screen, "Clear All?")
    nr_4:draw_over_surface(screen, "Confirm")
    nr_7:draw_over_surface(screen, "Cancel")
end

-------------------------------------
-- Adds the option buttons when
-- selecting an action
-- @author Vilhelm
-------------------------------------
function DrawRightMenu:addOptions(can_enter)
    self:clearRow(1)
    self:clearRow(2)
    self:clearRow(3)
    self:clearRow(4)
    self:drawFullRow(1,78,113,215)
    self:drawFullRow(2,78,113,215)
    command_1:draw_over_surface(screen, "1")
    command_4:draw_over_surface(screen, "2")
    nr_1:draw_over_surface(screen, "Move")
    nr_4:draw_over_surface(screen, "Delete")

    if (can_enter == true) then
        self:drawFullRow(3,78,113,215)
        command_7:draw_over_surface(screen, "3")
        nr_7:draw_over_surface(screen, "Enter")
    end

    self:drawFullRow(4,78,113,215)
    command_10:draw_over_surface(screen, "4")
    nr_10:draw_over_surface(screen, "Back")
end

---------------------------------------
-- Draws an instruction message in the right
-- menu for moving an action.
-- @author Tobias Lundell
---------------------------------------
function DrawRightMenu:addMoveInstructions()
    self:clearRow(1)
    self:clearRow(2)
    self:clearRow(3)
    self:clearRow(4)
    move_instruction_line1:draw_over_surface(screen, "Go to the position")
    move_instruction_line2:draw_over_surface(screen, "where you want to")
    move_instruction_line3:draw_over_surface(screen, "move the action and")
    move_instruction_line4:draw_over_surface(screen, "press OK to confirm")
    self:drawFullRow(4,78,113,215)
    command_10:draw_over_surface(screen, "4")
    nr_10:draw_over_surface(screen, "Back")
end
-------------------------------------
-- Adds numbers to the loop layout
-- @author Vilhelm
-------------------------------------
function DrawRightMenu:addLoopOptions()
    nr_1:draw_over_surface(screen, "1")
    nr_2:draw_over_surface(screen, "2")
    nr_3:draw_over_surface(screen, "3")
    nr_4:draw_over_surface(screen, "4")
    nr_5:draw_over_surface(screen, "5")
    nr_6:draw_over_surface(screen, "6")
    nr_7:draw_over_surface(screen, "7")
    nr_8:draw_over_surface(screen, "8")
    nr_9:draw_over_surface(screen, "9")
    command_play:draw_over_surface(screen, "0")

    self.image = gfx.loadpng('data/progg_game_icons/infinity_loop.png')
    screen:copyfrom(self.image, nil, { x = first_column+(command_width+row_spacing)+6,
        y = first_row+3*(command_height+col_spacing)+6, w=command_width-12, h = command_height-12 }, true)
    self.image:destroy()
end

-------------------------------------
-- Greys out unusable commands
-- @author Vilhelm
-------------------------------------
function DrawRightMenu:preventRecursion(allow_if)
--Only on the loops now. Recursion enabled on procedures
    --self:drawBox(34,59,94,135,156,161,first_column,first_row+(3-1)*(command_height+col_spacing),command_width,command_height)

  --self:drawBox(34,59,94,135,156,161,first_column+(command_width+row_spacing),first_row+(3-1)*(command_height+col_spacing),command_width,command_height)
   if self.maxCommands["loop"]  ~= nil and self.maxCommands["loop"] > 0 then
    self:drawBox(34,59,94,135,156,161,first_column+2*(command_width+row_spacing),first_row+(2-1)*(command_height+col_spacing),command_width,command_height)
    self:addImage("loop")
   end
    command_6:draw_over_surface(screen, "6")
    --command_7:draw_over_surface(screen, "7")
    --command_8:draw_over_surface(screen, "8")
    if allow_if == false then
        self:drawBox(34,59,94,135,156,161,first_column+(command_width+row_spacing),first_row+(2-1)*(command_height+col_spacing),command_width,command_height)
        self:addImage("if-wall")
        command_5:draw_over_surface(screen, "5")
    end
end

function DrawRightMenu:preventIfFalse()
    self:drawFullRow(4,135,156,161)
    command_play:draw_over_surface(screen, "0 If false")
end


-------------------------------------
-- Clears a row
-- @param: row to be cleared
-- @author Vilhelm
-------------------------------------
function DrawRightMenu:clearRow(row)
    self:drawBox(92,128,149,92,128,149,first_column-command_width*0.20,first_row+(row-1)*(command_height+col_spacing)-command_height*0.20,3*command_width+2*row_spacing+command_width*0.40,command_height*1.4)
end

-------------------------------------
-- Draws a box with a border
-- r1,g1,b1 specifies border color
-- r2,g2,b2 specifies filling color
-- @author Vilhelm
-------------------------------------
function DrawRightMenu:drawBox(r1,g1,b1,r2,g2,b2,x,y,w,h)

    local b=3
    local x2=x+b
    local y2=y+b
    local h2=h-2*b
    local w2=w-2*b

    screen:clear({ r = r1, g = g1, b = b1 }, { x = x, y = y, w = w, h = h})
    screen:clear({ r = r2, g = g2, b = b2 }, { x = x2, y = y2, w = w2, h = h2})

end

return DrawRightMenu