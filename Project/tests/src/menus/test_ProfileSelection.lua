--[[TEACH IT EASY, an educational games platform
    Copyright (C) 2015  Linköping University

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.


    MIT LICENSE:
    Copyright (c) 2015 Zenterio AB

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:



    The above copyright notice and this permission notice shall be included in
    all copies or substantial portions of the Software.


    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
    THE SOFTWARE.


    ]]
--
-- Created by IntelliJ IDEA.
-- User: johannaskolling
-- Date: 15-10-12
-- Time: 12:07
-- To change this template use File | Settings | File Templates.
--


lunit = require "lunit"
module("src_menus_ProfileSelection", package.seeall, lunit.testcase)
--local Object = require'toolkit.Object'
local event = require "toolkit.Event"


-- System under test
local SUT = 'menus.ProfileSelection'
local function create_mock(class_to_mock)
    -- unload the package if loaded to dissmiss previous mocks
    package.loaded[class_to_mock] = nil
    package.preload[class_to_mock] = nil
    -- import lemock
    local lemock = require 'lemock'
    -- initiate mock controller
    local mc = lemock.controller()
    return mc
end

local function verify_mock(mc)
    local status, err = pcall(function()
        -- Verify that the mocks has been called as stated.
        mc:verify()
    end)
    if err then -- if error fail the test.
    fail(err)
    end
end


function setup()
end

function teardown()
    package.loaded['menus.ProfileSelection'] = nil
    package.preload['menus.ProfileSelection'] = nil
end

-------------------------------------
-- Tests if loadview() calls the function for drawing on screen
-- @system_under_test : ProfileSelection:new(), ProfileSelection:loadview()
-- @author name: Johanna
-------------------------------------
function test_loadview()
    local mc = create_mock(SUT)

    -- Mock renderui and printbackground
    local renderui = mc:mock()
    --local printbackground = mc:mock()

    local ps = require(SUT)

    package.loaded[SUT].renderui = renderui
    --package.loaded[SUT].printbackground = printbackground

    renderui(mc.ANYARGS); mc:returns(nil):times(1)
    --printbackground(mc.ANYARGS) ;mc :returns(nil) :times(1)

    mc:replay()

    local ps2 = require("platform.Profile")
    _G.profiles = {}
    table.insert(profiles, ps2:new("Knatte", 'data/avatar/cute_robot/DOWN.png', "/cute_robot/"))
    table.insert(profiles, ps2:new("Fnatte", 'data/avatar/insect_robot/DOWN.png', "/insect_robot/"))
    table.insert(profiles, ps2:new("Tjatte", 'data/avatar/strong_robot/DOWN.png', "/strong_robot/"))


    local b = ps:new()
    b:loadview()

    verify_mock(mc)
    _G.profiles = nil
end

-------------------------------------
-- Tests if possible tp go right from pos 1
-- @system_under_test : ProfileSelection:new(), ProfileSelection:handleinput(event)
-- @author name: Johanna
-------------------------------------
function test_handleinput_right()
    local mc = create_mock(SUT)
    -- Mock inactive and active
    -- Create mock objects for each function to mock
    local inactive = mc:mock()
    local active = mc:mock()

    -- In this case we want to mock 2 member functions so then we import the SUT (System under test)
    local ps = require(SUT)

    -- override the original functions with mocks
    package.loaded[SUT].inactive = inactive
    package.loaded[SUT].active = active

    -- Tell for which arguments it should work, what it should return and how many times it should be called.
    inactive(mc.ANYARGS); mc:returns(nil):anytimes()
    active(mc.ANYARGS); mc:returns(nil):anytimes()

    -- Start the testing
    mc:replay()
    local ps2 = require("platform.Profile")
    _G.profiles = {}
    table.insert(profiles, ps2:new("Knatte", 'data/avatar/cute_robot/DOWN.png', "/cute_robot/"))
    table.insert(profiles, ps2:new("Fnatte", 'data/avatar/insect_robot/DOWN.png', "/insect_robot/"))
    table.insert(profiles, ps2:new("Tjatte", 'data/avatar/strong_robot/DOWN.png', "/strong_robot/"))

    local a = ps:new()
    a.usernames = { "a", "b", "c" }
    a.pos = 1
    event.key = event.KEY_RIGHT
    a:handleinput(event)
    assert_equal(2, a.pos, "should move one step right, didn't")

    verify_mock(mc)

    _G.profiles = nil
