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
function Profile:new(name, image, imagefolder)
        local o = Profile:super()
        o.name = name
        o.avatar = image
          -- @member gameProgress:GameProgress
        o.gameprogress = GameProgress:new(o.name)
        o.images = {}
        o.images = Profile:getImages(imagefolder)

        return Profile:init(o)
end

-------------------------------------
-- Returns avatar images
-- @param imagefolder:String the name of the folder with the images
-- @return :Table with the images mapped to keys UP, DOWN, LEFT, RIGHT
-- @author Trygg
-------------------------------------
function Profile:getImages(imagefolder)
    local folderstring = "data/avatar"..imagefolder
    local UP = folderstring.."UP.png"
    local DOWN = folderstring.."DOWN.png"
    local RIGHT = folderstring.."RIGHT.png"
    local LEFT = folderstring.."LEFT.png"
    local images = {UP = UP, DOWN = DOWN, RIGHT = RIGHT, LEFT = LEFT }
    return images
end


return Profile

