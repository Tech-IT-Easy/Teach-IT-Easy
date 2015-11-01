  
  -- varibles for placing
  prof_sel_itemy = screen:get_height() * 0.32
  prof_sel_itemheight = screen:get_height() * 0.35
  prof_sel_itemwidth = screen:get_width() * 0.19
  prof_sel_activeheight = prof_sel_itemheight * 0.96
  prof_sel_activey = prof_sel_itemy + ((prof_sel_itemheight - prof_sel_activeheight) / 2)
  prof_sel_activewidth = prof_sel_itemwidth * 0.96
  prof_sel_hspacing = screen:get_width() * 0.048
  prof_sel_addprofiley = screen:get_height() * 0.84
  prof_sel_addprofileheight = screen:get_height() * 0.16
  prof_sel_activeaddprofileheight = prof_sel_addprofileheight * 0.96
  prof_sel_activeaddprofiley = prof_sel_addprofiley + (prof_sel_addprofileheight - prof_sel_activeaddprofileheight)

  main_menu_appnamebaseline = screen:get_height() * 0.08
  main_menu_pagenamebaseline = screen:get_height() * 0.15
  main_menu_usernamebaseline = screen:get_height() * 0.125

  --General fonts
  main_menu_pagename = sys.new_freetype({g=255, r=255, b=255,a=255}, screen:get_height()*0.07, {x= screen:get_width()*0.375, y=main_menu_pagenamebaseline}, script_path..'data/Chalkduster.ttf')

-- profile selection fonts
  --prof_sel_pagename = sys.new_freetype({ g = 255, r = 255, b = 255, a=255 }, screen:get_height() * 0.07, { x = screen:get_width() * 0.24, y = prof_sel_pagenamebaseline }, script_path .. 'data/Chalkduster.ttf')
  prof_sel_addprofileplus = sys.new_freetype({ g = 131, r = 0, b = 143,a=255 }, screen:get_height() * 0.075, { x = screen:get_width() * 0.35, y = screen:get_height() * 0.883 }, script_path .. 'data/BlackoutMidnight.ttf')
  prof_sel_addprofilename = sys.new_freetype({ g = 131, r = 0, b = 143,a=255 }, screen:get_height() * 0.05, { x = screen:get_width() * 0.38, y = screen:get_height() * 0.88 }, script_path .. 'data/condensed.ttf')
  prof_sel_username1 = sys.new_freetype({ g = 255, r = 255, b = 255,a=255 }, screen:get_height() * 0.05, { x = (prof_sel_hspacing), y = prof_sel_itemy + prof_sel_itemheight * 1.05 }, script_path .. 'data/Chalkduster.ttf')
  prof_sel_username2 = sys.new_freetype({ g = 255, r = 255, b = 255,a=255 }, screen:get_height() * 0.05, { x = (prof_sel_hspacing * 2) + prof_sel_itemwidth, y = prof_sel_itemy + prof_sel_itemheight * 1.05 }, script_path .. 'data/Chalkduster.ttf')
  prof_sel_username3 = sys.new_freetype({ g = 255, r = 255, b = 255,a=255 }, screen:get_height() * 0.05, { x = (prof_sel_hspacing * 3) + prof_sel_itemwidth * (2), y = prof_sel_itemy + prof_sel_itemheight * 1.05 }, script_path .. 'data/Chalkduster.ttf')
  prof_sel_username4 = sys.new_freetype({ g = 255, r = 255, b = 255,a=255 }, screen:get_height() * 0.05, { x = (prof_sel_hspacing * 4) + prof_sel_itemwidth * (3), y = prof_sel_itemy + prof_sel_itemheight * 1.05 }, script_path .. 'data/Chalkduster.ttf')
  prof_sel_usernamefonts = {prof_sel_username1, prof_sel_username2, prof_sel_username3, prof_sel_username4 }

  --main menu fonts
  main_menu_appname = sys.new_freetype({g=255, r=255, b=255,a=255}, screen:get_height()*0.04, {x= screen:get_width()*0.43, y=main_menu_baseline}, script_path..'data/BlackoutMidnight.ttf')
  --main_menu_pagename = sys.new_freetype({g=255, r=255, b=255,a=255}, screen:get_height()*0.07, {x= screen:get_width()*0.375, y=main_menu_pagenamebaseline}, script_path..'data/Chalkduster.ttf')
  main_menu_username = sys.new_freetype({g=255, r=255, b=255,a=255}, screen:get_height()*0.035, {x= screen:get_width()*0.15, y=main_menu_usernamebaseline}, script_path..'data/GROBOLD.ttf')
  main_menu_games = sys.new_freetype({g=131, r=0, b=143,a=255}, screen:get_height()*0.1, {x= screen:get_width()*0.15, y=(screen:get_height()*0.75)}, script_path..'data/condensed.ttf')
  main_menu_backbutton = sys.new_freetype({g=0, r=0, b=0,a=255}, screen:get_height()*0.03, { x=screen:get_width()*0.803 + (screen:get_width()*0.803*0.009), y=screen:get_height()*0.08046}, script_path..'data/condensed.ttf')
  main_menu_backtext = sys.new_freetype({g=255, r=255, b=255,a=255}, screen:get_height()*0.03, { x=screen:get_width()*0.765, y=screen:get_height()*0.125}, script_path..'data/GROBOLD.ttf')
  main_menu_sidebuttontext1 = sys.new_freetype({ g = 131, r = 0, b = 143,a=255}, screen:get_height() * 0.07, { x = screen:get_width()*0.65, y = (screen:get_height()*0.36)}, script_path .. 'data/condensed.ttf')
  main_menu_sidebuttontext2 = sys.new_freetype({ g = 131, r = 0, b = 143,a=255}, screen:get_height() * 0.07, { x = screen:get_width()*0.65, y = (screen:get_height()*0.36) + ((screen:get_height()*0.2125)*1) }, script_path .. 'data/condensed.ttf')
  main_menu_sidebuttontext3 = sys.new_freetype({ g = 131, r = 0, b = 143,a=255}, screen:get_height() * 0.07, { x = screen:get_width()*0.65, y = (screen:get_height()*0.36) + ((screen:get_height()*0.2125)*2) }, script_path .. 'data/condensed.ttf')
