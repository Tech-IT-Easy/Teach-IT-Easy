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
-- User: Andreas Mansson
-- Date: 2015-11-19
-- Time: 14:45
-- To change this template use File | Settings | File Templates.
--

lunit = require "lunit"
module( "inttest_id_7", package.seeall, lunit.testcase )

local SUT = 'menus.Games'

function setup()
    clear_mock()
    event = require ("toolkit.Event")
end


--Corresponds to function bottomMenuEventHandler:update(object,eventListener,event)
--in BottomMenu

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
    package.loaded['games.Progg.Queue'] = nil
    package.preload['games.Progg.Queue'] = nil
end

function test_start_progg_game()
    local PlatformContext= require("platform.PlatformContext")
    platformContext = PlatformContext:new()
    local test = require(SUT)
    local it_games = test:new()
    print(platformContext)
    event.key = event.KEY_OK
    local b=it_games:handleinput(event)
end


