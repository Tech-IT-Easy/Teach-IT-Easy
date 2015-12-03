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
command_1 = sys.new_freetype({g=255, r=255, b=255, a=255}, command_height*0.4, {x= first_column-command_width*0.15, y=first_row-command_height*0.15}, script_path..'data/GROBOLD.ttf')
command_2 = sys.new_freetype({g=255, r=255, b=255, a=255}, command_height*0.4, {x= first_column+(command_width+row_spacing)-command_width*0.15, y=first_row-command_height*0.15}, script_path..'data/GROBOLD.ttf')
command_3 = sys.new_freetype({g=255, r=255, b=255, a=255}, command_height*0.4, {x= first_column+2*(command_width+row_spacing)-command_width*0.15, y=first_row-command_height*0.15}, script_path..'data/GROBOLD.ttf')
command_4 = sys.new_freetype({g=255, r=255, b=255, a=255}, command_height*0.4, {x= first_column-command_width*0.15, y=first_row-command_height*0.15+(command_height+col_spacing)}, script_path..'data/GROBOLD.ttf')
command_5 = sys.new_freetype({g=255, r=255, b=255, a=255}, command_height*0.4, {x= first_column+(command_width+row_spacing)-command_width*0.15, y=first_row-command_height*0.15+(command_height+col_spacing)}, script_path..'data/GROBOLD.ttf')
command_6 = sys.new_freetype({g=255, r=255, b=255, a=255}, command_height*0.4, {x= first_column+2*(command_width+row_spacing)-command_width*0.15, y=first_row-command_height*0.15+(command_height+col_spacing)}, script_path..'data/GROBOLD.ttf')
command_7 = sys.new_freetype({g=255, r=255, b=255, a=255}, command_height*0.4, {x= first_column-command_width*0.15, y=first_row-command_height*0.15+2*(command_height+col_spacing)}, script_path..'data/GROBOLD.ttf')
command_8 = sys.new_freetype({g=255, r=255, b=255, a=255}, command_height*0.4, {x= first_column+(command_width+row_spacing)-command_width*0.15, y=first_row-command_height*0.15+2*(command_height+col_spacing)}, script_path..'data/GROBOLD.ttf')
command_9 = sys.new_freetype({g=255, r=255, b=255, a=255}, command_height*0.4, {x= first_column+2*(command_width+row_spacing)-command_width*0.15, y=first_row-command_height*0.15+2*(command_height+col_spacing)}, script_path..'data/GROBOLD.ttf')
command_10 = sys.new_freetype({g=255, r=255, b=255, a=255}, command_height*0.4, {x= first_column-command_width*0.15, y=first_row-command_height*0.15+3*(command_height+col_spacing)}, script_path..'data/GROBOLD.ttf')

command_play = sys.new_freetype({g=255, r=255, b=255, a=255}, command_height*0.65, {x= first_column+command_width*0.25, y=first_row+command_height*0.20+3*(command_height+col_spacing)}, script_path..'data/GROBOLD.ttf')

command_0 = sys.new_freetype({g=255, r=255, b=255, a=255}, command_height*0.4, {x= first_column-command_width*0.15, y=first_row-command_height*0.15+3*(command_height+col_spacing)}, script_path..'data/GROBOLD.ttf')
command_play_small = sys.new_freetype({g=255, r=255, b=255, a=255}, command_height*0.45, {x= first_column+command_width*0.20, y=first_row+command_height*0.30+3*(command_height+col_spacing)}, script_path..'data/GROBOLD.ttf')
command_back = sys.new_freetype({g=255, r=255, b=255, a=255}, command_height*0.45, {x= first_column+(1.66)*command_width+row_spacing+command_width*0.20, y=first_row+command_height*0.30+3*(command_height+col_spacing)}, script_path..'data/GROBOLD.ttf')

clearAll = sys.new_freetype({r=255, g=255, b=255, a=255}, command_height*0.7, {x= first_column, y=first_row+0.15*command_width}, script_path..'data/GROBOLD.ttf')

nr_1 = sys.new_freetype({r=34, g=59, b=94, a=255}, command_height*0.8, {x= first_column+0.20*command_height, y=first_row+0.15*command_width}, script_path..'data/GROBOLD.ttf')
nr_2 = sys.new_freetype({r=34, g=59, b=94, a=255}, command_height*0.8, {x= first_column+(command_width+row_spacing)+0.20*command_height, y=first_row+0.15*command_width}, script_path..'data/GROBOLD.ttf')
nr_3 = sys.new_freetype({r=34, g=59, b=94, a=255}, command_height*0.8, {x= first_column+2*(command_width+row_spacing)+0.20*command_height, y=first_row+0.15*command_width}, script_path..'data/GROBOLD.ttf')
nr_4 = sys.new_freetype({r=34, g=59, b=94, a=255}, command_height*0.8, {x= first_column+0.20*command_height, y=first_row+(command_height+col_spacing)+0.15*command_width}, script_path..'data/GROBOLD.ttf')
nr_5 = sys.new_freetype({r=34, g=59, b=94, a=255}, command_height*0.8, {x= first_column+(command_width+row_spacing)+0.20*command_height, y=first_row+(command_height+col_spacing)+0.15*command_width}, script_path..'data/GROBOLD.ttf')
nr_6 = sys.new_freetype({r=34, g=59, b=94, a=255}, command_height*0.8, {x= first_column+2*(command_width+row_spacing)+0.20*command_height, y=first_row+(command_height+col_spacing)+0.15*command_width}, script_path..'data/GROBOLD.ttf')
nr_7 = sys.new_freetype({r=34, g=59, b=94, a=255}, command_height*0.8, {x= first_column+0.20*command_height, y=first_row+2*(command_height+col_spacing)+0.15*command_width}, script_path..'data/GROBOLD.ttf')
nr_8 = sys.new_freetype({r=34, g=59, b=94, a=255}, command_height*0.8, {x= first_column+(command_width+row_spacing)+0.20*command_height, y=first_row+2*(command_height+col_spacing)+0.15*command_width}, script_path..'data/GROBOLD.ttf')
nr_9 = sys.new_freetype({r=34, g=59, b=94, a=255}, command_height*0.8, {x= first_column+2*(command_width+row_spacing)+0.20*command_height, y=first_row+2*(command_height+col_spacing)+0.15*command_width}, script_path..'data/GROBOLD.ttf')
nr_10 = sys.new_freetype({r=34, g=59, b=94, a=255}, command_height*0.8, {x= first_column+0.20*command_height, y=first_row+3*(command_height+col_spacing)+0.15*command_width}, script_path..'data/GROBOLD.ttf')

clear_on_nr9_top = sys.new_freetype({r=34, g=59, b=94, a=255}, command_height*0.25, {x= first_column+2*(command_width+row_spacing)+0.14*command_height, y=first_row+2*(command_height+col_spacing)+0.25*command_width}, script_path..'data/GROBOLD.ttf')
clear_on_nr9_bot = sys.new_freetype({r=34, g=59, b=94, a=255}, command_height*0.25, {x= first_column+2*(command_width+row_spacing)+0.1*command_height, y=first_row+2*(command_height+col_spacing)+0.55*command_width}, script_path..'data/GROBOLD.ttf')
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