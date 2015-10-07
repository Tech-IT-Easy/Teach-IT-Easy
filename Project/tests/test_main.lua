--
-- Created by IntelliJ IDEA.
-- User: johannaskolling
-- Date: 15-10-07
-- Time: 11:30
-- To change this template use File | Settings | File Templates.
--
lunit = require "lunit"
module( "Emulator_main", package.seeall, lunit.testcase )
my_file = require "Emulator.main"

function test_GUI_and_fail()
    fail("GUI untested, always fail")
end