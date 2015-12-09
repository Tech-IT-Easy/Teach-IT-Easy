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
-- User: Lena
-- Date: 2015-11-05
-- Time: 13:35
-- To change this template use File | Settings | File Templates.
--

-- To Test: getPosition,

lunit = require "lunit"
module( "test_RightMenu", package.seeall, lunit.testcase )
--my_file = require "games.Progg.RightMenu"

local SUT = 'games.Progg.RightMenu'

local function create_mock(class_to_mock)
  -- unload the package if loaded to dismiss previous mocks
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

function teardown()
  package.loaded[SUT] = nil
  package.preload[SUT] = nil
end

function setup()
    clear_mock()
end

-- Delete this function when the real test is done
--[[function test_RightMenu_fail()
  fail("RightMenu highlight-functions not tested yet!")
end]]

-------------------------------------
-- Testing that the currentHighlignt variable
-- is given the correct value when highlight is called
-- given that the variable has no priror value
-- @system_under_test: RightMenu:new(), RightMenu:highlight(command)
-- @author name: Vilhelm
-------------------------------------
function test_highlight_correctCommand()
  local class_to_mock = "games.Progg.DrawRightMenu"

  local mc = create_mock(class_to_mock)
  local drawHighlight = mc:mock()
  local ps=require(class_to_mock)
  package.loaded[class_to_mock].drawHighlight = drawHighlight
  drawHighlight(mc.ANYARGS) ;mc :returns(nil) :anytimes()

  mc:replay()

  local ps1 = require(SUT)
  local a = ps1:new()
  local event = "move"
  a.currentHighlight = nil
  a:highlight(event)
  assert_equal("move", a.currentHighlight, "should return 'move', didn't")
  verify_mock(mc)
end

-------------------------------------
-- Testing that the currentHighlignt variable
-- is given the correct value when highlight is called
-- given that the variable already has a value
-- @system_under_test: RightMenu:new(), RightMenu:highlight(command)
-- @author name: Vilhelm
-------------------------------------
function test_highlight_correctCommand_highlightActive()
  local class_to_mock = "games.Progg.DrawRightMenu"

  local mc = create_mock(class_to_mock)
  local drawHighlight = mc:mock()
  local ps=require(class_to_mock)
  package.loaded[class_to_mock].drawHighlight = drawHighlight
  drawHighlight(mc.ANYARGS) ;mc :returns(nil) :anytimes()

  local mc2 = create_mock(SUT)
  local removeHighlight = mc2:mock()
  local ps2=require(SUT)
  package.loaded[SUT].removeHighlight = removeHighlight
  removeHighlight(mc2.ANYARGS) ;mc2 :returns(nil) :anytimes()

  mc2:replay()
  mc:replay()

  local a = ps2:new()
  local event = "move"
  a.currentHighlight = "loop"
  a:highlight(event)
  assert_equal("move", a.currentHighlight, "should return 'move', didn't")
  verify_mock(mc)
end

-------------------------------------
-- Testing that the currentHighlignt
-- variable is reset when removeHighlight is called
-- @system_under_test: RightMenu:new(), RightMenu:removeHighlight(command)
-- @author name: Vilhelm
-------------------------------------
function test_removeHighlight_correctCommand()
  local class_to_mock = "games.Progg.DrawRightMenu"

  local mc = create_mock(class_to_mock)
  local drawHighlight = mc:mock()
  local ps=require(class_to_mock)
  package.loaded[class_to_mock].drawHighlight = drawHighlight
  drawHighlight(mc.ANYARGS) ;mc :returns(nil) :anytimes()

  mc:replay()

  local ps1 = require(SUT)
  local a = ps1:new()
  a.currentHighlight = "loop"
  a.highlightTimer = sys.new_timer(500, "callback") --FIXME
  local event = "loop"
  a:removeHighlight(event)
  assert_equal(nil, a.currentHighlight, "should return nil, didn't")
  verify_mock(mc)
end

-------------------------------------
-- Testing that the can_enter variable
-- is correctly assigned
-- @system_under_test: RightMenu:new(), RightMenu:optionsLayout(command)
-- @author name: Vilhelm
-------------------------------------
function test_optionsLayout_canEnterCommand()
  local class_to_mock = "games.Progg.DrawRightMenu"

  local mc = create_mock(class_to_mock)
  local addOptions = mc:mock()
  local ps=require(class_to_mock)
  package.loaded[class_to_mock].addOptions = addOptions
  addOptions(mc.ANYARGS) ;mc :returns(nil) :anytimes()

  mc:replay()

  local ps1 = require(SUT)
  local a = ps1:new()
  a.selectedCommand = "loop"
  a:optionsLayout()
  assert_equal(true, a.can_enter, "should return true, didn't")
  verify_mock(mc)
end

-------------------------------------
-- Testing that the can_enter variable
-- is correctly assigned
-- @system_under_test: RightMenu:new(), RightMenu:optionsLayout(command)
-- @author name: Vilhelm
-------------------------------------
function test_optionsLayout_cannotEnterCommand()
  local class_to_mock = "games.Progg.DrawRightMenu"

  local mc = create_mock(class_to_mock)
  local addOptions = mc:mock()
  local ps=require(class_to_mock)
  package.loaded[class_to_mock].addOptions = addOptions
  addOptions(mc.ANYARGS) ;mc :returns(nil) :anytimes()

  mc:replay()

  local ps1 = require(SUT)
  local a = ps1:new()
  a.selectedCommand = "move"
  a:optionsLayout()
  assert_equal(false, a.can_enter, "should return false, didn't")
  verify_mock(mc)
end