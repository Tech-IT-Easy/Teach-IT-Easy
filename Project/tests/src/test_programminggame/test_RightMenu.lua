--
-- Created by IntelliJ IDEA.
-- User: Lena
-- Date: 2015-11-05
-- Time: 13:35
-- To change this template use File | Settings | File Templates.
--

-- To Test: getPosition,

lunit = require "lunit"
module( "test_RightMenu", package.seeall, lunit.testcase )
my_file = require "games.Progg.RightMenu"

local SUT = 'games.Progg.RightMenu'

local function create_mock(class_to_mock)
  -- unload the package if loaded to dismiss previous mocks
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

function teardown()
  package.loaded[SUT] = nil
  package.preload[SUT] = nil
end

-- Delete this function when the real test is done
--[[function test_RightMenu_fail()
  fail("RightMenu highlight-functions not tested yet!")
end]]

--Need to figure out how to mock screen-methods

--Doesn't work any longer after I made highlight in RightMenu local
--(I addad a. to all highlight here as well)
function test_highlight_correctCommand()
  local class_to_mock = "games.Progg.DrawRightMenu"

  local mc = create_mock(class_to_mock)
  local drawHighlight = mc:mock()
  local ps=require(class_to_mock)
  package.loaded[class_to_mock].drawHighlight = drawHighlight
  drawHighlight(mc.ANYARGS) ;mc :returns(nil) :anytimes()

  mc:replay()

  local ps1 = require(SUT)
  local a = ps1:new()
  local event = "move"
  a.currentHighlight = nil
  a:highlight(event)
  assert_equal("move", a.currentHighlight, "should return 'move', didn't")
  verify_mock(mc)
end

function test_highlight_correctCommand_highlightActive()
  local class_to_mock = "games.Progg.DrawRightMenu"

  local mc = create_mock(class_to_mock)
  local drawHighlight = mc:mock()
  local ps=require(class_to_mock)
  package.loaded[class_to_mock].drawHighlight = drawHighlight
  drawHighlight(mc.ANYARGS) ;mc :returns(nil) :anytimes()

  local mc2 = create_mock(SUT)
  local removeHighlight = mc2:mock()
  local ps2=require(SUT)
  package.loaded[SUT].removeHighlight = removeHighlight
  removeHighlight(mc2.ANYARGS) ;mc2 :returns(nil) :anytimes()

  mc2:replay()
  mc:replay()

  local a = ps2:new()
  local event = "move"
  a.currentHighlight = "loop"
  a:highlight(event)
  assert_equal("move", a.currentHighlight, "should return 'move', didn't")
  verify_mock(mc)
end

function test_removeHighlight_correctCommand()
  local class_to_mock = "games.Progg.DrawRightMenu"

  local mc = create_mock(class_to_mock)
  local drawHighlight = mc:mock()
  local ps=require(class_to_mock)
  package.loaded[class_to_mock].drawHighlight = drawHighlight
  drawHighlight(mc.ANYARGS) ;mc :returns(nil) :anytimes()

  mc:replay()

  local ps1 = require(SUT)
  local a = ps1:new()
  a.currentHighlight = "loop"
  local event = "loop"
  a:removeHighlight(event)
  assert_equal(nil, a.currentHighlight, "should return nil, didn't")
  verify_mock(mc)
end