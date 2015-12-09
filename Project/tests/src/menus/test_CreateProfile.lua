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
-- Date: 15-10-16
-- Time: 08:25
-- To change this template use File | Settings | File Templates.
--

lunit = require "lunit"
module( "src_menus_CreateProfile", package.seeall, lunit.testcase )
my_file = require "menus.CreateProfile"
local event = require "toolkit.Event"

-- System under test
local SUT = 'menus.CreateProfile'
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
  local status, err = pcall(function ()
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
  package.loaded['menus.CreateProfile'] = nil
  package.preload['menus.CreateProfile'] = nil
end

function test_loadview()
  local mc = create_mock(SUT)

  -- Mock renderui and printbackground
  local renderui = mc:mock()
  --local printbackground = mc:mock()

  local ps = require(SUT)

  package.loaded[SUT].renderui = renderui
 -- package.loaded[SUT].printbackground = printbackground

  renderui(mc.ANYARGS) ;mc :returns(nil) :times(1)
  --printbackground(mc.ANYARGS) ;mc :returns(nil) :times(1)

  mc:replay()

  local b = ps:new()
  b:loadview()

  verify_mock(mc)
end

-------------------------------------
-- Tests if what happens if user tries to move right from far left position.
-- @system_under_test: CreateProfile:new(), CreateProfile:handleinput(event)
-- @author name: Johanna
-------------------------------------

function test_handleinput_right_from_left()
  -- goes right from pos 1
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
  inactive(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  active(mc.ANYARGS) ;mc :returns(nil) :anytimes()

  -- Start the testing
  mc:replay()

  local a = ps:new()
  a.pos = 1
  event.key = event.KEY_RIGHT
  a:handleinput(event)
  assert_equal(2, a.pos, "should move to the right section of the screen, didn't")

  verify_mock(mc)
end

-------------------------------------
-- Tests if what happens if user tries to move right from far right position.
-- @system_under_test: CreateProfile:new(), CreateProfile:handleinput(event)
-- @author name: Johanna
-------------------------------------

function test_handleinput_right_from_right()
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
  inactive(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  active(mc.ANYARGS) ;mc :returns(nil) :anytimes()

  -- Start the testing
  mc:replay()

  local a = ps:new()
  a.pos = 28
  event.key = event.KEY_RIGHT
  a:handleinput(event)
  assert_equal(28, a.pos, "should not be able to move right from far right position")

  verify_mock(mc)
end

-------------------------------------
-- Tests if goes left from far right position (when test is written, 27 positions)
-- @system_under_test: CreateProfile:new(), CreateProfile:handleinput(event)
-- @author name: Johanna
-------------------------------------

function test_handleinput_left_from_right()
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
  inactive(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  active(mc.ANYARGS) ;mc :returns(nil) :anytimes()

  -- Start the testing
  mc:replay()

  local a = ps:new()
  a.pos = 27
  event.key = event.KEY_LEFT
  a:handleinput(event)
  assert_equal(26, a.pos, "should move to the left section of the screen, didn't")

  verify_mock(mc)
end

-------------------------------------
-- Should not be able to moce left from far left position.
-- @system_under_test: CreateProfile:new(), CreateProfile:handleinput(event)
-- @author name: Johanna
-------------------------------------

function test_handleinput_left_from_left()
  -- goes right from pos 1
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
  inactive(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  active(mc.ANYARGS) ;mc :returns(nil) :anytimes()

  -- Start the testing
  mc:replay()

  local a = ps:new()
  a.pos = 1
  event.key = event.KEY_LEFT
  a:handleinput(event)
  assert_equal(1, a.pos, "should move to the right section of the screen, didn't")

  verify_mock(mc)
end

-------------------------------------
-- Tries to add A to profilename.
-- @system_under_test: CreateProfile:new(), CreateProfile:handleinput(event)
-- @author name: Johanna
-------------------------------------

function test_handleinput_one_from_any_letter()
  local mc = create_mock(SUT)
  -- Mock inactive and active
  -- Create mock objects for each function to mock
  local inactive = mc:mock()
  local active = mc:mock()
  local updatetext = mc:mock()

  -- In this case we want to mock 2 member functions so then we import the SUT (System under test)
  local ps = require(SUT)

  -- override the original functions with mocks
  package.loaded[SUT].inactive = inactive
  package.loaded[SUT].active = active
  package.loaded[SUT].updatetext = updatetext

  -- Tell for which arguments it should work, what it should return and how many times it should be called.
  inactive(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  active(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  updatetext(mc.ANYARGS) ;mc :returns(nil) :anytimes()

  -- Start the testing
  mc:replay()

  local a = ps:new()
  a.pos = 1
  a.profilename = ""
  a.letters = { 'A', 'B', 'C', 'DONE' }
  event.key = event.KEY_OK
  a:handleinput(event)
  assert_equal("A", a.profilename, "a should be added to profilename")

  verify_mock(mc)
end

-------------------------------------
-- Tries to add A to profilename already consisting of letters.
-- @system_under_test: CreateProfile:new(), CreateProfile:handleinput(event)
-- @author name: Johanna
-------------------------------------

function test_handleinput_one_from_any_letter_to_add_new_letter_to_username()

  local mc = create_mock(SUT)
  -- Mock inactive and active
  -- Create mock objects for each function to mock
  local inactive = mc:mock()
  local active = mc:mock()
  local updatetext = mc:mock()

  -- In this case we want to mock 2 member functions so then we import the SUT (System under test)
  local ps = require(SUT)

  -- override the original functions with mocks
  package.loaded[SUT].inactive = inactive
  package.loaded[SUT].active = active
  package.loaded[SUT].updatetext = updatetext

  -- Tell for which arguments it should work, what it should return and how many times it should be called.
  inactive(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  active(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  updatetext(mc.ANYARGS) ;mc :returns(nil) :anytimes()

  -- Start the testing
  mc:replay()

  local a = ps:new()
  a.pos = 2
  a.profilename = "ABC"
  a.letters = { 'A', 'B', 'C', 'DONE' }
  event.key = event.KEY_OK
  a:handleinput(event)
  assert_equal("ABCB", a.profilename, "a should be added to profilename")

  verify_mock(mc)
end

-------------------------------------
-- Tries to press done by pressing one.
-- @system_under_test: CreateProfile:new(), CreateProfile:handleinput(event)
-- @author name: Johanna
-------------------------------------

function test_handleinput_one_from_pos_done()
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
  inactive(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  active(mc.ANYARGS) ;mc :returns(nil) :anytimes()

  -- Start the testing
  mc:replay()

  local a = ps:new()
  a.pos = 4
  a.profilename = "ABC"
  a.letters = { 'A', 'B', 'C', 'DONE' }
  event.key = event.KEY_OK
  local b = a:handleinput(event)
  assert_equal("chooseavatar", b[1], "should return chooseavatar ")
  assert_equal("ABC", a.profilename, "profilename should be ABC")

  verify_mock(mc)
end

-------------------------------------
-- Tries to go back by pressing two
-- @system_under_test: CreateProfile:new(), CreateProfile:handleinput(event)
-- @author name: Johanna
-------------------------------------

function test_handleinput_two_from_any_pos()
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
  inactive(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  active(mc.ANYARGS) ;mc :returns(nil) :anytimes()

  -- Start the testing
  mc:replay()

  local a = ps:new()
  a.pos = 4
  event.key = event.KEY_BACK
  local b = a:handleinput(event)
  assert_equal("profilesel", b[1], "should return profilesel ")
  verify_mock(mc)
end

-------------------------------------
-- Push any other button
-- @system_under_test: CreateProfile:new(), CreateProfile:handleinput(event)
-- @author name: Johanna
-------------------------------------

function test_handleinput_one_from_pos_done()
  local ps = require(SUT)
  local a = ps:new()
  a.pos = 2
  event.key = '7'
  local b = a:handleinput(event)
  assert_equal(" ", b[1], "Should do nothing")

end