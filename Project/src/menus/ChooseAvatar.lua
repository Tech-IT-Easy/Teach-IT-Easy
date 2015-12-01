-------------------------------------
-- Created by IntelliJ IDEA.
-- User: Marcus
-- Date: 2015-11-04
-------------------------------------

-- Changed to extending empty super-menu
local Super = require('toolkit.MenuSuperClass')
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
-- @return menu:String to navigate to or empty string
-- @author Erik; Marcus; Adam
-------------------------------------
function ChooseAvatar:handleinput(event)
  collectgarbage()

  self.imagestrings = {'data/avatar/cute_robot/DOWN.png',
  'data/avatar/insect_robot/DOWN.png',
  'data/avatar/cute_robot/UP.png',
 'data/avatar/insect_robot/UP.png' }

  self.folderimagestrings = {"/cute_robot/", "/insect_robot/", "/strong_robot/", "/fourth_robot/" }


  self.lastpos = self.pos
  if event.key == Event.KEY_RIGHT and self.pos < #self.myimages then
    self.pos = self.pos + 1
  elseif event.key == Event.KEY_LEFT and self.pos > 1 then
    self.pos = self.pos - 1
  elseif (event.key == Event.KEY_OK) then

    self.image4 = self.myimages[self.pos]
    table.insert(images, self.image4)
    table.insert(profiles, Profile:new(CreateProfile.profilename, self.imagestrings[self.pos], self.folderimagestrings[self.pos]))

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
-- @param input:String The username
-- @author Erik; Marcus
-------------------------------------
function ChooseAvatar:loadview(input)
  self.pos = 1
  self.lastpos = 1
  self.username = input
  self.image1 = gfx.loadpng('data/avatar/cute_robot/DOWN.png')
  self.image1:premultiply()
  self.image2 = gfx.loadpng('data/avatar/insect_robot/DOWN.png')
  self.image2:premultiply()
  self.image3 = gfx.loadpng('data/avatar/cute_robot/UP.png')
  self.image3:premultiply()
  self.image4 = gfx.loadpng('data/avatar/insect_robot/UP.png')
  self.image4:premultiply()
  self.myimages = { self.image1, self.image2, self.image3, self.image4 }
  self:renderui()
end

-------------------------------------
-- Prints a button as active
-- @param x1 Position of button
-- @author Erik
-------------------------------------
function ChooseAvatar:active(x1)
  screen:clear({ g = 255, r = 255, b = 255 }, { x = screen:get_width() * 0.08 + (screen:get_width() * 0.22) * (x1 - 1), y = 270, w = screen:get_height() * 0.25, h = screen:get_height() * 0.25 })
  screen:copyfrom(self.myimages[x1], nil, { x = (prof_sel_hspacing * x1) + prof_sel_itemwidth * (x1 - 1)*0.90 + screen:get_width() * 0.04, y = 280, w = self.image1:get_width() * 0.45, h = self.image1:get_height() * 0.45 }, true)

end

-------------------------------------
-- Prints an inactive button.
-- @param x1. Which position to print button at.
-- @author Erik
-------------------------------------
function ChooseAvatar:inactive(x1)
  screen:clear({ g = 228, r = 187, b = 235 }, { x = screen:get_width() * 0.08 + (screen:get_width() * 0.22) * (x1 - 1), y = 270, w = screen:get_height() * 0.25, h = screen:get_height() * 0.25 })
  screen:copyfrom(self.myimages[x1], nil, { x = (prof_sel_hspacing * x1) + prof_sel_itemwidth * (x1 - 1)*0.90 + screen:get_width() * 0.04, y = 280, w = self.image1:get_width() * 0.45, h = self.image1:get_height() * 0.45 }, true)

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
