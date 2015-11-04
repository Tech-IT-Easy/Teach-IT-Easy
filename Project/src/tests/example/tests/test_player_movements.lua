--
-- Created by IntelliJ IDEA.
-- User: jonathan
-- Date: 2015-09-24
-- Time: 01:26
-- To change this template use File | Settings | File Templates.
--

lunit = require "lunit"

module( "test_player_movements", package.seeall, lunit.testcase )

function setup() -- This in run before the tests
    local lemock = require 'lemock' -- needed to be able to make a mock
    mc = lemock.controller() -- same here
    local getHeight = mc:mock() -- function you want imitate.
    package.loaded.love = nil -- need to shut down the package where the function is taken from.
    package.preload['love'] = function () -- Create preload. When the program wants to include love. This function will run instead
        local love = {} -- empty table. To make sure it looks the same as in the test program.
        local graphics = {} -- empty table
        love.graphics = graphics -- assignment.
        love.graphics.getHeight = getHeight -- Adds the getHeight function to the table
        return love
    end

    getHeight(mc.ANYARGS) ;mc :returns(15) :anytimes() -- Tells what should be return. With what Inputs. This particular will return 15. mc.ANYARGS => will do this no matter what input. 15 = will return this. anytimes = How many times.

    mc:close() --
    mc:replay() -- Tells "now we start testing the code"
    package.loaded.player_movements = nil -- want this file.
    package.loaded.love = nil -- want this file
    love = require "love" -- makes sure we uses the love package created in this file.
    player_movements = require "tests.example.player_movements" -- Test this file.

end

function teardown()-- This is run AFTER the tests

    mc:verify() -- makes sure you have run enought times
    package.loaded.love = nil -- Remove read created package.
    package.preload['love'] = nil -- Removes created package.
end


function test_movePlayerUp() -- The actual test.

    local player = {y=10, speed=5} -- Wants a player, decied what speed you want to test with.
    player_movements.movePlayerUp(player,3) -- 3 = dt from file. Choose one that you can caluculate using the actual player_movements file.
    assert_equal(-5, player.y, "Message if the test fails.") --(Expected, restulat, failmessage)

end


