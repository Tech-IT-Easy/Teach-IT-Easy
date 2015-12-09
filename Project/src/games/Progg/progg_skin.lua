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
-- This class keeps track of fixed positions and freetype 
-- objects that are used in the programming game module.
-- 
-- Currently only specifies information relevant for the
-- right hand part of the screen
--
-- @Author:Created by Vilhelm Granath,Nov 10,2015
-- @Author:Updated by 
-----------------------------------------------------------

if ADConfig.isSimulator then
  script_path = ""
else
  script_path = sys.root_path()
end

-- preset positions for the right-hand menu
row_spacing = screen:get_width() * 0.25 * 0.25 * 0.25
col_spacing = screen:get_height() * 0.65 * (1/17)
command_width = screen:get_width() * 0.25 * 0.25
command_height = screen:get_width() * 0.25 * 0.25
first_row = col_spacing
first_column = screen:get_width() * 0.75 + row_spacing

-- preset freetype objects for text in the right-hand menu
command_1 = sys.new_freetype({g=255, r=255, b=255, a=255}, command_height*0.4, {x= first_column-command_width*0.25, y=first_row-command_height*0.20}, script_path..'data/GROBOLD.ttf')
command_2 = sys.new_freetype({g=255, r=255, b=255, a=255}, command_height*0.4, {x= first_column+(command_width+row_spacing)-command_width*0.25, y=first_row-command_height*0.20}, script_path..'data/GROBOLD.ttf')
command_3 = sys.new_freetype({g=255, r=255, b=255, a=255}, command_height*0.4, {x= first_column+2*(command_width+row_spacing)-command_width*0.25, y=first_row-command_height*0.20}, script_path..'data/GROBOLD.ttf')
command_4 = sys.new_freetype({g=255, r=255, b=255, a=255}, command_height*0.4, {x= first_column-command_width*0.25, y=first_row-command_height*0.2+(command_height+col_spacing)}, script_path..'data/GROBOLD.ttf')
command_5 = sys.new_freetype({g=255, r=255, b=255, a=255}, command_height*0.4, {x= first_column+(command_width+row_spacing)-command_width*0.25, y=first_row-command_height*0.20+(command_height+col_spacing)}, script_path..'data/GROBOLD.ttf')
command_6 = sys.new_freetype({g=255, r=255, b=255, a=255}, command_height*0.4, {x= first_column+2*(command_width+row_spacing)-command_width*0.25, y=first_row-command_height*0.20+(command_height+col_spacing)}, script_path..'data/GROBOLD.ttf')
command_7 = sys.new_freetype({g=255, r=255, b=255, a=255}, command_height*0.4, {x= first_column-command_width*0.25, y=first_row-command_height*0.20+2*(command_height+col_spacing)}, script_path..'data/GROBOLD.ttf')
command_8 = sys.new_freetype({g=255, r=255, b=255, a=255}, command_height*0.4, {x= first_column+(command_width+row_spacing)-command_width*0.25, y=first_row-command_height*0.20+2*(command_height+col_spacing)}, script_path..'data/GROBOLD.ttf')
command_9 = sys.new_freetype({g=255, r=255, b=255, a=255}, command_height*0.4, {x= first_column+2*(command_width+row_spacing)-command_width*0.25, y=first_row-command_height*0.20+2*(command_height+col_spacing)}, script_path..'data/GROBOLD.ttf')
command_10 = sys.new_freetype({g=255, r=255, b=255, a=255}, command_height*0.4, {x= first_column-command_width*0.25, y=first_row-command_height*0.20+3*(command_height+col_spacing)}, script_path..'data/GROBOLD.ttf')

command_play = sys.new_freetype({g=255, r=255, b=255, a=255}, command_height*0.65, {x= first_column+command_width*0.25, y=first_row+command_height*0.10+3*(command_height+col_spacing)}, script_path..'data/GROBOLD.ttf')

command_0 = sys.new_freetype({g=255, r=255, b=255, a=255}, command_height*0.4, {x= first_column-command_width*0.15, y=first_row-command_height*0.05+3*(command_height+col_spacing)}, script_path..'data/GROBOLD.ttf')
command_play_small = sys.new_freetype({g=255, r=255, b=255, a=255}, command_height*0.45, {x= first_column+command_width*0.20, y=first_row+command_height*0.30+3*(command_height+col_spacing)}, script_path..'data/GROBOLD.ttf')
command_back = sys.new_freetype({g=255, r=255, b=255, a=255}, command_height*0.45, {x= first_column+(1.66)*command_width+row_spacing+command_width*0.20, y=first_row+command_height*0.30+3*(command_height+col_spacing)}, script_path..'data/GROBOLD.ttf')

move_instruction_line1 = sys.new_freetype({r=255, g=255, b=255, a=255}, command_height*0.36, {x= first_column-command_width*0.12, y=first_row-command_height*0.20 + 0.5*(command_height+col_spacing)}, script_path..'data/GROBOLD.ttf')
move_instruction_line2 = sys.new_freetype({r=255, g=255, b=255, a=255}, command_height*0.36, {x= first_column-command_width*0.12, y=first_row-command_height*0.20 + 1*(command_height+col_spacing)}, script_path..'data/GROBOLD.ttf')
move_instruction_line3 = sys.new_freetype({r=255, g=255, b=255, a=255}, command_height*0.36, {x= first_column-command_width*0.12, y=first_row-command_height*0.20 + 1.5*(command_height+col_spacing)}, script_path..'data/GROBOLD.ttf')
move_instruction_line4 = sys.new_freetype({r=255, g=255, b=255, a=255}, command_height*0.36, {x= first_column-command_width*0.12, y=first_row-command_height*0.20 + 2*(command_height+col_spacing)}, script_path..'data/GROBOLD.ttf')

