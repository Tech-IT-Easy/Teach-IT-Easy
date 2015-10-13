--
-- Created by IntelliJ IDEA.
-- User: johannaskolling
-- Date: 15-10-12
-- Time: 12:06
-- To change this template use File | Settings | File Templates.
--


lunit = require "lunit"
module( "Emulator_classes_Object", package.seeall, lunit.testcase )
my_file = require "Emulator.classes.Object"

function test_Object_and_fail()
   fail("Object not tested, always fail")
end

