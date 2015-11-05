--
-- Created by IntelliJ IDEA.
-- User: Andreas Mansson
-- Date: 2015-11-04
-- Time: 13:19
-- To change this template use File | Settings | File Templates.
--

local SUT = 'src.games.Progg.Commands'

lunit = require "lunit"
module( "Emulator_..", package.seeall, lunit.testcase )

function test_Commands()
    local aCommand = require(SUT)
    local new_Command=aCommand:new("MoveLeft")
    assert_equal("MoveLeft", new_Command:get(), "Did not get the right value for the commands")
end

