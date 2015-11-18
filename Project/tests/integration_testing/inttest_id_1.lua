--
-- Created by IntelliJ IDEA.
-- User: Andreas Mansson
-- Date: 2015-11-12
-- Time: 12:28
-- To change this template use File | Settings | File Templates.
--

lunit = require "lunit"
module( "test_command_queue_bottomMenu", package.seeall, lunit.testcase )

local SUT_1 = 'games.Progg.Queue'
local SUT_2 = 'games.Progg.Commands'
local SUT_3 = 'games.Progg.BottomMenu'

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
  package.loaded['games.Progg.Queue'] = nil
  package.preload['games.Progg.Queue'] = nil
end

function test_command_queue_bottomMenu()
    local class_to_mock="games.Progg.BottomMenu"
    local mc = create_mock(class_to_mock)

    local a = require(SUT_1)
    local b = require(SUT_2)
    local c = require(SUT_3)

    local bottommenu = c:new()
    local queue = a:new(bottommenu)
    local object1 = b:new()

    queue:push(object1)
end
