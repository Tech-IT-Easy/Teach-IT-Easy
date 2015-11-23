-------------------------------------
-- @author Adam
-------------------------------------

local Object = require('toolkit.Object')
local Profile = extends(Object)

-------------------------------------
-- Constructor method
-- @param name:String the name of the profile
-- @param avatarNum:integer a representation of the avatar images
-- @return :Progile a new instance of Profile
-- @author Adam
-------------------------------------
function Profile:new(name, avatarNum)
        local o = Profile:super()
        o.name = name
        if(avatarNum == 1) then
                o.avatar = 'data/bowser.png'
                return Profile:init(o)
        end

        if(avatarNum == 2) then
                o.avatar = 'data/mario.png'
                return Profile:init(o)
            end

        if(avatarNum == 3) then
                o.avatar = 'data/toad.png'
                return Profile:init(o)
        end

end


return Profile

