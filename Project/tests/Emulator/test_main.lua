--
-- Created by
-- User: Tobias Lundell
-- Date: 15-10-08
-- Time: 12:16
--
lunit = require "lunit"
module( "Emulator_main_test", package.seeall, lunit.testcase )


main = require "main" -- import the main file

function mock_render_ui()

  local lemock = require 'lemock' -- import lemock, needed to be able to make a mock
  mc = lemock.controller() -- create a mock controller, also needed
  local renderUI = mc:mock() -- function you want imitate.
  main.renderUI = renderUI -- In this case we only want to mock one function renderUI in main
  renderUI(mc.ANYARGS) ;mc :returns(nil) :anytimes() -- Tells what input the function should take and what should be
  -- return. In this case: for any input arguments return nil.
  -- mc.ANYARGS => will do this no matter what input.
  -- nil => will return this.
  -- anytimes() => How many times. in this case all times
  mc:replay() -- Tells "now we start testing the code"
end

function reset_mocks()
  mc:verify() -- makes sure you have run enought times if time is set instead of anytimes()
  package.loaded['main'] = nil -- Remove the imported package.
  package.preload['main'] = nil -- Removes the mock package.
  main = require "main" -- import main agian
end

function setup()

end

function teardown()
  reset_mocks()
end

