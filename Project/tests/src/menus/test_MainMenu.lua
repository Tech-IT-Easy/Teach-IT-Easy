--
-- Created by IntelliJ IDEA.
-- User: johannaskolling
-- Date: 15-10-12
-- Time: 09:30
-- To change this template use File | Settings | File Templates.


lunit = require "lunit"
module( "src_menus_MainMenu", package.seeall, lunit.testcase )
local event = require "toolkit.Event"

-- System under test
local SUT = 'menus.MainMenu'
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
  package.loaded['menus.MainMenu'] = nil
  package.preload['menus.MainMenu'] = nil
end

-------------------------------------
-- Tests if loadview() calls the function for drawing on screen
-- @system_under_test: MainMenu:new(), MainMenu:loadview(input)
-- @author name: Johanna
-------------------------------------

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

  local ps2 = require("platform.PlatformContext")
  platformContext = ps2:new()
  local ps3 = require("platform.Profile")
  local profiles = {}
  table.insert(profiles, ps3:new("Knatte", 'data/avatar/cute_robot/DOWN.png', "/cute_robot/"))
  platformContext.profile = profiles[1]

  local b = ps:new()
  b:loadview()

  verify_mock(mc)
end

-------------------------------------
-- Goes right from pos 1
-- @system_under_test: MainMenu:new(), MainMenu:handleinput(event)
-- @author name: Johanna
-------------------------------------

