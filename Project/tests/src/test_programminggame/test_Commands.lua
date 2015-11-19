--
-- Created by IntelliJ IDEA.
-- User: Andreas Mansson
-- Date: 2015-11-04
-- Time: 13:19
-- To change this template use File | Settings | File Templates.
--

local SUT = 'games.Progg.Commands'

lunit = require "lunit"
module( "test_Commands", package.seeall, lunit.testcase )


-------------------------------------
-- Tests if correct selection (key press) is added to the Command object
-- @system_under_test: Commands:new(action)
-- @author name: ??
-------------------------------------

function test_Commands()
    local aCommand = require(SUT)
    local command1 = aCommand.MOVE
    local new_Command=aCommand:new(command1)
    assert_equal(command1, new_Command.command, "Did not get the right value for the commands")
end

