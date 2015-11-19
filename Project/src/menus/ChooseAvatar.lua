--
-- Created by IntelliJ IDEA.
-- User: Marcus
-- Date: 2015-11-04
-- Time: 09:47
-- To change this template use File | Settings | File Templates.
--

-- Changed to extending empty super-menu
local Super = require('toolkit.MenuSuperClass')
ChooseAvatar = extends(Super)

local Event = require('toolkit.Event')
local CreateProfile = require('menus.CreateProfile')

-------------------------------------
-- Creates a new menu
-- @return self The created menu
-- @author Erik; Marcus
-------------------------------------
function ChooseAvatar:new()

  return self
end

-------------------------------------
-- Update menu when navigated in
-- @author Erik; Marcus
-------------------------------------
function ChooseAvatar:update()
  if self.image1 then
    self:inactive(self.lastpos)
    self:active(self.pos)
  end
end

-------------------------------------
-- Handles the input from the user
-- @param event The key pressed by the user
-- @return String Menu to navigate to or empty string
-- @author Erik; Marcus
-------------------------------------
function ChooseAvatar:handleinput(event)
  collectgarbage()
  self.lastpos = self.pos
  if event.key == Event.KEY_RIGHT and self.pos < #self.myimages then
    self.pos = self.pos + 1
  elseif event.key == Event.KEY_LEFT and self.pos > 1 then
    self.pos = self.pos - 1
  elseif (event.key == Event.KEY_OK) then
    table.insert(usernames, CreateProfile.profilename)
    --self.image4 = self.myimages[self.pos]
    table.insert(images, self.myimages[self.pos])
    self.image1=nil
    self.image2=nil
    self.image3=nil
    self.image4=nil
    self.myimages = nil
    collectgarbage()
    return { "profilesel", " " }
  elseif (event.key == Event.KEY_BACK) then
    CreateProfile.profilename = ""
    return { "create" }
  end
  return {" "}
end

-------------------------------------
-- Loads the menu
-- @param input The username
-- @author Erik; Marcus
-------------------------------------
function ChooseAvatar:loadview(input)
  self.pos = 1
  self.lastpos = 1
  self.username = input
  self.image1 = gfx.loadpng('data/bowser.png')
  self.image1:premultiply()
  self.image2 = gfx.loadpng('data/mario.png')
  self.image2:premultiply()
  self.image3 = gfx.loadpng('data/toad.png')
  self.image3:premultiply()
  self.myimages = { self.image1, self.image2, self.image3 }
  self:renderui()
end

-------------------------------------
-- Prints a button as active
-- @param x1 Position of button
-- @author Erik
-------------------------------------
function ChooseAvatar:active(x1)
  screen:clear({ g = 255, r = 255, b = 255 }, { x = screen:get_width() * 0.08 + (screen:get_width() * 0.22) * (x1 - 1), y = (screen:get_height() * 0.28), w = screen:get_height() * 0.25, h = screen:get_height() * 0.25 })
  screen:copyfrom(self.myimages[x1], nil, { x = (prof_sel_hspacing * x1) + prof_sel_itemwidth * (x1 - 1)*0.82 + screen:get_width() * 0.04, y = prof_sel_itemy - screen:get_height() * 0.035, w = self.image1:get_width() * 0.6, h = self.image1:get_height() * 0.6 }, true)

end

-------------------------------------
-- Prints an inactive button.
-- @param x. Which position to print button at.
-- @author Erik
-------------------------------------
function ChooseAvatar:inactive(x1)
  screen:clear({ g = 228, r = 187, b = 235 }, { x = screen:get_width() * 0.08 + (screen:get_width() * 0.22) * (x1 - 1), y = (screen:get_height() * 0.28), w = screen:get_height() * 0.25, h = screen:get_height() * 0.25 })
  screen:copyfrom(self.myimages[x1], nil, { x = (prof_sel_hspacing * x1) + prof_sel_itemwidth * (x1 - 1)*0.82 + screen:get_width() * 0.04, y = prof_sel_itemy - screen:get_height() * 0.035, w = self.image1:get_width() * 0.6, h = self.image1:get_height() * 0.6 }, true)

end

-------------------------------------
-- Loads initial screen of menu
-- @author Erik; Marcus
-------------------------------------
function ChooseAvatar:renderui()
  create_prof_appname:draw_over_surface(screen, "TEACH IT EASY")
  create_prof_pagename:draw_over_surface(screen, "CHOOSE YOUR AVATAR")

  self:active(1)
  for i = 2, #self.myimages, 1 do
    self:inactive(i)
  end
end


return ChooseAvatar
