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
  local inactive = mc:mock()
  local active = mc:mock()

  -- In this case we want to mock 2 member functions so then we import the SUT (System under test)
  local ps = require(SUT)

  -- override the original functions with mocks
  package.loaded[SUT].buttoninactive = inactive
  package.loaded[SUT].buttonactive = active

  -- Tell for which arguments it should work, what it should return and how many times it should be called.
  inactive(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  active(mc.ANYARGS) ;mc :returns(nil) :anytimes()

  -- Start the testing
  mc:replay()

  local a = ps:new()
  a.pos = 1
  a:handleinput('right')
  assert_equal(2, a.pos, "should move one position to the right, didn't ")
end



function test_MainView_and_fail()
   fail("Games not tested, always fail")
end
