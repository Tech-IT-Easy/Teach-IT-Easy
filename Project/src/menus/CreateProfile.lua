--CreateProfile = {} --MenuView:new()
-- Changed to extending empty super-menu
local Super = require('menus.InputName')
local CreateProfile = extends(Super)

local Event = require('toolkit.Event')
local ProfileSelection = require('menus.ProfileSelection')

-------------------------------------
-- Creates the Create profile-menu.
-- @return self:CreateProfile The created menu-object.
-- @author Erik/ Marcus
-------------------------------------

-- Must use ".self" otherwise it crashes in simulator when
-- trying to create profile, unknown reason why.. // Adam
function CreateProfile:new()
  local o = CreateProfile:super()
  --Profile name
  self.profilename = ""

  --Keyboard
  self.letters = { 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'DONE', '<--' }

  return self
end

-------------------------------------
-- Handles the button-click sent from main.
-- @param key. Represent which button was pressed.
-- @return string. Either " " as standard or a string representing view to be changed to.
-- @author Erik/ Marcus
-------------------------------------
function CreateProfile:handleinput(event)
  collectgarbage()
  self.lastpos = self.pos
  if event.key == Event.KEY_RIGHT and self.pos < #self.letters then
    self.pos = self.pos + 1
  elseif event.key == Event.KEY_LEFT and self.pos > 1 then
    self.pos = self.pos - 1
  elseif event.key == Event.KEY_DOWN and self.pos <= 18 then
    self.pos = self.pos + 10
  elseif event.key == Event.KEY_UP and self.pos >= 11 then
    self.pos = self.pos - 10
  elseif event.key == Event.KEY_OK and self.pos < 27 then
    if string.len(self.profilename) ~= 10 then
      self.profilename = self.profilename .. self.letters[self.pos] self:updatetext()
    end
  elseif event.key == Event.KEY_OK and self.pos == 27 then
    if string.len(self.profilename) ~= 0 then
      return { "chooseavatar" }
    end
  elseif event.key == Event.KEY_OK and self.pos == 28 then
    self.profilename = string.sub(self.profilename, 1, -2)
    self:updatetext()
  elseif event.key == Event.KEY_BACK then
    return { "profilesel"}
  end
  return { " " }
end

return CreateProfile
