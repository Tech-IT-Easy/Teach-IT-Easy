--
-- Created by IntelliJ IDEA.
-- User: Adde
-- Date: 2015-11-26
-- Time: 15:38
-- To change this template use File | Settings | File Templates.
--


lunit = require "lunit"
module( "test_Queue", package.seeall, lunit.testcase )

local SUT = 'platform.Profile'

function setup()

end


function test_input_aName_picture1()
    local ps = require(SUT)

    local a = ps:new("name", 1)
    local imagePath = a.avatar
    assert_equal(imagePath,'data/avatar/cute_robot/DOWN.png', "Should be data/avatar/cute_robot/DOWN.png")
end

function test_input_name_picture2()
    local ps = require(SUT)

    local a = ps:new("name", 2)
    local imagePath = a.avatar
    assert_equal(imagePath,'data/avatar/insect_robot/DOWN.png', "Should be data/avatar/cute_robot/RIGHT.png")
end

function test_input_name_picture3()
    local ps = require(SUT)

    local a = ps:new("name", 3)
    local imagePath = a.avatar
    assert_equal(imagePath, 'data/avatar/cute_robot/UP.png', "Should be data/avatar/cute_robot/RIGHT.png")
end
