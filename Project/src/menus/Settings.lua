-- MainMenu = {} --MenuView:new()
-- Changed to extending empty super-menu
local Super = require('toolkit.MenuSuperClass')
local Settings = extends(Super)

local Event = require('toolkit.Event')
-------------------------------------
-- Creates the Main menu.
-- @return self. The created menu-object.
-- @author Erik
-------------------------------------
function Settings:new()
    local o = Settings:super()
    o.sidebuttonfonts = { settings_buttontext1, settings_buttontext2, settings_buttontext3 }
    return Settings:init(o)
end

-------------------------------------
-- Handles the button-click sent from main.
-- @param key. Represent which button was pressed.
-- @return string. Either " " as standard or a string representing view to be changed to.
-- @author Erik
-------------------------------------
function Settings:handleinput(event)

    collectgarbage()
    self.lastpos = self.pos

    if event.key == Event.KEY_DOWN and self.pos < 2 then
        self.pos = self.pos + 1
    elseif event.key == Event.KEY_UP and self.pos > 0 then
        self.pos = self.pos - 1
    elseif event.key == Event.KEY_OK and self.pos == 0 then
        return { "updatename" }
    elseif event.key == Event.KEY_OK and self.pos == 1 then
        return { "updateavatar", self.usernamestring }
    elseif event.key == Event.KEY_OK and self.pos == 2 then
        return { "delete", self.usernamestring }
    elseif event.key == Event.KEY_BACK then
        return { "main" }
    end

    return { " " }
end

-------------------------------------
-- Updates the view
-- @author Erik
-------------------------------------
function Settings:update()

        self:sidebuttoninactive(self.lastpos)

        self:sidebuttonactive(self.pos)

end


-------------------------------------
-- Loads the view to the screen.
-- @param input:String the username
-- @author Erik
-------------------------------------
function Settings:loadview(input)
    self.pos = 0
    self.lastpos = self.pos
    self.sidebuttons = { "Update Name", "Update Avatar", "Delete Profile" }
    self.usernamestring = input
    --self:printbackground()
    self:renderui()
end

-------------------------------------
-- Prints background on screen.
-- @author Erik
-------------------------------------
function Settings:printbackground()
    self.background = gfx.loadpng("data/background_h720.png")
    screen:copyfrom(self.background, nil, { x = 0, y = 0, w = screen:get_width(), h = screen:get_height() }, true)
    self.background:destroy()
end