end

-------------------------------------
-- Tests if no movement to the right when at far right
-- @system_under_test : ProfileSelection:new(), ProfileSelection:handleinput(event)
-- @author name: Johanna
-------------------------------------
function test_handleinput_right_two()
    local mc = create_mock(SUT)
    local inactive = mc:mock()
    local active = mc:mock()
    local ps = require(SUT)
    package.loaded[SUT].inactive = inactive
    package.loaded[SUT].active = active
    inactive(mc.ANYARGS); mc:returns(nil):anytimes()
    active(mc.ANYARGS); mc:returns(nil):anytimes()
    mc:replay()
    local ps2 = require("platform.Profile")
    _G.profiles = {}
    table.insert(profiles, ps2:new("Knatte", 'data/avatar/cute_robot/DOWN.png', "/cute_robot/"))
    table.insert(profiles, ps2:new("Fnatte", 'data/avatar/insect_robot/DOWN.png', "/insect_robot/"))
    table.insert(profiles, ps2:new("Tjatte", 'data/avatar/strong_robot/DOWN.png', "/strong_robot/"))

    local a = ps:new()
    a.usernames = { "a", "b", "c" }
    a.pos = 3
    event.key = event.KEY_RIGHT
    a:handleinput(event)
    assert_equal(3, a.pos, "moved right even though it was positioned far right")

    verify_mock(mc)
    _G.profiles = nil
end

-------------------------------------
-- Tests if no movement to the left when at far left pos
-- @system_under_test : ProfileSelection:new(), ProfileSelection:handleinput(event)
-- @author name: Johanna
-------------------------------------
function test_handleinput_left()
    local mc = create_mock(SUT)
    local inactive = mc:mock()
    local active = mc:mock()
    local ps = require(SUT)
    package.loaded[SUT].inactive = inactive
    package.loaded[SUT].active = active
    inactive(mc.ANYARGS); mc:returns(nil):anytimes()
    active(mc.ANYARGS); mc:returns(nil):anytimes()
    mc:replay()
    local ps2 = require("platform.Profile")
    _G.profiles = {}
    table.insert(profiles, ps2:new("Knatte", 'data/avatar/cute_robot/DOWN.png', "/cute_robot/"))
    table.insert(profiles, ps2:new("Fnatte", 'data/avatar/insect_robot/DOWN.png', "/insect_robot/"))
    table.insert(profiles, ps2:new("Tjatte", 'data/avatar/strong_robot/DOWN.png', "/strong_robot/"))

    local a = ps:new()
    a.usernames = { "a", "b", "c" }
    a.pos = 1
    event.key = event.KEY_LEFT
    a:handleinput(event)
    assert_equal(1, a.pos, "tried to move left even though is was posistioned far left")
    verify_mock(mc)
    _G.profiles = nil
end

-------------------------------------
-- Tests if no movement one step left
-- @system_under_test : ProfileSelection:new(), ProfileSelection:handleinput(event)
-- @author name: Johanna
-------------------------------------
function test_handleinput_left_two()
    local mc = create_mock(SUT)
    local inactive = mc:mock()
    local active = mc:mock()
    local ps = require(SUT)
    package.loaded[SUT].inactive = inactive
    package.loaded[SUT].active = active
    inactive(mc.ANYARGS); mc:returns(nil):anytimes()
    active(mc.ANYARGS); mc:returns(nil):anytimes()
    mc:replay()
    local ps2 = require("platform.Profile")
    _G.profiles = {}
    table.insert(profiles, ps2:new("Knatte", 'data/avatar/cute_robot/DOWN.png', "/cute_robot/"))
    table.insert(profiles, ps2:new("Fnatte", 'data/avatar/insect_robot/DOWN.png', "/insect_robot/"))
    table.insert(profiles, ps2:new("Tjatte", 'data/avatar/strong_robot/DOWN.png', "/strong_robot/"))

    local a = ps:new()
    a.usernames = { "a", "b", "c" }
    a.pos = 3
    event.key = event.KEY_LEFT
    a:handleinput(event)
    assert_equal(2, a.pos, "did not move left, should have.")
    verify_mock(mc)
    _G.profiles = nil
