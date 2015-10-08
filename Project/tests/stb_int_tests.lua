--
-- Created by IntelliJ IDEA.
-- User: andreas.mansson
-- Date: 15-10-07
-- Time: 18:17
-- To change this template use File | Settings | File Templates.
--
lunit = require "lunit"
module( "Emulator_stb_int_tests", package.seeall, lunit.testcase )

function setup() -- This will be runned for every test.
  local lemock = require 'lemock' -- needed to be able to make a mock
  local mc = lemock.controller() -- same here
  local funct_count = mc:mock() -- function you want imitate.
  package.loaded.love = nil -- need to delete the package where the function is taken from.
  package.preload['love'] = function () -- Create preload. When the program wants to include love. This function will run instead
    local love = {} -- empty table. To make sure it looks the same as in the test program.
    local graphics = {} -- empty table
    love.graphics = graphics -- assignment.
    love.graphics.getHeight = getHeight -- Adds the getHeight function to the table
    return love
  end
  -- If you import a package in a package and just want to mock a part off it, ex love.graphics nad not the whole love, you could unload a part of it using
  -- package.loaded['love.graphics'] = nil
  -- package.preload['love.graphics'] = function () -- Create preload. When the program wants to include love. This function will run instead
  --   local graphics = {} -- empty table. To make sure it looks the same as in the test program.
  --   graphics.getHeight = getHeight -- Adds the getHeight function to the table
  --   return graphics
  -- end

  getHeight(mc.ANYARGS) ;mc :returns(15) :anytimes() -- Tells what should be return. With what Inputs. This particular will return 15. mc.ANYARGS => will do this no matter what input. 15 = will return this. anytimes = How many times.
  mc:close() --
  mc:replay() -- Tells "now we start testing the code"
  package.loaded["my_folder.my_file"] = nil -- want this file.
  _G.love = require "love" -- makes sure we uses the love package created in this file and that it is globaly accesable
my_file = require "Emulator.main"
end

function test_stb_input_null()
    fail("No functions to test!")
end