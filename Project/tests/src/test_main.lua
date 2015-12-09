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
-- Created by
-- User: Tobias Lundell
-- Date: 15-10-08
-- Time: 12:16
--
lunit = require "lunit"
module( "Emulator_main_test", package.seeall, lunit.testcase )


main = require "main" -- import the main file

function mock_render_ui()

  local lemock = require 'lemock' -- import lemock, needed to be able to make a mock
  mc = lemock.controller() -- create a mock controller, also needed
  local renderUI = mc:mock() -- function you want imitate.
  main.renderUI = renderUI -- In this case we only want to mock one function renderUI in main
  renderUI(mc.ANYARGS) ;mc :returns(nil) :anytimes() -- Tells what input the function should take and what should be
  -- return. In this case: for any input arguments return nil.
  -- mc.ANYARGS => will do this no matter what input.
  -- nil => will return this.
  -- anytimes() => How many times. in this case all times
  mc:replay() -- Tells "now we start testing the code"
end

function reset_mocks()
  mc:verify() -- makes sure you have run enought times if time is set instead of anytimes()
  package.loaded['main'] = nil -- Remove the imported package.
  package.preload['main'] = nil -- Removes the mock package.
  main = require "main" -- import main agian
end

function setup()

end

function teardown()
  reset_mocks()
end
-------------------------------------
-- Test function for moving left when not in pos 1
-- @system_under_test: main:onKey(key,state)
-- @author name: ??
-------------------------------------
function test_left_possible()
  mock_render_ui()
  main.setPos(2)
  local pos = main.onKey('left', 'down')
  assert_equal(1, pos, "Should move left, but couldn't")
end

-------------------------------------
-- Test function for moving left when in pos 1
-- @system_under_test: main:onKey(key,state)
-- @author name: ??
-------------------------------------

function test_left_not_possible()
  mock_render_ui()
  main.setPos(1)
  local pos = main.onKey('left', 'down')
  assert_equal(1, pos, "Shouldn't be able to move left, but did")
end

-------------------------------------
-- Test function for moving right when not in pos 4
-- @system_under_test: main:onKey(key,state)
-- @author name: ??
-------------------------------------

function test_right_possible()
  mock_render_ui()
  main.setPos(2)
  local pos = main.onKey('right', 'down')
  assert_equal(3, pos, "Should move right, but couldn't")
end

-------------------------------------
-- Test function for moving right when in pos 4
-- @system_under_test: main:onKey(key,state)
-- @author name: ??
-------------------------------------

function test_right_not_possible()
  mock_render_ui()
  main.setPos(4)
  local pos = main.onKey('right', 'down')
  assert_equal(4, pos, "Shouldn't be able to move right, but did")
end

-------------------------------------
-- Test function for moving up when in pos 5
-- @system_under_test: main:onKey(key,state)
-- @author name: ??
-------------------------------------

function test_up_possible()
  mock_render_ui()
  main.setPos(5)
  local pos = main.onKey('up', 'down')
  assert_equal(1, pos, "Should move up, but couldn't")
end

-------------------------------------
-- Test function for moving up when not in pos 5
-- @system_under_test: main:onKey(key,state)
-- @author name: ??
-------------------------------------

function test_up_not_possible()
  mock_render_ui()
  main.setPos(1)
  local pos = main.onKey('up', 'down')
  assert_equal(1, pos, "Shouldn't be able to move up, but did")
end

-------------------------------------
-- Test function for moving down when not in pos 5
-- @system_under_test: main:onKey(key,state)
-- @author name: ??
-------------------------------------

function test_down_possible()
  mock_render_ui()
  main.setPos(2)
  local pos = main.onKey('down', 'down')
  assert_equal(5, pos, "Should move down, but couldn't")
end

-------------------------------------
-- Test function for moving down when in pos 5
-- @system_under_test: main:onKey(key,state)
-- @author name: ??
-------------------------------------

function test_down_not_possible()
  mock_render_ui()
  main.setPos(5)
  local pos = main.onKey('down', 'down')
  assert_equal(5, pos, "Shouldn't be able to move down, but did")
end