--
-- Created by IntelliJ IDEA.
-- User: johannaskolling
-- Date: 15-10-16
-- Time: 08:25
-- To change this template use File | Settings | File Templates.
--

lunit = require "lunit"
module( "src_menus_CreateProfile", package.seeall, lunit.testcase )
my_file = require "src.menus.CreateProfile"
local event = require "src.toolkit.Event"

-- System under test
local SUT = 'src.menus.CreateProfile'
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
  package.loaded['src.menus.CreateProfile'] = nil
  package.preload['src.menus.CreateProfile'] = nil
end

function test_loadview()
  local mc = create_mock(SUT)

  -- Mock renderui and printbackground
  local renderui = mc:mock()
  --local printbackground = mc:mock()

  local ps = require(SUT)

  package.loaded[SUT].renderui = renderui
 -- package.loaded[SUT].printbackground = printbackground

  renderui(mc.ANYARGS) ;mc :returns(nil) :times(1)
  --printbackground(mc.ANYARGS) ;mc :returns(nil) :times(1)

  mc:replay()

  local b = ps:new()
  b:loadview()

  verify_mock(mc)
end

function test_handleinput_right_from_left()
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
  a.pos = 1
  event.key = event.KEY_RIGHT
  a:handleinput(event)
  assert_equal(2, a.pos, "should move to the right section of the screen, didn't")

  verify_mock(mc)
end
  -- tests if what happens if user tries to move right from far right position.
function test_handleinput_right_from_right()
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
  a.pos = 27
  event.key = event.KEY_RIGHT
  a:handleinput(event)
  assert_equal(27, a.pos, "should not be able to move right from far right position")

  verify_mock(mc)
end
-- tests if goes left from far right position ( when test is written, 27 positions)
function test_handleinput_left_from_right()
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
  a.pos = 27
  event.key = event.KEY_LEFT
  a:handleinput(event)
  assert_equal(26, a.pos, "should move to the left section of the screen, didn't")

  verify_mock(mc)
end

-- should not be able to moce left from far left position.
function test_handleinput_left_from_left()
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
  a.pos = 1
  event.key = event.KEY_LEFT
  a:handleinput(event)
  assert_equal(1, a.pos, "should move to the right section of the screen, didn't")

  verify_mock(mc)
end

-- Tries to add A to profilename.
function test_handleinput_one_from_any_letter()
  local mc = create_mock(SUT)
  -- Mock inactive and active
  -- Create mock objects for each function to mock
  local inactive = mc:mock()
  local active = mc:mock()
  local updatetext = mc:mock()

  -- In this case we want to mock 2 member functions so then we import the SUT (System under test)
  local ps = require(SUT)

  -- override the original functions with mocks
  package.loaded[SUT].inactive = inactive
  package.loaded[SUT].active = active
  package.loaded[SUT].updatetext = updatetext

  -- Tell for which arguments it should work, what it should return and how many times it should be called.
  inactive(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  active(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  updatetext(mc.ANYARGS) ;mc :returns(nil) :anytimes()

  -- Start the testing
  mc:replay()

  local a = ps:new()
  a.pos = 1
  a.profilename = ""
  a.letters = { 'A', 'B', 'C', 'DONE' }
  event.key = event.KEY_OK
  a:handleinput(event)
  assert_equal("A", a.profilename, "a should be added to profilename")

  verify_mock(mc)
end

-- Tries to add A to profilename already consisting of letters.
function test_handleinput_one_from_any_letter_to_add_new_letter_to_username()

  local mc = create_mock(SUT)
  -- Mock inactive and active
  -- Create mock objects for each function to mock
  local inactive = mc:mock()
  local active = mc:mock()
  local updatetext = mc:mock()

  -- In this case we want to mock 2 member functions so then we import the SUT (System under test)
  local ps = require(SUT)

  -- override the original functions with mocks
  package.loaded[SUT].inactive = inactive
  package.loaded[SUT].active = active
  package.loaded[SUT].updatetext = updatetext

  -- Tell for which arguments it should work, what it should return and how many times it should be called.
  inactive(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  active(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  updatetext(mc.ANYARGS) ;mc :returns(nil) :anytimes()

  -- Start the testing
  mc:replay()

  local a = ps:new()
  a.pos = 2
  a.profilename = "ABC"
  a.letters = { 'A', 'B', 'C', 'DONE' }
  event.key = event.KEY_OK
  a:handleinput(event)
  assert_equal("ABCB", a.profilename, "a should be added to profilename")

  verify_mock(mc)
end

-- Tries to press done by pressing one.
function test_handleinput_one_from_pos_done()
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
  a.pos = 4
  a.profilename = "ABC"
  a.letters = { 'A', 'B', 'C', 'DONE' }
  event.key = event.KEY_OK
  local b = a:handleinput(event)
  assert_equal("chooseavatar", b[1], "should return chooseavatar ")
  assert_equal("ABC", a.profilename, "profilename should be ABC")

  verify_mock(mc)
end

-- Tries to go back by pressing two
function test_handleinput_two_from_any_pos()
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
  a.pos = 4
  event.key = event.KEY_BACK
  local b = a:handleinput(event)
  assert_equal("profilesel", b[1], "should return profilesel ")
  assert_equal(" ", b[2], "should return noting")
  verify_mock(mc)
end

-- push any other button
function test_handleinput_one_from_pos_done()
  local ps = require(SUT)
  local a = ps:new()
  a.pos = 2
  event.key = '7'
  local b = a:handleinput(event)
  assert_equal(" ", b[1], "Should do nothing")

end