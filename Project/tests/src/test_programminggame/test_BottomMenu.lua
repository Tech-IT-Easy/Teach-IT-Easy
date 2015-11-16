--
-- Created by IntelliJ IDEA.
-- User: Andreas Mansson
-- Date: 2015-11-05
-- Time: 11:38
-- To change this template use File | Settings | File Templates.
--

lunit = require "lunit"
module( "test_BottomMenu", package.seeall, lunit.testcase )

local SUT = 'src.games.Progg.BottomMenu'

-- Delete this function when the real test is done
--function test_BottomMenu_fail()
--   fail("BottomMenu class and functions not tested yet!")
--end

function test_setQueue()
   local bottommenu = require(SUT):new()
   local inputarea = "Area 1"

   bottommenu:setQueue(inputarea)

   lunit.assert_equal(inputarea, bottommenu.inputArea, "The input area should be 'Area 1' but wasn't")
end