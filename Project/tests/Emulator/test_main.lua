--
-- Created by
-- User: Tobias Lundell
-- Date: 15-10-08
-- Time: 12:16
--
lunit = require "lunit"
module( "Emulator_main_test", package.seeall, lunit.testcase )


main = require "main" -- import the main file

function mock_render_ui()

  local lemock = require 'lemock' -- import lemock, needed to be able to make a mock
  mc = lemock.controller() -- create a mock controller, also needed
  local renderUI = mc:mock() -- function you want imitate.
  main.renderUI = renderUI -- In this case we only want to mock one function renderUI in main
  renderUI(mc.ANYARGS) ;mc :returns(nil) :anytimes() -- Tells what input the function should take and what should be
  -- return. In this case: for any input arguments return nil.
  -- mc.ANYARGS => will do this no matter what input.
  -- nil => will return this.
  -- anytimes() => How many times. in this case all times
  mc:replay() -- Tells "now we start testing the code"
end

function reset_mocks()
  mc:verify() -- makes sure you have run enought times if time is set instead of anytimes()
  package.loaded['main'] = nil -- Remove the imported package.
  package.preload['main'] = nil -- Removes the mock package.
  main = require "main" -- import main agian
end

function setup()

end

function teardown()
  reset_mocks()
end

function test_left_possible() -- Test function for moving left when not in pos 1
  mock_render_ui()
  main.setPos(2)
  local pos = main.onKey('left', 'down')
  assert_equal(1, pos, "Should move left, but couldn't")
end

function test_left_not_possible() -- Test function for moving left when in pos 1
  mock_render_ui()
  main.setPos(1)
  local pos = main.onKey('left', 'down')
  assert_equal(1, pos, "Shouldn't be able to move left, but did")
end

function test_right_possible() -- Test function for moving right when not in pos 4
  mock_render_ui()
  main.setPos(2)
  local pos = main.onKey('right', 'down')
  assert_equal(3, pos, "Should move right, but couldn't")
end

function test_right_not_possible() -- Test function for moving right when in pos 4
  mock_render_ui()
  main.setPos(4)
  local pos = main.onKey('right', 'down')
  assert_equal(4, pos, "Shouldn't be able to move right, but did")
end

function test_up_possible() -- Test function for moving up when in pos 5
  mock_render_ui()
  main.setPos(5)
  local pos = main.onKey('up', 'down')
  assert_equal(1, pos, "Should move up, but couldn't")
end

function test_up_not_possible() -- Test function for moving up when not in pos 5
  mock_render_ui()
  main.setPos(1)
  local pos = main.onKey('up', 'down')
  assert_equal(1, pos, "Shouldn't be able to move up, but did")
end

function test_down_possible()  -- Test function for moving down when not in pos 5
  mock_render_ui()
  main.setPos(2)
  local pos = main.onKey('down', 'down')
  assert_equal(5, pos, "Should move down, but couldn't")
end

function test_down_not_possible()  -- Test function for moving down when in pos 5
  mock_render_ui()
  main.setPos(5)
  local pos = main.onKey('down', 'down')
  assert_equal(5, pos, "Shouldn't be able to move down, but did")
end