end

-------------------------------------
-- Tests if no movement from bottom when right is pressed
-- @system_under_test : ProfileSelection:new(), ProfileSelection:handleinput(event)
-- @author name: Johanna
-------------------------------------
function test_handleinput_bottom_right()
    local mc = create_mock(SUT)
    local inactive = mc:mock()
    local active = mc:mock()
    local ps = require(SUT)
    package.loaded[SUT].inactive = inactive
    package.loaded[SUT].active = active
    inactive(mc.ANYARGS); mc:returns(nil):anytimes()
    active(mc.ANYARGS); mc:returns(nil):anytimes()
    mc:replay()
    local ps2 = require("platform.Profile")
    _G.profiles = {}
    table.insert(profiles, ps2:new("Knatte", 'data/avatar/cute_robot/DOWN.png', "/cute_robot/"))
    table.insert(profiles, ps2:new("Fnatte", 'data/avatar/insect_robot/DOWN.png', "/insect_robot/"))
    table.insert(profiles, ps2:new("Tjatte", 'data/avatar/strong_robot/DOWN.png', "/strong_robot/"))

    local a = ps:new()
    a.usernames = { "a", "b", "c" }
    a.pos = 5
    event.key = event.KEY_RIGHT
    a:handleinput(event)
    assert_equal(5, a.pos, "moved from bottom when right was pressed")
    verify_mock(mc)

    _G.profiles = nil
end

-------------------------------------
-- Tests if no movement from bottom when left is pressed
-- @system_under_test : ProfileSelection:new(), ProfileSelection:handleinput(event)
-- @author name: Johanna
-------------------------------------
function test_handleinput_bottom_left()
    local mc = create_mock(SUT)
    local inactive = mc:mock()
    local active = mc:mock()
    local ps = require(SUT)
    package.loaded[SUT].inactive = inactive
    package.loaded[SUT].active = active
    inactive(mc.ANYARGS); mc:returns(nil):anytimes()
    active(mc.ANYARGS); mc:returns(nil):anytimes()
    mc:replay()
    local ps2 = require("platform.Profile")
    _G.profiles = {}
    table.insert(profiles, ps2:new("Knatte", 'data/avatar/cute_robot/DOWN.png', "/cute_robot/"))
    table.insert(profiles, ps2:new("Fnatte", 'data/avatar/insect_robot/DOWN.png', "/insect_robot/"))
    table.insert(profiles, ps2:new("Tjatte", 'data/avatar/strong_robot/DOWN.png', "/strong_robot/"))

    local a = ps:new()
    a.usernames = { "a", "b", "c" }
    a.pos = 5
    event.key = event.KEY_LEFT
    a:handleinput(event)
    assert_equal(5, a.pos, "moved from bottom when left was pressed")
    verify_mock(mc)

    _G.profiles = nil
end

-------------------------------------
-- Tests if no movement from bottom when down is pressed
-- @system_under_test : ProfileSelection:new(), ProfileSelection:handleinput(event)
-- @author name: Johanna
-------------------------------------
function test_handleinput_bottom_down()
    local mc = create_mock(SUT)
    local inactive = mc:mock()
    local active = mc:mock()
    local ps = require(SUT)
    package.loaded[SUT].inactive = inactive
    package.loaded[SUT].active = active
    inactive(mc.ANYARGS); mc:returns(nil):anytimes()
    active(mc.ANYARGS); mc:returns(nil):anytimes()
    mc:replay()

    local ps2 = require("platform.Profile")
    _G.profiles = {}
    table.insert(profiles, ps2:new("Knatte", 'data/avatar/cute_robot/DOWN.png', "/cute_robot/"))
    table.insert(profiles, ps2:new("Fnatte", 'data/avatar/insect_robot/DOWN.png', "/insect_robot/"))
    table.insert(profiles, ps2:new("Tjatte", 'data/avatar/strong_robot/DOWN.png', "/strong_robot/"))


    local a = ps:new()
    a.usernames = { "a", "b", "c" }
    a.pos = 5
    event.key = event.KEY_DOWN
    a:handleinput(event)
    assert_equal(5, a.pos, "moved from bottom when down was pressed")
    verify_mock(mc)
    _G.profiles = nil
