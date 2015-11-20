--
-- Created by IntelliJ IDEA.
-- User: Dator
-- Date: 2015-11-19
-- Time: 14:45
-- To change this template use File | Settings | File Templates.
--

lunit = require "lunit"
module( "inttest_id_7", package.seeall, lunit.testcase )
local event = require ("toolkit.Event")

local SUT = 'menus.Games'


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

function test_start_progg_game()
    local PlatformContext= require("platform.PlatformContext")
    platformContext = PlatformContext:new()
    local test = require(SUT)
    local it_games = test:new()
    print(platformContext)
    event.key = event.KEY_OK
    local b=it_games:handleinput(event)
end


