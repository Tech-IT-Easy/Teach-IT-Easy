--
-- Created by IntelliJ IDEA.
-- User: Dator
-- Date: 2015-11-19
-- Time: 14:45
-- To change this template use File | Settings | File Templates.
--

lunit = require "lunit"
module( "inttest_id_3", package.seeall, lunit.testcase )
local event = require ("toolkit.Event")

local SUT1 = 'games.Progg.Commands'
local SUT2 = 'games.Progg.BuildArea'
local SUT3 = 'games.Progg.Character'
local SUT4 = 'games.Progg.Queue'

--Corresponds to function bottomMenuEventHandler:update(object,eventListener,event)
--in BottomMenu

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


