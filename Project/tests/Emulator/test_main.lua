--
-- Created by
-- User: Tobias Lundell
-- Date: 15-10-08
-- Time: 12:16
--
lunit = require "lunit"
module( "Emulator_main_test", package.seeall, lunit.testcase )

my_file = require "Emulator.main"

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