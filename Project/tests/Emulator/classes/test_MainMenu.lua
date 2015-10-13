--
-- Created by IntelliJ IDEA.
-- User: johannaskolling
-- Date: 15-10-12
-- Time: 09:30
-- To change this template use File | Settings | File Templates.


lunit = require "lunit"
module( "Emulator_classes_MainMenu", package.seeall, lunit.testcase )
my_file = require "Emulator.classes.MainMenu"

function test_MainMenu_and_fail()
   fail("Main Menu not tested, always fail")
end

