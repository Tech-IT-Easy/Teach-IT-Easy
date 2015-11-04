--
-- Created by IntelliJ IDEA.
-- User: johannaskolling
-- Date: 15-10-12
-- Time: 12:07
-- To change this template use File | Settings | File Templates.
--


lunit = require "lunit"
module( "src_menus_ProfileSelection", package.seeall, lunit.testcase )
--local Object = require'src.toolkit.Object'
local event = require "src.toolkit.Event"


-- System under test
local SUT = 'src.menus.ProfileSelection'
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
  package.loaded['src.menus.ProfileSelection'] = nil
  package.preload['src.menus.ProfileSelection'] = nil
end

function test_loadview()
  local mc = create_mock(SUT)

  -- Mock renderui and printbackground
  local renderui = mc:mock()
  --local printbackground = mc:mock()

  local ps = require(SUT)

  package.loaded[SUT].renderui = renderui
  --package.loaded[SUT].printbackground = printbackground

  renderui(mc.ANYARGS) ;mc :returns(nil) :times(1)
  --printbackground(mc.ANYARGS) ;mc :returns(nil) :times(1)

  mc:replay()

  local b = ps:new()
  b:loadview()

  verify_mock(mc)
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
  a.usernames = {"a", "b", "c"}
  a.pos = 1
  event.key = event.KEY_RIGHT
  a:handleinput(event)
  assert_equal(2, a.pos, "should move one step right, didn't")

  verify_mock(mc)
end

