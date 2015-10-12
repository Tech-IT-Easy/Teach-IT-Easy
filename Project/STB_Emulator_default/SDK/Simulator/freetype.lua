## freetype module ##
local class = require( "SDK.Lib.classy" )
local freetype = class( "freetype")

---Draw over Surface
-- *************** Zenterio API Doc ********************************
-- Draw a <text> on the <surface>. <freetype> is a Freetype object with set font
-- parameters before.  
-- *****************************************************************
-- @param freetype
-- @param surface
-- @param text
function freetype.draw_over_surface(freetype, surface, text)  
  --Not currently implemented
end

return freetype
