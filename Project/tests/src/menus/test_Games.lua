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
-- Time: 08:27
-- To change this template use File | Settings | File Templates.
--


lunit = require "lunit"
module( "src_menus_Games", package.seeall, lunit.testcase )
my_file = require "menus.Games"
local event = require "toolkit.Event"


-- System under test
local SUT = 'menus.Games'
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
  package.loaded['menus.Games'] = nil
  package.preload['menus.Games'] = nil
end

-------------------------------------
-- Tests if move right from far left posistion.
-- @system_under_test: Games:new(), Games:handleinput(event)
-- @author name: Johanna
-------------------------------------

function test_handleinput_right_from_left()
   local mc = create_mock(SUT)
  -- Mock inactive and active
  -- Create mock objects for each function to mock
  local buttoninactive = mc:mock()
  local buttonactive = mc:mock()

  -- In this case we want to mock 2 member functions so then we import the SUT (System under test)
  local ps = require(SUT)

  -- override the original functions with mocks
  package.loaded[SUT].buttoninactive = buttoninactive
  package.loaded[SUT].buttonactive = buttonactive

  -- Tell for which arguments it should work, what it should return and how many times it should be called.
  buttoninactive(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  buttonactive(mc.ANYARGS) ;mc :returns(nil) :anytimes()

  -- Start the testing
  mc:replay()

  local a = ps:new()
  a.pos = 1
  event.key = event.KEY_RIGHT
  a:handleinput(event)
  assert_equal(2, a.pos, "should move one position to the right, didn't ")
end

-------------------------------------
-- Tests if move right from far right position, shouldn't
-- @system_under_test: Games:new(), Games:handleinput(event)
-- @author name: Johanna
-------------------------------------

function test_handleinput_right_from_right()
       local mc = create_mock(SUT)
       -- Mock inactive and active
       -- Create mock objects for each function to mock

       local buttoninactive = mc:mock()
       local buttonactive = mc:mock()

       -- In this case we want to mock 2 member functions so then we import the SUT (System under test)
       local ps = require(SUT)

       -- ocerride the original functions with mocks
       package.loaded[SUT].buttoninactive = buttoninactive
       package.loaded[SUT].buttonactive = buttonactive

       -- Tell for which arguments it should work, what it should return and how many times it should be called.
       buttoninactive(mc.ANYARGS) ;mc :returns(nil) :anytimes()
       buttonactive(mc.ANYARGS) ;mc :returns(nil) :anytimes()

       -- start the testing
       mc:replay()

       local a = ps:new()
       a.pos = 4
       event.key = event.KEY_RIGHT
       a:handleinput(event)
       assert_equal(4, a.pos, "should not move right!")

 --fail("don't know how to test if key == 'right' and self.pos <#self.games then..., Don't know how to test #self.games")
end

-------------------------------------
-- Tests if move left from position that is not the far left one
-- @system_under_test: Games:new(), Games:handleinput(event)
-- @author name: Johanna
-------------------------------------

function handleinput_left_form_right()
  local mc = create_mock(SUT)
  -- Mock inactive and active
  -- Create mock objects for each function to mock
  local buttoninactive = mc:mock()
  local buttonactive = mc:mock()

  -- In this case we want to mock 2 member functions so then we import the SUT (System under test)
  local ps = require(SUT)

  -- override the original functions with mocks
  package.loaded[SUT].buttoninactive = buttoninactive
  package.loaded[SUT].buttonactive = buttonactive

  -- Tell for which arguments it should work, what it should return and how many times it should be called.
  buttoninactive(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  buttonactive(mc.ANYARGS) ;mc :returns(nil) :anytimes()

  -- Start the testing
  mc:replay()

  local a = ps:new()
  a.pos = 3
  event.key= event.KEY_LEFT
  a:handleinput(event)
  assert_equal(2, a.pos, "should move one position to the left, didn't ")
end

-------------------------------------
-- Tests if able to move left from far left position. Should not be able to.
-- @system_under_test: Games:new(), Games:handleinput(event)
-- @author name: Johanna
-------------------------------------

function test_handleinput_left_form_left()
  local mc = create_mock(SUT)
  -- Mock inactive and active
  -- Create mock objects for each function to mock
  local buttoninactive = mc:mock()
  local buttonactive = mc:mock()

  -- In this case we want to mock 2 member functions so then we import the SUT (System under test)
  local ps = require(SUT)

  -- override the original functions with mocks
  package.loaded[SUT].buttoninactive = buttoninactive
  package.loaded[SUT].buttonactive = buttonactive

  -- Tell for which arguments it should work, what it should return and how many times it should be called.
  buttoninactive(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  buttonactive(mc.ANYARGS) ;mc :returns(nil) :anytimes()

  -- Start the testing
  mc:replay()

  local a = ps:new()
  a.pos = 1
  event.key = event.KEY_LEFT
  a:handleinput(event)
  assert_equal(1, a.pos, "should note move one position to the left, did ")
end

-------------------------------------
-- Checks if main is return when trying to go back.
-- @system_under_test: Games:new(), Games:handleinput(event)
-- @author name: Johanna
-------------------------------------

function test_handleinput_two_from_left()
  local ps = require(SUT)
  local a = ps:new()
  a.pos = 1
  event.key = event.KEY_BACK
  local b = a:handleinput(event)
  assert_equal("main", b[1], "should return main")
end

-------------------------------------
-- Checks if main is return when trying to go back.
-- @system_under_test: Games:new(), Games:handleinput(event)
-- @author name: Johanna
-------------------------------------

function test_handleinput_other_args()
  local ps = require(SUT)
  local a = ps:new()
  a.pos = 2
  event.key = 'h'
  local b = a:handleinput(event)
  assert_equal(" ", b[1], "should return nothing and thereby not want to do anything")
end




