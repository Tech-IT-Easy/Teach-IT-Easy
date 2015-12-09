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
-- User: Adde
-- Date: 2015-11-16
-- Time: 15:44
-- To change this template use File | Settings | File Templates.
--


lunit = require "lunit"
module( "src_games_Progg_Tile", package.seeall, lunit.testcase )


-- System under test
local SUT = 'games.Progg.Tile'
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
    clear_mock()
end

function teardown()
  package.loaded['games.Progg.Tile'] = nil
  package.preload['games.Progg.Tile'] = nil
end

-------------------------------------
-- ??
-- @system_under_test: Tile:new(value)
-- @author name: ??
-------------------------------------

function test_input_0()
    local ps = require(SUT)

    local a = ps:new("0")
    assert_false(a.topBorder, "Should be false")
  assert_false(a.bottomBorder, "Should be false")
  assert_false(a.leftBorder, "Should be false")
  assert_false(a.rightBorder, "Should be false")

end

function test_input_1()
    local ps = require(SUT)

    local a = ps:new("1")
    assert_false(a.topBorder, "Should be false")
  assert_false(a.bottomBorder, "Should be false")
  assert_true(a.leftBorder, "Should be true")
  assert_false(a.rightBorder, "Should be false")

end

function test_input_2()
    local ps = require(SUT)
    local a = ps:new("2")
    assert_false(a.topBorder, "Should be false")
  assert_true(a.bottomBorder, "Should be true")
  assert_false(a.leftBorder, "Should be false")
  assert_false(a.rightBorder, "Should be false")
end

function test_input_3()
    local ps = require(SUT)
    local a = ps:new("3")
    assert_false(a.topBorder, "Should be false")
  assert_true(a.bottomBorder, "Should be true")
  assert_true(a.leftBorder, "Should be true")
  assert_false(a.rightBorder, "Should be false")
end


function test_input_4()
    local ps = require(SUT)
    local a = ps:new("4")
    assert_false(a.topBorder, "Should be false")
  assert_false(a.bottomBorder, "Should be false")
  assert_false(a.leftBorder, "Should be false")
  assert_true(a.rightBorder, "Should be true")
end

function test_input_5()
    local ps = require(SUT)
    local a = ps:new("5")
    assert_false(a.topBorder, "Should be false")
  assert_false(a.bottomBorder, "Should be false")
  assert_true(a.leftBorder, "Should be true")
  assert_true(a.rightBorder, "Should be true")
end

function test_input_6()
    local ps = require(SUT)
    local a = ps:new("6")
    assert_false(a.topBorder, "Should be false")
  assert_true(a.bottomBorder, "Should be true")
  assert_false(a.leftBorder, "Should be false")
  assert_true(a.rightBorder, "Should be true")
end

function test_input_7()
    local ps = require(SUT)
    local a = ps:new("7")
    assert_false(a.topBorder, "Should be false")
  assert_true(a.bottomBorder, "Should be true")
  assert_true(a.leftBorder, "Should be true")
  assert_true(a.rightBorder, "Should be true")
end

function test_input_8()
    local ps = require(SUT)
    local a = ps:new("8")
    assert_true(a.topBorder, "Should be true")
  assert_false(a.bottomBorder, "Should be false")
  assert_false(a.leftBorder, "Should be false")
  assert_false(a.rightBorder, "Should be false")
end

function test_input_9()
    local ps = require(SUT)
    local a = ps:new("9")
    assert_true(a.topBorder, "Should be true")
  assert_false(a.bottomBorder, "Should be false")
  assert_true(a.leftBorder, "Should be true")
  assert_false(a.rightBorder, "Should be false")
end

function test_input_a()
    local ps = require(SUT)
    local a = ps:new("a")
    assert_true(a.topBorder, "Should be true")
  assert_true(a.bottomBorder, "Should be true")
  assert_false(a.leftBorder, "Should be false")
  assert_false(a.rightBorder, "Should be false")
end

function test_input_b()
    local ps = require(SUT)
    local a = ps:new("b")
    assert_true(a.topBorder, "Should be true")
  assert_true(a.bottomBorder, "Should be true")
  assert_true(a.leftBorder, "Should be true")
  assert_false(a.rightBorder, "Should be false")
end

function test_input_c()
    local ps = require(SUT)
    local a = ps:new("c")
    assert_true(a.topBorder, "Should be true")
  assert_false(a.bottomBorder, "Should be false")
  assert_false(a.leftBorder, "Should be false")
  assert_true(a.rightBorder, "Should be true")
end

function test_input_d()
    local ps = require(SUT)
    local a = ps:new("d")
    assert_true(a.topBorder, "Should be true")
  assert_false(a.bottomBorder, "Should be false")
  assert_true(a.leftBorder, "Should be true")
  assert_true(a.rightBorder, "Should be true")
end

function test_input_e()
    local ps = require(SUT)
    local a = ps:new("e")
    assert_true(a.topBorder, "Should be true")
  assert_true(a.bottomBorder, "Should be true")
  assert_false(a.leftBorder, "Should be false")
  assert_true(a.rightBorder, "Should be true")
end

function test_input_f()
    local ps = require(SUT)
    local a = ps:new("f")
    assert_false(a.topBorder, "Should be false")
  assert_false(a.bottomBorder, "Should be false")
  assert_false(a.leftBorder, "Should be false")
  assert_false(a.rightBorder, "Should be false")
end


-- FIXME: Write tests
--[[function test_tile_fail()

    fail("Not tested , always fails...")
end]]