clearAll = sys.new_freetype({r=255, g=255, b=255, a=255}, command_height*0.7, {x= first_column, y=first_row+0.10*command_width}, script_path..'data/GROBOLD.ttf')

nr_1 = sys.new_freetype({r=34, g=59, b=94, a=255}, command_height*0.8, {x= first_column+0.15*command_height, y=first_row+0.05*command_width}, script_path..'data/GROBOLD.ttf')
nr_2 = sys.new_freetype({r=34, g=59, b=94, a=255}, command_height*0.8, {x= first_column+(command_width+row_spacing)+0.15*command_height, y=first_row+0.05*command_width}, script_path..'data/GROBOLD.ttf')
nr_3 = sys.new_freetype({r=34, g=59, b=94, a=255}, command_height*0.8, {x= first_column+2*(command_width+row_spacing)+0.15*command_height, y=first_row+0.05*command_width}, script_path..'data/GROBOLD.ttf')
nr_4 = sys.new_freetype({r=34, g=59, b=94, a=255}, command_height*0.8, {x= first_column+0.15*command_height, y=first_row+(command_height+col_spacing)+0.05*command_width}, script_path..'data/GROBOLD.ttf')
nr_5 = sys.new_freetype({r=34, g=59, b=94, a=255}, command_height*0.8, {x= first_column+(command_width+row_spacing)+0.15*command_height, y=first_row+(command_height+col_spacing)+0.05*command_width}, script_path..'data/GROBOLD.ttf')
nr_6 = sys.new_freetype({r=34, g=59, b=94, a=255}, command_height*0.8, {x= first_column+2*(command_width+row_spacing)+0.15*command_height, y=first_row+(command_height+col_spacing)+0.05*command_width}, script_path..'data/GROBOLD.ttf')
nr_7 = sys.new_freetype({r=34, g=59, b=94, a=255}, command_height*0.8, {x= first_column+0.15*command_height, y=first_row+2*(command_height+col_spacing)+0.05*command_width}, script_path..'data/GROBOLD.ttf')
nr_8 = sys.new_freetype({r=34, g=59, b=94, a=255}, command_height*0.8, {x= first_column+(command_width+row_spacing)+0.15*command_height, y=first_row+2*(command_height+col_spacing)+0.05*command_width}, script_path..'data/GROBOLD.ttf')
nr_9 = sys.new_freetype({r=34, g=59, b=94, a=255}, command_height*0.8, {x= first_column+2*(command_width+row_spacing)+0.15*command_height, y=first_row+2*(command_height+col_spacing)+0.05*command_width}, script_path..'data/GROBOLD.ttf')
nr_10 = sys.new_freetype({r=34, g=59, b=94, a=255}, command_height*0.8, {x= first_column+0.15*command_height, y=first_row+3*(command_height+col_spacing)+0.05*command_width}, script_path..'data/GROBOLD.ttf')

clear_on_nr9_top = sys.new_freetype({r=34, g=59, b=94, a=255}, command_height*0.25, {x= first_column+2*(command_width+row_spacing)+0.06*command_height, y=first_row+2*(command_height+col_spacing)+0.25*command_width}, script_path..'data/GROBOLD.ttf')
clear_on_nr9_bot = sys.new_freetype({r=34, g=59, b=94, a=255}, command_height*0.25, {x= first_column+2*(command_width+row_spacing)+0.02*command_height, y=first_row+2*(command_height+col_spacing)+0.55*command_width}, script_path..'data/GROBOLD.ttf')
nr_on_loop = sys.new_freetype({r=34, g=59, b=94, a=255}, command_height*0.5, { x = screen:get_width()*(0.90), y = screen:get_height()*0.67}, script_path..'data/GROBOLD.ttf')

-- preset freetype objects for text in the map
win_1 = sys.new_freetype({r=34, g=59, b=94, a=255}, screen:get_width()* 0.04, {x= screen:get_width()*0.08, y=screen:get_height()*0.15}, script_path..'data/GROBOLD.ttf')
win_2 = sys.new_freetype({r=34, g=59, b=94, a=255}, screen:get_width()* 0.04, {x= screen:get_width()*0.08, y=screen:get_height()*0.24}, script_path..'data/GROBOLD.ttf')
win_3 = sys.new_freetype({r=34, g=59, b=94, a=255}, screen:get_width()* 0.04, {x= screen:get_width()*0.08, y=screen:get_height()*0.33}, script_path..'data/GROBOLD.ttf')
win_4 = sys.new_freetype({r=255, g=255, b=255, a=255}, screen:get_width()* 0.04, {x= screen:get_width()*0.08, y=screen:get_height()*0.42}, script_path..'data/GROBOLD.ttf')

exit_1 = sys.new_freetype({r=34, g=59, b=94, a=255}, screen:get_width()* 0.04, {x= screen:get_width()*0.08, y=screen:get_height()*0.15}, script_path..'data/GROBOLD.ttf')
exit_2 = sys.new_freetype({r=34, g=59, b=94, a=255}, screen:get_width()* 0.04, {x= screen:get_width()*0.08, y=screen:get_height()*0.24}, script_path..'data/GROBOLD.ttf')
exit_3 = sys.new_freetype({r=225, g=225, b=255, a=255}, screen:get_width()* 0.04, {x= screen:get_width()*0.08, y=screen:get_height()*0.33}, script_path..'data/GROBOLD.ttf')
exit_4 = sys.new_freetype({r=255, g=255, b=255, a=255}, screen:get_width()* 0.04, {x= screen:get_width()*0.08, y=screen:get_height()*0.42}, script_path..'data/GROBOLD.ttf')

--preset border thickness for highighting in BottomMenu
highlight_border_thickness = screen:get_width() * 0.002344