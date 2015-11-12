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
my_file = require "src.games.Progg.RightMenu"

local SUT = 'src.games.Progg.RightMenu'

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

-- Delete this function when the real test is done
function test_RightMenu_fail()
   fail("RightMenu highlight-functions not tested yet!")
end

function test_getPosition_correctCommand()
  -- command "move" is inputed
  local mc = create_mock(SUT)
  -- Mock inactive and active
  -- Create mock objects for each function to mock

  -- In this case we want to mock 4 member functions so then we import the SUT (System under test)
  local ps = require(SUT)


  -- Tell for which arguments it should work, what it should return and how many times it should be called.

  -- Start the testing
  mc:replay()

  local a = ps:new()
  event = "move"
  assert_equal(1, a:getPosition(event), "should return 1, didn't")

  verify_mock(mc)
end

function test_RightMenu_falseCommand()
  -- command "move" is inputed
  local mc = create_mock(SUT)
  -- Mock inactive and active
  -- Create mock objects for each function to mock

  -- In this case we want to mock 4 member functions so then we import the SUT (System under test)
  local ps = require(SUT)


  -- Tell for which arguments it should work, what it should return and how many times it should be called.

  -- Start the testing
  mc:replay()

  local a = ps:new()
  event = "jump"
  assert_equal(nil, a:getPosition(event), "should return 1, didn't")

  verify_mock(mc)
end

--Need to figure out how to mock screen-methods

--Doesn't work any longer after I made highlight in RightMenu local
--(I addad a. to all highlight here as well)
function test_highlight_correctCommand()
  -- command "move" is inputed
  local mc = create_mock(SUT)
  local ps = require(SUT)
  mc:replay()

  local a = ps:new()
  local event = "move"
  local image_data = love.image.newImageData()
  local var = {}
  var.image_data = image_data
  a.images = { ["move"]=var }

  a:highlight(event)
  assert_equal("move", a.highlight, "should return 'move', didn't")

  verify_mock(mc)
end

function test_removeHighlight_correctCommand()
  -- command "move" is inputed
  local mc = create_mock(SUT)
  local ps = require(SUT)
  mc:replay()

  local a = ps:new()
  local event = "move"
  local image_data = love.image.newImageData()
  local var = {}
  var.image_data = image_data
  a.images = { ["move"] = var }
  a.highlight = "move"
  a:removeHighlight(event)
  assert_equal(nil, a.highlight, "should return nil, didn't")

  verify_mock(mc)
end