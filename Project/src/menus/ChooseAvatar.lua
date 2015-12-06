-------------------------------------
-- Created by IntelliJ IDEA.
-- User: Marcus
-- Date: 2015-11-04
-------------------------------------

-- Changed to extending empty super-menu
local Super = require('menus.AvatarSelection')
local ChooseAvatar = extends(Super)

local Profile = require('platform.Profile')

local Event = require('toolkit.Event')
local CreateProfile = require('menus.CreateProfile')

-------------------------------------
-- Creates a new menu
-- @return self:ChooseAvatar The created menu
-- @author Erik; Marcus
-------------------------------------
function ChooseAvatar:new()
  local o = ChooseAvatar:super()
  return ChooseAvatar:init(o)
end

-------------------------------------
-- Handles the input from the user
-- @param event The key pressed by the user
-- @return menu:String to navigate to or empty string
-- @author Erik; Marcus; Adam
-------------------------------------
function ChooseAvatar:handleinput(event)
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

    self.image4 = self.myimages[self.pos]
    local profile = Profile:new(CreateProfile.profilename, self.imagestrings[self.pos], self.folderimagestrings[self.pos])
    table.insert(profiles, profile)
    PlatformContext.profile = profile

    collectgarbage()
    return { "main" }
  elseif (event.key == Event.KEY_BACK) then
    CreateProfile.profilename = ""
    return { "create" }
  end
  return {" "}
end

return ChooseAvatar
