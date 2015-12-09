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
-- Date: 2015-11-26
-- Time: 15:38
-- To change this template use File | Settings | File Templates.
--


lunit = require "lunit"
module( "test_Queue", package.seeall, lunit.testcase )

local SUT = 'platform.Profile'

--function setup()

--end


function test_input_aName_picture1()
    local ps = require(SUT)

    local a = ps:new("name", 'data/avatar/cute_robot/DOWN.png', 'data/avatar/cute_robot/')
    local imagePath = a.avatar
    assert_equal(imagePath,'data/avatar/cute_robot/DOWN.png', "Should be data/avatar/cute_robot/DOWN.png")
end

function test_input_name_picture2()
    local ps = require(SUT)

    local a = ps:new("name", 'data/avatar/insect_robot/DOWN.png', 'data/avatar/insect_robot/')
    local imagePath = a.avatar
    assert_equal(imagePath,'data/avatar/insect_robot/DOWN.png', "Should be data/avatar/insect_robot/RIGHT.png")
end

function test_input_name_picture3()
    local ps = require(SUT)

    local a = ps:new("name", 'data/avatar/cute_robot/UP.png', 'data/avatar/cute_robot/')
    local imagePath = a.avatar
    assert_equal(imagePath, 'data/avatar/cute_robot/UP.png', "Should be data/avatar/cute_robot/RIGHT.png")
end
