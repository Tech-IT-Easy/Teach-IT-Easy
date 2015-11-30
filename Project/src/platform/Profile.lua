-------------------------------------
-- @author Adam
-------------------------------------

local Object = require('toolkit.Object')
local Profile = extends(Object)

local GameProgress =require('toolkit.GameProgress')

-------------------------------------
-- Constructor method
-- @param name:String the name of the profile
-- @param avatarNum:integer a representation of the avatar images
-- @return :Progile a new instance of Profile
-- @author Adam
-------------------------------------
function Profile:new(name, image)
        local o = Profile:super()
        o.name = name
        o.avatar = image
          -- @member gameProgress:GameProgress
        o.gameprogress = GameProgress:new(o.name)

       -- print(o.gameprogress.progress["games.Progg.ProggGame"].level)
--        print(proggGameLevel)
--        print("AsdADSSADSADDSA")
--        print(PlatformContext.hej)
        return Profile:init(o)
--        if(avatarNum == 1) then
--                o.avatar = 'data/avatar/cute_robot/DOWN.png'
--                return Profile:init(o)
--        end
--
--        if(avatarNum == 2) then
--                o.avatar = 'data/avatar/insect_robot/DOWN.png'
--                return Profile:init(o)
--            end
--
--        if(avatarNum == 3) then
--                o.avatar = 'data/avatar/cute_robot/UP.png'
--                return Profile:init(o)
--        end

end


return Profile

