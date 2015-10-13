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
end

function teardown()
  reset_mocks()
end

function test_loadview()
  mock_render_ui()
  a:loadview()
  mc:verify()
end


function test_handleinput()
  -- make things here
  a.usernames = {"a", "b"}
  a.pos = 1
  a:handleinput('right')
  assert_equal(2, a.pos, "shouldn't be 2")

end
function test_printbackground()
  a:printbackground()
end

function test_ProfileSelection_and_fail()
   fail("ProfileSelection not tested, always fail")
end