-------------------------------------
-- Prints content on screen.
-- @author Erik
-------------------------------------
function Settings:renderui()

    main_menu_appname:draw_over_surface(screen, "TEACH IT EASY")
    main_menu_pagename:draw_over_surface(screen, "MAIN MENU")
    main_menu_username:draw_over_surface(screen, platformContext.profile.name)

    local avatarImageUrl = platformContext.profile.avatar

    local trophyRoomImageActive="data/trophy_active.png"
    local trophyRoomImageInactive="data/trophyinactive.png"
    local SettingsMenuImageActive="data/settings_active.png"
    local SettingsMenuImageInactive="data/settings_inactive.png"
    local InstructionsMenuImageActive="data/instructions_active.png"
    local InstructionsMenuImageInactive="data/instructions_inactive.png"


    self.avatarImage = gfx.loadpng(avatarImageUrl)

    local TrophyRoomImageActiveImage = gfx.loadpng(trophyRoomImageActive)
    local TrophyRoomImageInactiveImage = gfx.loadpng(trophyRoomImageInactive)
    local SettingsMenuImageActiveImage = gfx.loadpng(SettingsMenuImageActive)
    local SettingsMenuImageInactiveImage = gfx.loadpng(SettingsMenuImageInactive)

    local InstructionsActiveImage = gfx.loadpng(InstructionsMenuImageActive)
    local InstructionsInactiveImage = gfx.loadpng(InstructionsMenuImageInactive)
    self.avatarImage:premultiply()
    TrophyRoomImageActiveImage = gfx.loadpng(trophyRoomImageActive)
    TrophyRoomImageActiveImage:premultiply()
    TrophyRoomImageInactiveImage = gfx.loadpng(trophyRoomImageInactive)
    TrophyRoomImageInactiveImage:premultiply()
    SettingsMenuImageActiveImage = gfx.loadpng(SettingsMenuImageActive)
    SettingsMenuImageActiveImage:premultiply()
    SettingsMenuImageInactiveImage = gfx.loadpng(SettingsMenuImageInactive)
    SettingsMenuImageInactiveImage:premultiply()
    InstructionsActiveImage = gfx.loadpng(InstructionsMenuImageActive)
    InstructionsActiveImage:premultiply()
    InstructionsInactiveImage = gfx.loadpng(InstructionsMenuImageInactive)
    InstructionsInactiveImage:premultiply()



    self.inactiveImages = {
        TrophyRoomImageInactiveImage,
        InstructionsInactiveImage,
        SettingsMenuImageInactiveImage
    }

    self.activeImages = {
        TrophyRoomImageActiveImage,
        InstructionsActiveImage,
        SettingsMenuImageActiveImage
    }






    screen:copyfrom(self.avatarImage, nil, { x = screen:get_width() * 0.08, y = screen:get_height() * 0.09, w = screen:get_width() * 0.06, h = screen:get_height() * 0.1 })

    for i = 0, 2, 1 do
        self:sidebuttoninactive(i)
    end

    screen:clear({ g = 0, r = 0, b = 0 }, { x = screen:get_width() * 0.8, y = screen:get_height() * 0.08, w = screen:get_width() * 0.05, h = screen:get_height() * 0.04 })
    screen:clear({ g = 230, r = 230, b = 230 }, { x = screen:get_width() * 0.803, y = screen:get_height() * 0.0845, w = screen:get_width() * 0.0455, h = screen:get_height() * 0.0308 })
    main_menu_backbutton:draw_over_surface(screen, "BACK")
    main_menu_backtext:draw_over_surface(screen, "Change profile")
end

-------------------------------------
-- Prints an active sidebutton.
-- @param x1. Which place to print button.
-- @author Erik
-------------------------------------
function Settings:sidebuttonactive(x1)
    screen:clear({ g = 131, r = 0, b = 143 }, { x = screen:get_width() * 0.5375, y = (screen:get_height() * 0.3) + ((screen:get_height() * 0.2125) * (x1)), w = screen:get_width() * 0.425, h = screen:get_height() * 0.185 })
    screen:clear({ g = 255, r = 255, b = 255 }, { x = screen:get_width() * 0.5425, y = (screen:get_height() * 0.309) + ((screen:get_height() * 0.2125) * (x1)), w = (screen:get_width() * 0.415), h = (screen:get_height() * 0.1685) })
    --screen:copyfrom(self.activeImages[x1], nil, { x = screen:get_width() * 0.5475, y = screen:get_height() * 0.33 + ((screen:get_height() * 0.2125) * (x1 - 1)), w = screen:get_width() * 0.090, h = screen:get_height() * 0.125 })

    self.sidebuttonfonts[x1+1]:draw_over_surface(screen, self.sidebuttons[x1+1])
end

-------------------------------------
-- Prints an inactive sidebutton.
-- @param x1. Which place to print button.
-- @author Erik
-------------------------------------
function Settings:sidebuttoninactive(x1)
    screen:clear({ g = 228, r = 187, b = 235 }, { x = screen:get_width() * 0.5375, y = (screen:get_height() * 0.3) + ((screen:get_height() * 0.2125) * (x1)), w = screen:get_width() * 0.425, h = screen:get_height() * 0.185 })
    --screen:copyfrom(self.inactiveImages[x1], nil, { x = screen:get_width() * 0.5475, y = screen:get_height() *0.33 + ((screen:get_height() * 0.2125) * (x1 - 1)), w = screen:get_width() * 0.090, h = screen:get_height() * 0.125 })

    self.sidebuttonfonts[x1+1]:draw_over_surface(screen, self.sidebuttons[x1+1])
end

return Settings
