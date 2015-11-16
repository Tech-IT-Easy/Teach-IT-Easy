-----------------------------------------------------------
-- This class keeps track of the images and position of the
-- commands in the bottom menu based on how they're
-- organized in the queue.
--
-- @Author:Created by Mikael Ögren, Nov 04, 2015
-- @Author:Updated by Tobias Lundell, Nov 12, 2015
-- @Author:Updated by Chuck Chu, Nov 12, 2015 fit to new structure
-- @Author:Updated by Mikael Ögren, Nov 16, 2015 Moved draw functions to DrawBottomMenu
-----------------------------------------------------------

local Object = require("toolkit.Object")
local BottomMenu = extends(Object)

local newDrawBottomMenu = require("games.Progg.DrawBottomMenu")

--Constructor method
function BottomMenu:new(maxCommands)
    local o = BottomMenu:super()
    o.availableSlots = maxCommands
    o.queue = {}
    o.drawBottomMenu = newDrawBottomMenu:new()
    o.inputArea = "queue"
    return BottomMenu:init(o)
end

-- Used to load images
function BottomMenu:load()
end

--------------------------------------------
-- Sets the active input area
-- @param inputArea.
-- @ author Tobias Lundell
--------------------------------------------
function BottomMenu:setInputArea(inputArea)
    self.inputArea = inputArea
end
---------------------------------------------
-- Used when BottomMenu is updated
-- @param inputArea. Can be queue, loop, P1 or P2. Determines what area should be drawn.
-- @author Mikael Ögren
--------------------------------------------
function BottomMenu:show()
    --collectgarbage()
    self.drawBottomMenu:background(self.inputArea)
    self.drawBottomMenu:emptySlots(self.availableSlots, self.inputArea)
    self.drawBottomMenu:icons(self.queue)
end

-------------------------------------
-- Set the queue for this class.
-- @param queue. The queue that this class should use.
-- @author Mikael Ögren
-------------------------------------
function BottomMenu:setQueue(queue)
    self.queue = queue
end



return BottomMenu
