--
-- Created by IntelliJ IDEA.
-- User: johannaskolling
-- Date: 15-10-12
-- Time: 09:30
-- To change this template use File | Settings | File Templates.


lunit = require "lunit"
module( "Emulator_classes_MainMenu", package.seeall, lunit.testcase )


-- System under test
local SUT = 'Emulator.classes.MainMenu'
local function create_mock(class_to_mock)
  -- unload the package if loaded to dissmiss previous mocks
  package.loaded[class_to_mock] = nil
  package.preload[class_to_mock] = nil
  -- import lemock
  local lemock = require 'lemock'
  -- initiate mock controller
  local mc = lemock.controller()
  return mc
end

local function verify_mock(mc)
  local status, err = pcall(function ()
    -- Verify that the mocks has been called as stated.
    mc:verify()
  end)
  if err then -- if error fail the test.
    fail(err)
  end
end


function setup()

end

function teardown()
  package.loaded['Emulator.classes.MainMenu'] = nil
  package.preload['Emulator.classes.MainMenu'] = nil
end

function test_handleinput_right()
  -- goes right from pos 1
  local mc = create_mock(SUT)
  -- Mock inactive and active
  -- Create mock objects for each function to mock
  local inactive = mc:mock()
  local active = mc:mock()

  -- In this case we want to mock 2 member functions so then we import the SUT (System under test)
  local ps = require(SUT)

  -- override the original functions with mocks
  package.loaded[SUT].inactive = inactive
  package.loaded[SUT].active = active

  -- Tell for which arguments it should work, what it should return and how many times it should be called.
  inactive(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  active(mc.ANYARGS) ;mc :returns(nil) :anytimes()

  -- Start the testing
  mc:replay()

  local a = ps:new()
  a.pos = 0
  a:handleinput('right')
  assert_equal(1, a.pos, "should move to the right section of the screen, didn't")

  verify_mock(mc)
end

function test_handleinput_from_right_down()
  -- goes down from any of the two upper item on the right side when down is pressed
  local mc = create_mock(SUT)
  -- Mock inactive and active
  -- Create mock objects for each function to mock
  local inactive = mc:mock()
  local active = mc:mock()

  -- In this case we want to mock 2 member functions so then we import the SUT (System under test)
  local ps = require(SUT)

  -- override the original functions with mocks
  package.loaded[SUT].inactive = inactive
  package.loaded[SUT].active = active

  -- Tell for which arguments it should work, what it should return and how many times it should be called.
  inactive(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  active(mc.ANYARGS) ;mc :returns(nil) :anytimes()

  -- Start the testing
  mc:replay()

  local a = ps:new()
  a.pos = 1
  a:handleinput('down')
  assert_equal(2, a.pos, "should move down in the right section of the screen, didn't")

  verify_mock(mc)
end

function test_handleinput_from_right_down_two()
  -- should do nothing when down is pressed from bottom position on the right
  local mc = create_mock(SUT)
  -- Mock inactive and active
  -- Create mock objects for each function to mock
  local inactive = mc:mock()
  local active = mc:mock()

  -- In this case we want to mock 2 member functions so then we import the SUT (System under test)
  local ps = require(SUT)

  -- override the original functions with mocks
  package.loaded[SUT].inactive = inactive
  package.loaded[SUT].active = active

  -- Tell for which arguments it should work, what it should return and how many times it should be called.
  inactive(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  active(mc.ANYARGS) ;mc :returns(nil) :anytimes()

  -- Start the testing
  mc:replay()

  local a = ps:new()
  a.pos = 3
  a:handleinput('down')
  assert_equal(3, a.pos, "should do nothing")

  verify_mock(mc)
end
function test_handleinput_from_right_up()
  -- should move up when in any of the two lowest sections on the right side
  local mc = create_mock(SUT)
  -- Mock inactive and active
  -- Create mock objects for each function to mock
  local inactive = mc:mock()
  local active = mc:mock()

  -- In this case we want to mock 2 member functions so then we import the SUT (System under test)
  local ps = require(SUT)

  -- override the original functions with mocks
  package.loaded[SUT].inactive = inactive
  package.loaded[SUT].active = active

  -- Tell for which arguments it should work, what it should return and how many times it should be called.
  inactive(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  active(mc.ANYARGS) ;mc :returns(nil) :anytimes()

  -- Start the testing
  mc:replay()

  local a = ps:new()
  a.pos = 3
  a:handleinput('up')
  assert_equal(2, a.pos, "should move up a step")

  verify_mock(mc)
end
function test_handleinput_from_right_up_two()
  -- should do nothing when up is pressed from the top position on the right
  local mc = create_mock(SUT)
  -- Mock inactive and active
  -- Create mock objects for each function to mock
  local inactive = mc:mock()
  local active = mc:mock()

  -- In this case we want to mock 2 member functions so then we import the SUT (System under test)
  local ps = require(SUT)

  -- override the original functions with mocks
  package.loaded[SUT].inactive = inactive
  package.loaded[SUT].active = active

  -- Tell for which arguments it should work, what it should return and how many times it should be called.
  inactive(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  active(mc.ANYARGS) ;mc :returns(nil) :anytimes()

  -- Start the testing
  mc:replay()

  local a = ps:new()
  a.pos = 1
  a:handleinput('up')
  assert_equal(1, a.pos, "should do nothing")

  verify_mock(mc)
end

function test_handleinput_from_right_left()
  -- should move left from right
  local mc = create_mock(SUT)
  -- Mock inactive and active
  -- Create mock objects for each function to mock
  local inactive = mc:mock()
  local active = mc:mock()

  -- In this case we want to mock 2 member functions so then we import the SUT (System under test)
  local ps = require(SUT)

  -- override the original functions with mocks
  package.loaded[SUT].inactive = inactive
  package.loaded[SUT].active = active

  -- Tell for which arguments it should work, what it should return and how many times it should be called.
  inactive(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  active(mc.ANYARGS) ;mc :returns(nil) :anytimes()

  -- Start the testing
  mc:replay()

  local a = ps:new()
  a.pos = 3
  a:handleinput('left')
  assert_equal(0, a.pos, "should move to the left section")

  verify_mock(mc)
end

function test_handleinput_left_left()
  -- should do nothing when left is pressed from the left section
  local mc = create_mock(SUT)
  -- Mock inactive and active
  -- Create mock objects for each function to mock
  local inactive = mc:mock()
  local active = mc:mock()

  -- In this case we want to mock 2 member functions so then we import the SUT (System under test)
  local ps = require(SUT)

  -- override the original functions with mocks
  package.loaded[SUT].inactive = inactive
  package.loaded[SUT].active = active

  -- Tell for which arguments it should work, what it should return and how many times it should be called.
  inactive(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  active(mc.ANYARGS) ;mc :returns(nil) :anytimes()

  -- Start the testing
  mc:replay()

  local a = ps:new()
  a.pos = 0
  a:handleinput('left')
  assert_equal(0, a.pos, "should do nothing")

  verify_mock(mc)
end

function test_handleinput_left_one()
  -- checks if game is chosen when 1 is pressed from left pos.
  local ps = require(SUT)
  local a = ps:new()
  a.pos = 0
  local b = a:handleinput('1')
  assert_equal("games", b[1], "should want to start game")
end

function test_handleinput_blankspace()
  -- checks if create is chosen if 1 is pressed
  local ps = require(SUT)
  local a = ps:new()
  local b = a:handleinput('backspace')
  assert_equal("profilesel", b[1], "should get create")
end

function test_handleinput_any_other()
  -- checks that is does nothing on any other case
  local ps = require(SUT)
  local a = ps:new()
  a.pos = 2
  local b = a:handleinput('right')
  assert_equal(" ", b[1], "should do nothing")
  a.pos = 2
  local b = a:handleinput('L')
  assert_equal(" ", b[1], "should do nothing")

end

