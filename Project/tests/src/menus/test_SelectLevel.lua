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
-- User: Marcus
-- Date: 2015-12-03
-- Time: 13:29
-- To change this template use File | Settings | File Templates.
--

--[[lunit = require "lunit"
module("src_menus_SelectLevel", package.seeall, lunit.testcase)
SelectLevel = require "menus.SelectLevel"

local SUT = 'menus.SelectLevel'

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
    package.loaded['menus.SelectLevel'] = nil
    package.preload['menus.SelectLevel'] = nil
end

function test_loadview()
    local mc = create_mock(SUT)

    local ps = require(SUT)

    local a = ps:new()
    local input = "Namn"
    a.pos = 1
    a.lastpos = 1
    a.username = input
    a.unlockedLevels = 5

    a:renderui(5)

    verify_mock(mc)
end

]]