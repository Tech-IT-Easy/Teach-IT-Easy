--
-- Created by IntelliJ IDEA.
-- User: johannaskolling
-- Date: 15-10-16
-- Time: 08:27
-- To change this template use File | Settings | File Templates.
--


lunit = require "lunit"
module( "Emulator_classes_Games", package.seeall, lunit.testcase )
my_file = require "Emulator.classes.Games"

-- System under test
local SUT = 'Emulator.classes.Games'
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
  package.loaded['Emulator.classes.Games'] = nil
  package.preload['Emulator.classes.Games'] = nil
end

-- tests if move right from far left posistion.
function test_handleinput_right_from_left()
   local mc = create_mock(SUT)
  -- Mock inactive and active
  -- Create mock objects for each function to mock
  local buttoninactive = mc:mock()
  local buttonactive = mc:mock()

  -- In this case we want to mock 2 member functions so then we import the SUT (System under test)
  local ps = require(SUT)

  -- override the original functions with mocks
  package.loaded[SUT].buttoninactive = buttoninactive
  package.loaded[SUT].buttonactive = buttonactive

  -- Tell for which arguments it should work, what it should return and how many times it should be called.
  buttoninactive(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  buttonactive(mc.ANYARGS) ;mc :returns(nil) :anytimes()

  -- Start the testing
  mc:replay()

  local a = ps:new()
  a.pos = 1
  a:handleinput('right')
  assert_equal(2, a.pos, "should move one position to the right, didn't ")
end

-- tests if move right from far right position, shouldn't
function test_handleinput_right_from_right()
 fail("don't know how to test if key == 'right' and self.pos <#self.games then..., Don't know how to test #self.games")
end

-- tests if move left from position that is not the far left one
function handleinput_left_form_right()
  local mc = create_mock(SUT)
  -- Mock inactive and active
  -- Create mock objects for each function to mock
  local buttoninactive = mc:mock()
  local buttonactive = mc:mock()

  -- In this case we want to mock 2 member functions so then we import the SUT (System under test)
  local ps = require(SUT)

  -- override the original functions with mocks
  package.loaded[SUT].buttoninactive = buttoninactive
  package.loaded[SUT].buttonactive = buttonactive

  -- Tell for which arguments it should work, what it should return and how many times it should be called.
  buttoninactive(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  buttonactive(mc.ANYARGS) ;mc :returns(nil) :anytimes()

  -- Start the testing
  mc:replay()

  local a = ps:new()
  a.pos = 3
  a:handleinput('left')
  assert_equal(2, a.pos, "should move one position to the left, didn't ")
end

-- tests if able to move left from far left position. Should not be able to.
function test_handleinput_left_form_left()
  local mc = create_mock(SUT)
  -- Mock inactive and active
  -- Create mock objects for each function to mock
  local buttoninactive = mc:mock()
  local buttonactive = mc:mock()

  -- In this case we want to mock 2 member functions so then we import the SUT (System under test)
  local ps = require(SUT)

  -- override the original functions with mocks
  package.loaded[SUT].buttoninactive = buttoninactive
  package.loaded[SUT].buttonactive = buttonactive

  -- Tell for which arguments it should work, what it should return and how many times it should be called.
  buttoninactive(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  buttonactive(mc.ANYARGS) ;mc :returns(nil) :anytimes()

  -- Start the testing
  mc:replay()

  local a = ps:new()
  a.pos = 1
  a:handleinput('left')
  assert_equal(1, a.pos, "should note move one position to the left, did ")
end

-- checks if main is return when trying to go back.
function test_handleinput_two_from_left()
  local ps = require(SUT)
  local a = ps:new()
  a.pos = 1
  local b = a:handleinput('2')
  assert_equal("main", b[1], "should return main")
end
-- checks if main is return when trying to go back.
function test_handleinput_other_args()
  local ps = require(SUT)
  local a = ps:new()
  a.pos = 2
  local b = a:handleinput('h')
  assert_equal(" ", b[1], "should return nothing and thereby not want to do anything")
end




function test_Games_and_fail()
   fail("Games not completely tested, always fail")
end
