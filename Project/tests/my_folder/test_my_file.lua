lunit = require "lunit" -- import lunit framework
module( "my_folder_my_file", package.seeall, lunit.testcase ) -- Name of the test, must be unique.

function setup() -- This will be runned for every test.
--  local lemock = require 'lemock' -- needed to be able to make a mock
--  local mc = lemock.controller() -- same here
--  local getHeight = mc:mock() -- function you want imitate.
--  package.loaded.love = nil -- need to delete the package where the function is taken from.
--  package.preload['love'] = function () -- Create preload. When the program wants to include love. This function will run instead
--    local love = {} -- empty table. To make sure it looks the same as in the test program.
--    local graphics = {} -- empty table
--    love.graphics = graphics -- assignment.
--    love.graphics.getHeight = getHeight -- Adds the getHeight function to the table
--    return love
--  end
--  -- If you import a package in a package and just want to mock a part off it, ex love.graphics nad not the whole love, you could unload a part of it using
--  -- package.loaded['love.graphics'] = nil
--  -- package.preload['love.graphics'] = function () -- Create preload. When the program wants to include love. This function will run instead
--  --   local graphics = {} -- empty table. To make sure it looks the same as in the test program.
--  --   graphics.getHeight = getHeight -- Adds the getHeight function to the table
--  --   return graphics
--  -- end
--
--  getHeight(mc.ANYARGS) ;mc :returns(15) :anytimes() -- Tells what should be return. With what Inputs. This particular will return 15. mc.ANYARGS => will do this no matter what input. 15 = will return this. anytimes = How many times.
--  mc:close() --
--  mc:replay() -- Tells "now we start testing the code"
--  package.loaded["my_folder.my_file"] = nil -- want this file.
--  _G.love = require "love" -- makes sure we uses the love package created in this file and that it is globaly accesable
my_file = require "my_folder.my_file"
end

function teardown()-- This is run AFTER the tests

--  mc:verify() -- makes sure you have run enought times
--  package.loaded.love = nil -- Remove read created package.
--  package.preload['love'] = nil -- Removes created package.

end


--function test_movePlayerUp() -- The actual test.
--    local player = {y=10, speed=5} -- Wants a player, decied what speed you want to test with.
--    my_file.movePlayerUp(player,3) -- 3 = dt from file. Choose one that you can caluculate using the actual player_movements file.
--    assert_equal(-5, player.y, "Message if the test fails.") --(Expected, restulat, failmessage)
--
--end


function test_addition_of_positive_numbers_with_positive_integers()  -- one test function. Must begin or end with test
  local res = my_file.addition_of_positive_numbers(1,2) -- Result of the test. addition_of_positive_numbers = function that is tested. (1,2) inputs to the addition_of_positive_numbers function. res = result of the function addition_of_positive_numbers in my_folder.my_file

  assert_equal(3, res, "Message if the test fails.") -- TEST 3 = expected result, res - result from function, "Message if the test fails." - Error message if failed.
end

function test_addition_of_positive_numbers_with_negative_integers()
  -- Description of test if needed
  local res = my_file.addition_of_positive_numbers(-1,-3)

  assert_equal(4, res, "Message if the test fails.")
end

function test_addition_of_positive_numbers_with_one_negative_one_positive_integer()
  local res = my_file.addition_of_positive_numbers(-2,3)

  assert_equal(5, res, "Message if the test fails.")
end

function test_addition_of_positive_numbers_with_one_positive_one_negative_integer()
  local res = my_file.addition_of_positive_numbers(3,-3)
  assert_equal(6, res, "Message if the test fails.")
end

function test_addition_of_positive_numbers_with_both_zero()
  local res = my_file.addition_of_positive_numbers(0,0)
  assert_equal(0, res, "Message if the test fails.")
end

-- To assure that the test will be run on the server the test must be writtin in init.lua.