function test_handleinput_right()
  local mc = create_mock(SUT)
  -- Mock inactive and active
  -- Create mock objects for each function to mock
  local sidebuttoninactive = mc:mock()
  local sidebuttonactive = mc:mock()
  local gamebuttoninactive = mc:mock()
  local gamebuttonactive = mc:mock()

  -- In this case we want to mock 4 member functions so then we import the SUT (System under test)
  local ps = require(SUT)

  -- override the original functions with mocks
  package.loaded[SUT].sidebuttoninactive = sidebuttoninactive
  package.loaded[SUT].sidebuttonactive = sidebuttonactive
  package.loaded[SUT].gamebuttoninactive = gamebuttoninactive
  package.loaded[SUT].gamebuttonactive = gamebuttonactive

  -- Tell for which arguments it should work, what it should return and how many times it should be called.
  sidebuttoninactive(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  sidebuttonactive(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  gamebuttoninactive(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  gamebuttonactive(mc.ANYARGS) ;mc :returns(nil) :anytimes()


  -- Start the testing
  mc:replay()

  local a = ps:new()
  a.pos = 0
  event.key = event.KEY_RIGHT
  a:handleinput(event)
  assert_equal(1, a.pos, "should move to the right section of the screen, didn't")

  verify_mock(mc)
end

-------------------------------------
-- Goes down from any of the two upper item on the right side when down is pressed
-- @system_under_test: MainMenu:new(), MainMenu:handleinput(event)
-- @author name: Johanna
-------------------------------------

function test_handleinput_from_right_down()
  local mc = create_mock(SUT)
  -- Mock inactive and active
  -- Create mock objects for each function to mock
  local sidebuttoninactive = mc:mock()
  local sidebuttonactive = mc:mock()
  local gamebuttoninactive = mc:mock()
  local gamebuttonactive = mc:mock()

  -- In this case we want to mock 2 member functions so then we import the SUT (System under test)
  local ps = require(SUT)

  -- override the original functions with mocks
  package.loaded[SUT].sidebuttoninactive = sidebuttoninactive
  package.loaded[SUT].sidebuttonactive = sidebuttonactive
  package.loaded[SUT].gamebuttoninactive = gamebuttoninactive
  package.loaded[SUT].gamebuttonactive = gamebuttonactive

  -- Tell for which arguments it should work, what it should return and how many times it should be called.
  sidebuttoninactive(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  sidebuttonactive(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  gamebuttoninactive(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  gamebuttonactive(mc.ANYARGS) ;mc :returns(nil) :anytimes()

  -- Start the testing
  mc:replay()

  local a = ps:new()
  a.pos = 1
  event.key = event.KEY_DOWN
  a:handleinput(event)
  assert_equal(2, a.pos, "should move down in the right section of the screen, didn't")

  verify_mock(mc)
end

-------------------------------------
-- Should do nothing when down is pressed from bottom position on the right
-- @system_under_test: MainMenu:new(), MainMenu:handleinput(event)
-- @author name: Johanna
-------------------------------------

function test_handleinput_from_right_down_two()
  local mc = create_mock(SUT)
  -- Mock inactive and active
  -- Create mock objects for each function to mock
  local sidebuttoninactive = mc:mock()
  local sidebuttonactive = mc:mock()
  local gamebuttoninactive = mc:mock()
  local gamebuttonactive = mc:mock()

  -- In this case we want to mock 2 member functions so then we import the SUT (System under test)
  local ps = require(SUT)

  -- override the original functions with mocks
  package.loaded[SUT].sidebuttoninactive = sidebuttoninactive
  package.loaded[SUT].sidebuttonactive = sidebuttonactive
  package.loaded[SUT].gamebuttoninactive = gamebuttoninactive
  package.loaded[SUT].gamebuttonactive = gamebuttonactive

  -- Tell for which arguments it should work, what it should return and how many times it should be called.
  sidebuttoninactive(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  sidebuttonactive(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  gamebuttoninactive(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  gamebuttonactive(mc.ANYARGS) ;mc :returns(nil) :anytimes()

  -- Start the testing
  mc:replay()

  local a = ps:new()
  a.pos = 3
  event.key = event.KEY_DOWN
  a:handleinput(event)
  assert_equal(3, a.pos, "should do nothing")

  verify_mock(mc)
end

-------------------------------------
-- Should move up when in any of the two lowest sections on the right side
-- @system_under_test: MainMenu:new(), MainMenu:handleinput(event)
-- @author name: Johanna
-------------------------------------

function test_handleinput_from_right_up()
  local mc = create_mock(SUT)
  -- Mock inactive and active
  -- Create mock objects for each function to mock
  local sidebuttoninactive = mc:mock()
  local sidebuttonactive = mc:mock()
  local gamebuttoninactive = mc:mock()
  local gamebuttonactive = mc:mock()

  -- In this case we want to mock 2 member functions so then we import the SUT (System under test)
  local ps = require(SUT)

   -- override the original functions with mocks
  package.loaded[SUT].sidebuttoninactive = sidebuttoninactive
  package.loaded[SUT].sidebuttonactive = sidebuttonactive
  package.loaded[SUT].gamebuttoninactive = gamebuttoninactive
  package.loaded[SUT].gamebuttonactive = gamebuttonactive

  -- Tell for which arguments it should work, what it should return and how many times it should be called.
  sidebuttoninactive(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  sidebuttonactive(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  gamebuttoninactive(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  gamebuttonactive(mc.ANYARGS) ;mc :returns(nil) :anytimes()

  -- Start the testing
  mc:replay()

  local a = ps:new()
  a.pos = 3
  event.key = event.KEY_UP
  a:handleinput(event)
  assert_equal(2, a.pos, "should move up a step")

  verify_mock(mc)
end

-------------------------------------
-- Should do nothing when up is pressed from the top position on the right
-- @system_under_test: MainMenu:new(), MainMenu:handleinput(event)
-- @author name: Johanna
-------------------------------------

function test_handleinput_from_right_up_two()
  local mc = create_mock(SUT)
  -- Mock inactive and active
  -- Create mock objects for each function to mock
  local sidebuttoninactive = mc:mock()
  local sidebuttonactive = mc:mock()
  local gamebuttoninactive = mc:mock()
  local gamebuttonactive = mc:mock()

  -- In this case we want to mock 2 member functions so then we import the SUT (System under test)
  local ps = require(SUT)

  -- override the original functions with mocks
  package.loaded[SUT].sidebuttoninactive = sidebuttoninactive
  package.loaded[SUT].sidebuttonactive = sidebuttonactive
  package.loaded[SUT].gamebuttoninactive = gamebuttoninactive
  package.loaded[SUT].gamebuttonactive = gamebuttonactive

  -- Tell for which arguments it should work, what it should return and how many times it should be called.
  sidebuttoninactive(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  sidebuttonactive(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  gamebuttoninactive(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  gamebuttonactive(mc.ANYARGS) ;mc :returns(nil) :anytimes()

  -- Start the testing
  mc:replay()

  local a = ps:new()
  a.pos = 1
  event.key = event.KEY_UP
  a:handleinput(event)
  assert_equal(1, a.pos, "should do nothing")

  verify_mock(mc)
end

-------------------------------------
-- Should move left from right
-- @system_under_test: MainMenu:new(), MainMenu:handleinput(event)
-- @author name: Johanna
-------------------------------------

function test_handleinput_from_right_left()
  local mc = create_mock(SUT)
  -- Mock inactive and active
  -- Create mock objects for each function to mock
  local sidebuttoninactive = mc:mock()
  local sidebuttonactive = mc:mock()
  local gamebuttoninactive = mc:mock()
  local gamebuttonactive = mc:mock()

  -- In this case we want to mock 2 member functions so then we import the SUT (System under test)
  local ps = require(SUT)

   -- override the original functions with mocks
  package.loaded[SUT].sidebuttoninactive = sidebuttoninactive
  package.loaded[SUT].sidebuttonactive = sidebuttonactive
  package.loaded[SUT].gamebuttoninactive = gamebuttoninactive
  package.loaded[SUT].gamebuttonactive = gamebuttonactive

  -- Tell for which arguments it should work, what it should return and how many times it should be called.
  sidebuttoninactive(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  sidebuttonactive(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  gamebuttoninactive(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  gamebuttonactive(mc.ANYARGS) ;mc :returns(nil) :anytimes()

  -- Start the testing
  mc:replay()

  local a = ps:new()
  a.pos = 3
  event.key = event.KEY_LEFT
  a:handleinput(event)
  assert_equal(0, a.pos, "should move to the left section")

  verify_mock(mc)
end

-------------------------------------
-- Should do nothing when left is pressed from the left section
-- @system_under_test: MainMenu:new(), MainMenu:handleinput(event)
-- @author name: Johanna
-------------------------------------

function test_handleinput_left_left()
  local mc = create_mock(SUT)
  -- Mock inactive and active
  -- Create mock objects for each function to mock
  local sidebuttoninactive = mc:mock()
  local sidebuttonactive = mc:mock()
  local gamebuttoninactive = mc:mock()
  local gamebuttonactive = mc:mock()

  -- In this case we want to mock 2 member functions so then we import the SUT (System under test)
  local ps = require(SUT)

   -- override the original functions with mocks
  package.loaded[SUT].sidebuttoninactive = sidebuttoninactive
  package.loaded[SUT].sidebuttonactive = sidebuttonactive
  package.loaded[SUT].gamebuttoninactive = gamebuttoninactive
  package.loaded[SUT].gamebuttonactive = gamebuttonactive

  -- Tell for which arguments it should work, what it should return and how many times it should be called.
  sidebuttoninactive(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  sidebuttonactive(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  gamebuttoninactive(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  gamebuttonactive(mc.ANYARGS) ;mc :returns(nil) :anytimes()

  -- Start the testing
  mc:replay()

  local a = ps:new()
  a.pos = 0
  event.key = event.KEY_LEFT
  a:handleinput(event)
  assert_equal(0, a.pos, "should do nothing")

  verify_mock(mc)
end

-------------------------------------
-- Checks if game is chosen when 1 is pressed from left pos.
-- @system_under_test: MainMenu:new(), MainMenu:handleinput(event)
-- @author name: Johanna
-------------------------------------

function test_handleinput_left_one()
  local ps = require(SUT)
  local a = ps:new()
  a.pos = 0
  event.key = event.KEY_OK
  local b = a:handleinput(event)
  assert_equal("games", b[1], "should want to start game")
end

-------------------------------------
-- Checks if create is chosen if 1 is pressed
-- @system_under_test: MainMenu:new(), MainMenu:handleinput(event)
-- @author name: Johanna
-------------------------------------

function test_handleinput_two()
  local ps = require(SUT)
  local a = ps:new()
  event.key = event.KEY_BACK
  local b = a:handleinput(event)
  assert_equal("profilesel", b[1], "should get create")
end

-------------------------------------
-- Checks that it does nothing on any other case
-- @system_under_test: MainMenu:new(), MainMenu:handleinput(event)
-- @author name: Johanna
-------------------------------------

function test_handleinput_any_other()
  local ps = require(SUT)
  local a = ps:new()
  a.pos = 2
  event.key = event.KEY_RIGHT
  local b = a:handleinput(event)
  assert_equal(" ", b[1], "should do nothing")
  a.pos = 2
  event.key = 'L'
  local b = a:handleinput(event)
  assert_equal(" ", b[1], "should do nothing")

end

