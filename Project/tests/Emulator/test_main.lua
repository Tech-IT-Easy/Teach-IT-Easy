--
-- Created by
-- User: Tobias Lundell
-- Date: 15-10-08
-- Time: 12:16
--
lunit = require "lunit"
module( "Emulator_main_test", package.seeall, lunit.testcase )

function setup() -- This will be runned for every test.
  local lemock = require 'lemock' -- needed to be able to make a mock
  local mc = lemock.controller() -- same here
  local funct_count = mc:mock() -- function you want imitate.
  package.loaded.love = nil -- need to delete the package where the function is taken from.
  package.preload['love'] = function () -- Create preload. When the program wants to include love. This function will run instead
    local love = {} -- empty table. To make sure it looks the same as in the test program.
    local graphics = {} -- empty table
    love.graphics = graphics -- assignment.
    --love.graphics.getHeight = getHeight -- Adds the getHeight function to the table
    return love
  end
  -- If you import a package in a package and just want to mock a part off it, ex love.graphics nad not the whole love, you could unload a part of it using
  -- package.loaded['love.graphics'] = nil
  -- package.preload['love.graphics'] = function () -- Create preload. When the program wants to include love. This function will run instead
  --   local graphics = {} -- empty table. To make sure it looks the same as in the test program.
  --   graphics.getHeight = getHeight -- Adds the getHeight function to the table
  --   return graphics
  -- end

  --getHeight(mc.ANYARGS) ;mc :returns(15) :anytimes() -- Tells what should be return. With what Inputs. This particular will return 15. mc.ANYARGS => will do this no matter what input. 15 = will return this. anytimes = How many times.
  mc:close() --
  mc:replay() -- Tells "now we start testing the code"
  package.loaded["Emulator.main"] = nil -- want this file.
  _G.love = require "love" -- makes sure we uses the love package created in this file and that it is globaly accesable
  my_file = require "Emulator.main"
end

--function test_stb_input_null()
--    fail("No functions to test!")
--end
function test_left_possible() -- Test function for moving left when not in pos 1
  my_file.setPos(2)
  local pos = my_file.onKey('left', 'down')
  assert_equal(1, pos, "Should move left, but couldn't")
end

function test_left_not_possible() -- Test function for moving left when in pos 1
  my_file.setPos(1)
  local pos = my_file.onKey('left', 'down')
  assert_equal(1, pos, "Shouldn't be able to move left, but did")
end

function test_right_possible() -- Test function for moving right when not in pos 4
  my_file.setPos(2)
  local pos = my_file.onKey('right', 'down')
  assert_equal(3, pos, "Should move right, but couldn't")
end

function test_right_not_possible() -- Test function for moving right when in pos 4
  my_file.setPos(4)
  local pos = my_file.onKey('right', 'down')
  assert_equal(4, pos, "Shouldn't be able to move right, but did")
end

function test_up_possible() -- Test function for moving up when in pos 5
  my_file.setPos(5)
  local pos = my_file.onKey('up', 'down')
  assert_equal(1, pos, "Should move up, but couldn't")
end

function test_up_not_possible() -- Test function for moving up when not in pos 5
  my_file.setPos(1)
  local pos = my_file.onKey('up', 'down')
  assert_equal(1, pos, "Shouldn't be able to move up, but did")
end

function test_down_possible()  -- Test function for moving down when not in pos 5
  my_file.setPos(2)
  local pos = my_file.onKey('down', 'down')
  assert_equal(5, pos, "Should move down, but couldn't")
end

function test_down_not_possible()  -- Test function for moving down when in pos 5
  my_file.setPos(5)
  local pos = my_file.onKey('down', 'down')
  assert_equal(5, pos, "Shouldn't be able to move down, but did")
end