--
-- Created by IntelliJ IDEA.
-- User: johannaskolling
-- Date: 15-10-12
-- Time: 12:07
-- To change this template use File | Settings | File Templates.
--


lunit = require "lunit"
module( "Emulator_classes_ProfileSelection", package.seeall, lunit.testcase )
my_file = require "Emulator.classes.ProfileSelection"


function mock_render_ui()

  local lemock = require 'lemock' -- import lemock, needed to be able to make a mock
  mc = lemock.controller() -- create a mock controller, also needed
  local renderui = mc:mock() -- function you want imitate.
  function a:renderui()
    return renderui
  end
  renderui(mc.ANYARGS) ;mc :returns(nil) :anytimes() -- Tells what input the function should take and what should be
  -- return. In this case: for any input arguments return nil.
  -- mc.ANYARGS => will do this no matter what input.
  -- nil => will return this.
  -- anytimes() => How many times. in this case all times

  local printbackground = mc:mock() -- function you want imitate.
  function a:printbackground()
    return printbackground
  end
  printbackground(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  mc:replay() -- Tells "now we start testing the code"
end

function reset_mocks()
  -- makes sure you have run enought times if time is set instead of anytimes()
  package.loaded['Emulator.classes.ProfileSelection'] = nil -- Remove the imported package.
  package.preload['Emulator.classes.ProfileSelection'] = nil -- Removes the mock package.
  my_file = require "Emulator.classes.ProfileSelection" -- import main agian
end

function setup()
  a = my_file:new()
  a.usernames = {"a", "b", "c"}

end

function teardown()
  reset_mocks()
end

function test_loadview()
  mock_render_ui()
  a:loadview()
  mc:verify()
end


function test_handleinput_right()
  -- goes right from pos 1
  a.pos = 1
  a:handleinput('right')
  assert_equal(2, a.pos, "should move one step right, didn't")
end

function test_handleinput_right_two()
   -- does not move right when at far right
   a.pos = 3
   a:handleinput('right')
   assert_equal(3, a.pos, "moved right even though it was positioned far right")
end

function test_handleinput_left()
    -- does not move left when at far left pos
    a.pos = 1
    a:handleinput('left')
    assert_equal(1, a.pos, "tried to move left even though is was posistioned far left")
end

function test_handleinput_left_two()
   a.pos = 3
   a.handleinput('left')
   assert_equal(2, a.pos, "did not move left, should have.")
end

function test_handleinput_bottom_right()
  -- does not move from bottom when right is pressed
  a.pos = 5
  a:handleinput('right')
  assert_equal(5, a.pos, "moved from bottom when right was pressed")
end

function test_handleinput_bottom_left()
  -- does not move from bottom when left is pressed
  a.pos = 5
  a:handleinput('left')
  assert_equal(5, a.pos, "moved from bottom when left was pressed")
end

function test_handleinput_bottom_down()
 -- does not move from bottom when down is pressed
  a.pos = 5
  a:handleinput('down')
  assert_equal(5, a.pos, "moved from bottom when down was pressed")
end

function test_handleinput_bottom_up()
  -- moves up from bottom when up is pressed
  a. pos = 5
  a:handleinput('up')
  assert_equal(1, a.pos, "did not move up from bottom when up was pressed")
end

function test_handleinput_up_up()
  -- nothing should happen when up is pressed and pos is among the upper ones.
  a.pos = 1
  a:handleinput('up')
  assert_equal(1, a.pos, "tried to move from pos 1 when it was already up")
  a.pos = 2
  a:handleinput('up')
  assert_equal(2, a.pos, "tried to move from pos 2 when it was already up")
  a.pos = 3
  a:handleinput('up')
  assert_equal(3, a.pos, "tried to move from pos 3 when it was already up")

end

function test_handleinput_up_down()
    -- should move down to pos 5 from all upper pos when down is pressed a.pos = 1
  a.pos = 1
  a:handleinput('down')
  assert_equal(5, a.pos, "should have moved down from pos 1 to pos 5")
  a.pos = 2
  a:handleinput('down')
  assert_equal(5, a.pos, "should have moved down from pos 2 to pos 5")
  a.pos = 3
  a:handleinput('down')
  assert_equal(5, a.pos, "should have moved down from pos 3 to pos 5")

end


function test_printbackground()
  a:printbackground()
end




