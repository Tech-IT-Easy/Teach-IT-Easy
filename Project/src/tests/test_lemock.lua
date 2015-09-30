-- User: jonathan
-- Date: 2015-09-22
-- Time: 15:25

lunit = require "lunit"
local lemock = require 'lemock'
module( "test_lemock", package.seeall, lunit.testcase )



function setup()

    mc = lemock.controller()
    printer = mc:mock()
    for key,value in pairs(package.loaded) do print(key,value) end
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

