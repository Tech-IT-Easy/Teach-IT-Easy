  
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

-- fonts
  prof_sel_pagename = sys.new_freetype({ g = 255, r = 255, b = 255, a=255 }, screen:get_height() * 0.07, { x = screen:get_width() * 0.24, y = prof_sel_pagenamebaseline }, script_path .. 'data/Chalkduster.ttf')
  prof_sel_addprofileplus = sys.new_freetype({ g = 131, r = 0, b = 143,a=255 }, screen:get_height() * 0.075, { x = screen:get_width() * 0.35, y = screen:get_height() * 0.883 }, script_path .. 'data/BlackoutMidnight.ttf')
  prof_sel_addprofilename = sys.new_freetype({ g = 131, r = 0, b = 143,a=255 }, screen:get_height() * 0.05, { x = screen:get_width() * 0.38, y = screen:get_height() * 0.88 }, script_path .. 'data/condensed.ttf')
  prof_sel_username1 = sys.new_freetype({ g = 255, r = 255, b = 255,a=255 }, screen:get_height() * 0.05, { x = (prof_sel_hspacing), y = prof_sel_itemy + prof_sel_itemheight * 1.05 }, script_path .. 'data/Chalkduster.ttf')
  prof_sel_username2 = sys.new_freetype({ g = 255, r = 255, b = 255,a=255 }, screen:get_height() * 0.05, { x = (prof_sel_hspacing * 2) + prof_sel_itemwidth, y = prof_sel_itemy + prof_sel_itemheight * 1.05 }, script_path .. 'data/Chalkduster.ttf')
  prof_sel_username3 = sys.new_freetype({ g = 255, r = 255, b = 255,a=255 }, screen:get_height() * 0.05, { x = (prof_sel_hspacing * 3) + prof_sel_itemwidth * (2), y = prof_sel_itemy + prof_sel_itemheight * 1.05 }, script_path .. 'data/Chalkduster.ttf')
  prof_sel_username4 = sys.new_freetype({ g = 255, r = 255, b = 255,a=255 }, screen:get_height() * 0.05, { x = (prof_sel_hspacing * 4) + prof_sel_itemwidth * (3), y = prof_sel_itemy + prof_sel_itemheight * 1.05 }, script_path .. 'data/Chalkduster.ttf')
  prof_sel_usernamefonts = {prof_sel_username1, prof_sel_username2, prof_sel_username3, prof_sel_username4}
