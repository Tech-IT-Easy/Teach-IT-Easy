--
-- Created by IntelliJ IDEA.
-- User: Andreas Mansson
-- Date: 2015-11-05
-- Time: 11:49
-- To change this template use File | Settings | File Templates.
--

lunit = require "lunit"
module( "test_Position", package.seeall, lunit.testcase )

local SUT = 'games.Progg.Position'


function test_create()
   local pos = require(SUT):new(1,2)
   lunit.assert_equal(1, pos:getX(), "X value not created correctly")
   lunit.assert_equal(2, pos:getY(), "Y value not created correctly")

   pos:setX(3)
   pos:setY(4)

   lunit.assert_equal(3, pos:getX(), "X value not changed correctly")
   lunit.assert_equal(4, pos:getY(), "Y value not changed correctly")

end