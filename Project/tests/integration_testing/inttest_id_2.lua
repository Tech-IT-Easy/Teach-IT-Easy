--
-- Created by IntelliJ IDEA.
-- User: Dator
-- Date: 2015-11-16
-- Time: 22:04
-- To change this template use File | Settings | File Templates.
--

--
-- Created by IntelliJ IDEA.
-- User: Andreas Mansson
-- Date: 2015-11-12
-- Time: 12:28
-- To change this template use File | Settings | File Templates.
--

lunit = require "lunit"
module( "inttest_id_2", package.seeall, lunit.testcase )

local SUT = 'src.games.Progg.Queue'

function test_command_queue_bottomMenu()
    local class_to_mock="games.Progg.BottmMenu"
    local mc = create_mock(class_to_mock)

    local a = require(SUT_1)
    local b = require(SUT_2)
    local c = require(SUT_3)

    local bottommenu = c:new()
    local queue = a:new(bottommenu)
    local object1 = b:new()

    queue:push(object1)
end