end

-------------------------------------
-- Tests if movement from bottom when left up pressed
-- @system_under_test : ProfileSelection:new(), ProfileSelection:handleinput(event)
-- @author name: Johanna
-------------------------------------
function test_handleinput_bottom_up()
    local mc = create_mock(SUT)
    local inactive = mc:mock()
    local active = mc:mock()
    local ps = require(SUT)
    package.loaded[SUT].inactive = inactive
    package.loaded[SUT].active = active
    inactive(mc.ANYARGS); mc:returns(nil):anytimes()
    active(mc.ANYARGS); mc:returns(nil):anytimes()
    mc:replay()
    local ps2 = require("platform.Profile")
    _G.profiles = {}
    table.insert(profiles, ps2:new("Knatte", 'data/avatar/cute_robot/DOWN.png', "/cute_robot/"))
    table.insert(profiles, ps2:new("Fnatte", 'data/avatar/insect_robot/DOWN.png', "/insect_robot/"))
    table.insert(profiles, ps2:new("Tjatte", 'data/avatar/strong_robot/DOWN.png', "/strong_robot/"))

    local a = ps:new()
    a.usernames = { "a", "b", "c" }
    a.pos = 5
    event.key = event.KEY_UP
    a:handleinput(event)
    assert_equal(1, a.pos, "did not move up from bottom when up was pressed")
    verify_mock(mc)
    _G.profiles = nil
end

-------------------------------------
-- Tests that nothing happens when up is pressed and pos is among the upper ones.
-- @system_under_test : ProfileSelection:new(), ProfileSelection:handleinput(event)
-- @author name: Johanna
-------------------------------------
function test_handleinput_up_up()
    local mc = create_mock(SUT)
    local inactive = mc:mock()
    local active = mc:mock()
    local ps = require(SUT)
    package.loaded[SUT].inactive = inactive
    package.loaded[SUT].active = active
    inactive(mc.ANYARGS); mc:returns(nil):anytimes()
    active(mc.ANYARGS); mc:returns(nil):anytimes()
    mc:replay()
    local ps2 = require("platform.Profile")
    _G.profiles = {}
    table.insert(profiles, ps2:new("Knatte", 'data/avatar/cute_robot/DOWN.png', "/cute_robot/"))
    table.insert(profiles, ps2:new("Fnatte", 'data/avatar/insect_robot/DOWN.png', "/insect_robot/"))
    table.insert(profiles, ps2:new("Tjatte", 'data/avatar/strong_robot/DOWN.png', "/strong_robot/"))

    local a = ps:new()
    a.usernames = { "a", "b", "c" }

    a.pos = 1
    event.key = event.KEY_UP
    a:handleinput(event)
    assert_equal(1, a.pos, "tried to move from pos 1 when it was already up")
    a.pos = 2
    a:handleinput(event)
    assert_equal(2, a.pos, "tried to move from pos 2 when it was already up")
    a.pos = 3
    a:handleinput(event)
    assert_equal(3, a.pos, "tried to move from pos 3 when it was already up")
    verify_mock(mc)

    _G.profiles = nil
end

