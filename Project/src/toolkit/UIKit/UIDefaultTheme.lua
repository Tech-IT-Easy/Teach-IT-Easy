-----------------------------------------------------------
-- This UIKit default configuration is listed in this file
--
-- @Author:Created by Chuck, Nov 16,2015
-----------------------------------------------------------

local COLOR = {
  WHITE = {r = 255,   g = 255,   b = 255},
  WHITE_HALF = { g = 228, r = 187, b = 235 },
  BLUE = { g = 0,   r = 0,   b = 255},
  BLUE_DARK = { g = 131, r = 0, b = 143 }
  
}


local DEAULT_THEME_CONFIG = {
  BUTTON_VIEW = {
    BORDER = COLOR.WHITE,
    BACKGROUND = COLOR.WHITE_HALF,
    
    FOCUSED_BORDER =  COLOR.BLUE_DARK,
    FOCUSED_BACKGROUND = COLOR.WHITE,
    
  },
}

return DEAULT_THEME_CONFIG
