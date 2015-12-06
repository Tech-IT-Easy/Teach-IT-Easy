--
-- Created by IntelliJ IDEA.
-- User: Marcus
-- Date: 2015-12-03
-- Time: 13:29
-- To change this template use File | Settings | File Templates.
--

lunit = require "lunit"
module("src_menus_SelectLevel", package.seeall, lunit.testcase)
SelectLevel = require "menus.SelectLevel"

local SUT = 'menus.SelectLevel'

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
    local status, err = pcall(function()
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
    package.loaded['menus.SelectLevel'] = nil
    package.preload['menus.SelectLevel'] = nil
end

function test_loadview()
    local mc = create_mock(SUT)

    local ps = require(SUT)

    local a = ps:new()
    local input = "Namn"
    a.pos = 1
    a.lastpos = 1
    a.username = input
    a.unlockedLevels = 5

    a:renderui(5)

    verify_mock(mc)
end