-------------------------------------
-- Tests movement down to pos 5 from all upper pos when down is pressed a.pos = 1
-- @system_under_test : ProfileSelection:new(), ProfileSelection:handleinput(event)
-- @author name: Johanna
-------------------------------------
function test_handleinput_up_down()
    local mc = create_mock(SUT)
    local inactive = mc:mock()
    local active = mc:mock()
    local ps = require(SUT)
    package.loaded[SUT].inactive = inactive
    package.loaded[SUT].active = active
    inactive(mc.ANYARGS); mc:returns(nil):anytimes()
    active(mc.ANYARGS); mc:returns(nil):anytimes()
    mc:replay()
    local ps2 = require("platform.Profile")
    _G.profiles = {}
    table.insert(profiles, ps2:new("Knatte", 'data/avatar/cute_robot/DOWN.png', "/cute_robot/"))
    table.insert(profiles, ps2:new("Fnatte", 'data/avatar/insect_robot/DOWN.png', "/insect_robot/"))
    table.insert(profiles, ps2:new("Tjatte", 'data/avatar/strong_robot/DOWN.png', "/strong_robot/"))

    local a = ps:new()
    a.usernames = { "a", "b", "c" }
    a.pos = 1
    event.key = event.KEY_DOWN
    a:handleinput(event)
    assert_equal(5, a.pos, "should have moved down from pos 1 to pos 5")
    a.pos = 2
    a:handleinput(event)
    assert_equal(5, a.pos, "should have moved down from pos 2 to pos 5")
    a.pos = 3
    a:handleinput(event)
    assert_equal(5, a.pos, "should have moved down from pos 3 to pos 5")
    verify_mock(mc)

    _G.profiles = nil
end

-------------------------------------
-- Tests if the right user is chosen when 1 is pressed
-- @system_under_test : ProfileSelection:new(), ProfileSelection:handleinput(event)
-- @author name: Johanna; Erik
-------------------------------------
function test_handleinput_up_one()
    local ps = require(SUT)

    local ps2 = require("platform.PlatformContext")
    local ps3 = require("platform.Profile")
    _G.profiles = {}
    table.insert(profiles, ps3:new("Knatte", 'data/avatar/cute_robot/DOWN.png', "/cute_robot/"))
    table.insert(profiles, ps3:new("Fnatte", 'data/avatar/insect_robot/DOWN.png', "/insect_robot/"))
    table.insert(profiles, ps3:new("Tjatte", 'data/avatar/strong_robot/DOWN.png', "/strong_robot/"))

    local a = ps:new()
    -- a.usernames = {"a", "b", "c"}

    local a = ps:new()
    a.pos = 1
    PlatformContext = ps2:new()
    event.key = event.KEY_OK
    local b = a:handleinput(event)
    assert_equal("main", b[1], "should get main menu a")
    a.pos = 2
    local b = a:handleinput(event)
    assert_equal("main", b[1], "should get main menu b")
    a.pos = 3
    local b = a:handleinput(event)
    assert_equal("main", b[1], "should get main menu c")

    _G.profiles = nil
end

-------------------------------------
-- Checks if create is chosen if 1 is pressed
-- @system_under_test : ProfileSelection:new(), ProfileSelection:handleinput(event)
-- @author name: Johanna
-------------------------------------
function test_handleinput_down_one()
    local ps = require(SUT)
    local ps2 = require("platform.Profile")
    _G.profiles = {}
    table.insert(profiles, ps2:new("Knatte", 'data/avatar/cute_robot/DOWN.png', "/cute_robot/"))
    table.insert(profiles, ps2:new("Fnatte", 'data/avatar/insect_robot/DOWN.png', "/insect_robot/"))
    table.insert(profiles, ps2:new("Tjatte", 'data/avatar/strong_robot/DOWN.png', "/strong_robot/"))

    local a = ps:new()
    a.pos = 5
    event.key = event.KEY_OK
    local b = a:handleinput(event)
    assert_equal("create", b[1], "should get create")
    _G.profiles = nil
end

-------------------------------------
-- Test what happens if any other button is pressed.
-- @system_under_test : ProfileSelection:new(), ProfileSelection:handleinput(event)
-- @author name: Johanna
-------------------------------------
function test_handleinput_any_other_button()
    local ps = require(SUT)
    require("platform.Profile")
    local ps2 = require("platform.Profile")
    _G.profiles = {}
    table.insert(profiles, ps2:new("Knatte", 'data/avatar/cute_robot/DOWN.png', "/cute_robot/"))
    table.insert(profiles, ps2:new("Fnatte", 'data/avatar/insect_robot/DOWN.png', "/insect_robot/"))
    table.insert(profiles, ps2:new("Tjatte", 'data/avatar/strong_robot/DOWN.png', "/strong_robot/"))

    local a = ps:new()
    a.pos = 5
    event.key = '7'
    local b = a:handleinput(event)
    assert_equal(" ", b[1], "should do nothing")
    _G.profiles = nil
end