function test_handleinput_right_two()
   -- does not move right when at far right
  local mc = create_mock(SUT)
  local inactive = mc:mock()
  local active = mc:mock()
  local ps = require(SUT)
  package.loaded[SUT].inactive = inactive
  package.loaded[SUT].active = active
  inactive(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  active(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  mc:replay()

  local a = ps:new()
  a.usernames = {"a", "b", "c"}
  a.pos = 3
  event.key = event.KEY_RIGHT
  a:handleinput(event)
  assert_equal(3, a.pos, "moved right even though it was positioned far right")

  verify_mock(mc)
end

function test_handleinput_left()
    -- does not move left when at far left pos
  local mc = create_mock(SUT)
  local inactive = mc:mock()
  local active = mc:mock()
  local ps = require(SUT)
  package.loaded[SUT].inactive = inactive
  package.loaded[SUT].active = active
  inactive(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  active(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  mc:replay()

  local a = ps:new()
  a.usernames = {"a", "b", "c"}
  a.pos = 1
  event.key = event.KEY_LEFT
  a:handleinput(event)
  assert_equal(1, a.pos, "tried to move left even though is was posistioned far left")
  verify_mock(mc)
end

function test_handleinput_left_two()
  -- should move one step left
  local mc = create_mock(SUT)
  local inactive = mc:mock()
  local active = mc:mock()
  local ps = require(SUT)
  package.loaded[SUT].inactive = inactive
  package.loaded[SUT].active = active
  inactive(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  active(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  mc:replay()

  local a = ps:new()
  a.usernames = {"a", "b", "c" }
  a.pos = 3
  event.key = event.KEY_LEFT
  a:handleinput(event)
  assert_equal(2, a.pos, "did not move left, should have.")
  verify_mock(mc)
end

function test_handleinput_bottom_right()
  -- does not move from bottom when right is pressed
  local mc = create_mock(SUT)
  local inactive = mc:mock()
  local active = mc:mock()
  local ps = require(SUT)
  package.loaded[SUT].inactive = inactive
  package.loaded[SUT].active = active
  inactive(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  active(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  mc:replay()

  local a = ps:new()
  a.usernames = {"a", "b", "c"}
  a.pos = 5
  event.key = event.KEY_RIGHT
  a:handleinput(event)
  assert_equal(5, a.pos, "moved from bottom when right was pressed")
  verify_mock(mc)
end

function test_handleinput_bottom_left()
  -- does not move from bottom when left is pressed
  local mc = create_mock(SUT)
  local inactive = mc:mock()
  local active = mc:mock()
  local ps = require(SUT)
  package.loaded[SUT].inactive = inactive
  package.loaded[SUT].active = active
  inactive(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  active(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  mc:replay()

  local a = ps:new()
  a.usernames = {"a", "b", "c"}
  a.pos = 5
  event.key = event.KEY_LEFT
  a:handleinput(event)
  assert_equal(5, a.pos, "moved from bottom when left was pressed")
  verify_mock(mc)
end

function test_handleinput_bottom_down()
  -- does not move from bottom when down is pressed
  local mc = create_mock(SUT)
  local inactive = mc:mock()
  local active = mc:mock()
  local ps = require(SUT)
  package.loaded[SUT].inactive = inactive
  package.loaded[SUT].active = active
  inactive(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  active(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  mc:replay()

  local a = ps:new()
  a.usernames = {"a", "b", "c"}
  a.pos = 5
  event.key = event.KEY_DOWN
  a:handleinput(event)
  assert_equal(5, a.pos, "moved from bottom when down was pressed")
  verify_mock(mc)
end

function test_handleinput_bottom_up()
  -- moves up from bottom when up is pressed
  local mc = create_mock(SUT)
  local inactive = mc:mock()
  local active = mc:mock()
  local ps = require(SUT)
  package.loaded[SUT].inactive = inactive
  package.loaded[SUT].active = active
  inactive(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  active(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  mc:replay()

  local a = ps:new()
  a.usernames = {"a", "b", "c"}
  a. pos = 5
  event.key = event.KEY_UP
  a:handleinput(event)
  assert_equal(1, a.pos, "did not move up from bottom when up was pressed")
  verify_mock(mc)
end

function test_handleinput_up_up()
  -- nothing should happen when up is pressed and pos is among the upper ones.
  local mc = create_mock(SUT)
  local inactive = mc:mock()
  local active = mc:mock()
  local ps = require(SUT)
  package.loaded[SUT].inactive = inactive
  package.loaded[SUT].active = active
  inactive(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  active(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  mc:replay()

  local a = ps:new()
  a.usernames = {"a", "b", "c"}

  a.pos = 1
  event.key = event.KEY_UP
  a:handleinput(event)
  assert_equal(1, a.pos, "tried to move from pos 1 when it was already up")
  a.pos = 2
  a:handleinput(event)
  assert_equal(2, a.pos, "tried to move from pos 2 when it was already up")
  a.pos = 3
  a:handleinput(event)
  assert_equal(3, a.pos, "tried to move from pos 3 when it was already up")
  verify_mock(mc)
end

function test_handleinput_up_down()
  -- should move down to pos 5 from all upper pos when down is pressed a.pos = 1
  local mc = create_mock(SUT)
  local inactive = mc:mock()
  local active = mc:mock()
  local ps = require(SUT)
  package.loaded[SUT].inactive = inactive
  package.loaded[SUT].active = active
  inactive(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  active(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  mc:replay()

  local a = ps:new()
  a.usernames = {"a", "b", "c"}
  a.pos = 1
  event.key = event.KEY_DOWN
  a:handleinput(event)
  assert_equal(5, a.pos, "should have moved down from pos 1 to pos 5")
  a.pos = 2
  a:handleinput(event)
  assert_equal(5, a.pos, "should have moved down from pos 2 to pos 5")
  a.pos = 3
  a:handleinput(event)
  assert_equal(5, a.pos, "should have moved down from pos 3 to pos 5")
  verify_mock(mc)
end

function test_handleinput_up_one()
  -- tests if the right user is choses when 1 is pressed
  local ps = require(SUT)
  local a = ps:new()
  a.usernames = {"a", "b", "c"}
  a.pos = 1
  event.key = event.KEY_ONE
  local b = a:handleinput(event)
  assert_equal("a", b[2], "should get username a")
  a.pos = 2
  local b = a:handleinput(event)
  assert_equal("b", b[2], "should get username b")
  a.pos = 3
  local b = a:handleinput(event)
  assert_equal("c", b[2], "should get username c")

end

function test_handleinput_down_one()
  -- checks if create is chosen if 1 is pressed
  local ps = require(SUT)
  local a = ps:new()
  a.pos = 5
  event.key = event.KEY_ONE
  local b = a:handleinput(event)
  assert_equal("create", b[1], "should get create")
end

function test_handleinput_any_other_button()
  -- test what happens if any other button is pressed.
  local ps = require(SUT)
  local a = ps:new()
  a.pos = 5
  event.key = '7'
  local b = a:handleinput(event)
  assert_equal(" ", b[1], "should do nothing")
end

function test_printbackground()
  local ps = require(SUT)
  local a = ps:new()
  a:printbackground()
end
