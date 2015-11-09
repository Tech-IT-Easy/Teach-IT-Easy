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

-- preset freetype objects for text i the right-hand menu
command_1 = sys.new_freetype({g=255, r=255, b=255, a=255}, command_height*0.4, {x= first_column-command_width*0.10, y=first_row-command_height*0.15}, script_path..'data/GROBOLD.ttf')
command_2 = sys.new_freetype({g=255, r=255, b=255, a=255}, command_height*0.4, {x= first_column+(command_width+row_spacing)-command_width*0.10, y=first_row-command_height*0.15}, script_path..'data/GROBOLD.ttf')
command_3 = sys.new_freetype({g=255, r=255, b=255, a=255}, command_height*0.4, {x= first_column+2*(command_width+row_spacing)-command_width*0.10, y=first_row-command_height*0.15}, script_path..'data/GROBOLD.ttf')
command_4 = sys.new_freetype({g=255, r=255, b=255, a=255}, command_height*0.4, {x= first_column-command_width*0.10, y=first_row-command_height*0.15+(command_height+col_spacing)}, script_path..'data/GROBOLD.ttf')
command_5 = sys.new_freetype({g=255, r=255, b=255, a=255}, command_height*0.4, {x= first_column+(command_width+row_spacing)-command_width*0.10, y=first_row-command_height*0.15+(command_height+col_spacing)}, script_path..'data/GROBOLD.ttf')
command_6 = sys.new_freetype({g=255, r=255, b=255, a=255}, command_height*0.4, {x= first_column+2*(command_width+row_spacing)-command_width*0.10, y=first_row-command_height*0.15+(command_height+col_spacing)}, script_path..'data/GROBOLD.ttf')
command_7 = sys.new_freetype({g=255, r=255, b=255, a=255}, command_height*0.4, {x= first_column-command_width*0.10, y=first_row-command_height*0.15+2*(command_height+col_spacing)}, script_path..'data/GROBOLD.ttf')
command_8 = sys.new_freetype({g=255, r=255, b=255, a=255}, command_height*0.4, {x= first_column+(command_width+row_spacing)-command_width*0.10, y=first_row-command_height*0.15+2*(command_height+col_spacing)}, script_path..'data/GROBOLD.ttf')
command_9 = sys.new_freetype({g=255, r=255, b=255, a=255}, command_height*0.4, {x= first_column+2*(command_width+row_spacing)-command_width*0.10, y=first_row-command_height*0.15+2*(command_height+col_spacing)}, script_path..'data/GROBOLD.ttf')
command_play = sys.new_freetype({g=255, r=255, b=255, a=255}, command_height*0.65, {x= first_column+command_width*0.25, y=first_row+command_height*0.20+3*(command_height+col_spacing)}, script_path..'data/GROBOLD.ttf')