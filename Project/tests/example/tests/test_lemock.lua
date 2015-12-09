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
-- User: jonathan
-- Date: 2015-09-22
-- Time: 15:25

lunit = require "lunit"
local lemock = require 'lemock'
module( "test_lemock", package.seeall, lunit.testcase )



function setup()

    mc = lemock.controller()
    printer = mc:mock()

    package.loaded['tests.example.my_print'] = nil
    package.loaded['tests.example.my_func'] = nil
    package.preload['tests.example.my_print'] = nil
    package.preload['tests.example.my_func'] = nil
    package.preload['tests.example.my_print'] = function ()
        local my_print = {}
        my_print.printer = printer
        return my_print
    end

    printer(mc.ANYARGS) ;mc :returns(15) :anytimes()

    mc:close()
    mc:replay()
    package.loaded['tests.example.my_func'] = nil
    my_func = require "tests.example.my_func"
end

function teardown()

    mc:verify()
    package.loaded['tests.example.my_print'] = nil
    package.loaded['tests.example.my_func'] = nil
    package.preload['tests.example.my_print'] = nil
    package.preload['tests.example.my_func'] = nil
end


function test_mocked_function()

    my_func.plus(1,3)
    local res = my_func.plus(1,3)
    assert_equal(15, res, "Message if the test fails.")

end

