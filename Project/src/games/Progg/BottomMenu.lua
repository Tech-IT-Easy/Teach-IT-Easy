-----------------------------------------------------------
-- This class keeps track of the images and position of the
-- commands in the bottom menu based on how they're
-- organized in the queue.
--
-- @Author:Created by Mikael Ögren, Nov 04,2015
-- @Author:Updated by author,date
-----------------------------------------------------------

local Object = require("toolkit.Object")
local BottomMenu = extends(Object.class())
BottomMenu.ImageArray={}


--Constructor method
function BottomMenu:new()

    return self.class()
end

-- Used to load images
function BottomMenu:load()

end

--Rearranges the positions according to the queue positions
function BottomMenu:rearrage(queue)

end

return BottomMenu
