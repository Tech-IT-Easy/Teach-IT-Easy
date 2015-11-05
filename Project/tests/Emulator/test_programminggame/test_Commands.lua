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
local event = require "src.toolkit.Event"

function test_Commands()
    local aCommand = require(SUT)
    event.key = event.KEY_ONE
    local new_Command=aCommand:new(event,nil)
    assert_equal(new_Command.KEY_ONE, new_Command.command, "Did not get the right value for the commands")
end

