-------------------------------------
-- Created by IntelliJ IDEA.
-- User: Marcus
-- Date: 2015-11-04
-------------------------------------

-- Changed to extending empty super-menu
local Super = require('menus.AvatarSelection')
local UpdateAvatar = extends(Super)

local Event = require('toolkit.Event')

-------------------------------------
-- Creates a new menu
-- @return self:ChooseAvatar The created menu
-- @author Erik; Marcus
-------------------------------------
function UpdateAvatar:new()
  local o = UpdateAvatar:super()
  return UpdateAvatar:init(o)
end

-------------------------------------
-- Handles the input from the user
-- @param event The key pressed by the user
-- @return menu:String to navigate to or empty string
-- @author Erik; Marcus; Adam
-------------------------------------
function UpdateAvatar:handleinput(event)
  collectgarbage()

  self.imagestrings = {'data/avatar/cute_robot/DOWN.png',
  'data/avatar/insect_robot/DOWN.png',
  'data/avatar/strong_robot/DOWN.png',
 'data/avatar/fourth_robot/DOWN.png' }

  self.folderimagestrings = {"/cute_robot/", "/insect_robot/", "/strong_robot/", "/fourth_robot/" }


  self.lastpos = self.pos
  if event.key == Event.KEY_RIGHT and self.pos < #self.myimages then
    self.pos = self.pos + 1
  elseif event.key == Event.KEY_LEFT and self.pos > 1 then
    self.pos = self.pos - 1
  elseif (event.key == Event.KEY_OK) then

    platformContext.profile.avatar = self.imagestrings[self.pos]
    platformContext.profile.images = platformContext.profile:getImages(self.folderimagestrings[self.pos])

    --table.insert(profiles, Profile:new(CreateProfile.profilename, self.imagestrings[self.pos], self.folderimagestrings[self.pos]))

    collectgarbage()
    return { "main" }
  elseif (event.key == Event.KEY_BACK) then
    return { "settings" }
  end
  return {" "}
end

return UpdateAvatar
