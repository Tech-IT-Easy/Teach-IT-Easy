-----------------------------------------------------------
-- This class keeps track of the images and the position
-- of the marker to properly display the right menu.
--
-- @Author:Created by Mikael Ögren, Nov 04,2015
-- @Author:Updated by author,date
-----------------------------------------------------------


local Object = require("toolkit.Object")
local RightMenu = extends(Object.class())
RightMenu.ImageArray = {}

--Constructor method
function RightMenu:new()

    return self.class()
end

-- Used to load images
function RightMenu:load()

end

--Highlights the image/position the user has selected
function RightMenu:highlight()

end

return RightMenu