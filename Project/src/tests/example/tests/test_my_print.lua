--
-- Created by IntelliJ IDEA.
-- User: johannaskolling
-- Date: 15-09-23
-- Time: 15:52
-- To change this template use File | Settings | File Templates.
--

lunit = require "lunit" -- Import Package,


module( "test_my_print", package.seeall, lunit.testcase ) -- Name of the test, must be unique.
my_print = require "tests.example.my_print" -- import the file to be tested.

function test_printer_first() -- one test function. Must begin or end with test
    res = my_print.printer(1, 2) -- Result of the test. printer = function that is tested. (1,2) inputs to the printer function. res = result of the function printer in my_print.
    assert_equal(3, res, "Not correct") -- TEST 3 = expected result, res - result from function, "Not Correct" - Error message if failed.
end

-- To assure that the test will be run on the server the test must be writtin in init.lua.