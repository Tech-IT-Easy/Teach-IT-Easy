--
-- Created by IntelliJ IDEA.
-- User: Andreas Mansson
-- Date: 2015-11-12
-- Time: 12:28
-- To change this template use File | Settings | File Templates.
--

lunit = require "lunit"
module( "test_command_queue_bottomMenu", package.seeall, lunit.testcase )

local SUT_1 = 'src.games.Progg.Queue'
local SUT_2 = 'src.games.Progg.Commands'
local SUT_3 = 'src.games.Progg.BottomMenu'

function test_command_queue_bottomMenu()
    local a = require(SUT_1)
    local b = require(SUT_2)
    local c = require(SUT_3)

    local bottommenu = c:new()
    local queue = a:new(bottommenu)
    local object1 = b:new()

    queue:push(object1)
end
