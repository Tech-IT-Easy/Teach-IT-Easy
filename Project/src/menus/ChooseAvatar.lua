--
-- Created by IntelliJ IDEA.
-- User: Marcus
-- Date: 2015-11-04
-- Time: 09:47
-- To change this template use File | Settings | File Templates.
--

ChooseAvatar = {} --MenuView:new()

local Event = require('toolkit.Event')
local CreateProfile = require('menus.CreateProfile')

function ChooseAvatar:new()

  return self
end

function ChooseAvatar:update()

end

function ChooseAvatar:handleinput(event)
  if (event.key == Event.KEY_ONE) then
    table.insert(usernames, CreateProfile.profilename)
    self.image4 = gfx.loadpng('data/bowser.png')
    table.insert(images, self.image4)
    return { "profilesel", " " }
  end
  if (event.key == Event.KEY_TWO) then
    CreateProfile.profilename = ""
    return { "create" }
  end
end

function ChooseAvatar:loadview(input)
  self.pos = 1
  self.lastpos = 1
  self.username = input
  --self:printbackground()
  self:renderui()
end


function ChooseAvatar:renderui()
  create_prof_appname:draw_over_surface(screen, "TEACH IT EASY")
  create_prof_pagename:draw_over_surface(screen, "CHOOSE YOUR AVATAR")
 -- screen:clear({ g = 255, r = 255, b = 255 }, { x = screen:get_width() * 0.1, y = screen:get_height() * 0.25 * 1.2, w = screen:get_width() * 0.8, h = screen:get_height() * 0.3 * 0.6 })
 -- screen:clear({ g = 131, r = 0, b = 143 }, { x = 0, y = screen:get_height() * 0.55, w = screen:get_width(), h = screen:get_height() * 0.45 })

end


return ChooseAvatar
