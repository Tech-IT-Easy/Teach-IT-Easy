--
-- Created by IntelliJ IDEA.
-- User: Andreas Mansson
-- Date: 2015-11-12
-- Time: 12:28
-- To change this template use File | Settings | File Templates.
--

lunit = require "lunit"
module( "inttest_id_1", package.seeall, lunit.testcase )

local SUT_1 = 'games.Progg.Queue'
local SUT_2 = 'games.Progg.Commands'

--local function create_mock(class_to_mock)
--  -- unload the package if loaded to dissmiss previous mocks
--  package.loaded[class_to_mock] = nil
--  package.preload[class_to_mock] = nil
--  -- import lemock
--  local lemock = require 'lemock'
--  -- initiate mock controller
--  local mc = lemock.controller()
--  return mc
--end
--
--local function verify_mock(mc)
--  local status, err = pcall(function ()
--    -- Verify that the mocks has been called as stated.
--    mc:verify()
--  end)
--  if err then -- if error fail the test.
--    fail(err)
--  end
--end
--
--function setup()
--
--end
--
--function teardown()
--  package.loaded['games.Progg.Queue'] = nil
--  package.preload['games.Progg.Queue'] = nil
--end

function setup()
    clear_mock()
end

function test_command_queue()
    local a = require(SUT_1)
    local b = require(SUT_2)

    local queue = a:new(nil, nil, {["queue"] = 16, ["loop"] = 11, ["P1"] = 13, ["P2"] = 16 })
    local commands = b:new()

--    local command1=commands.MOVE
--    local queue_cmd1 = commands:new(command1)
--
--    local command2=commands.MOVE
--    local queue_cmd2 = commands:new(command2)
--
--    local command3=commands.TURN_LEFT
--    local queue_cmd3 = commands:new(command3)
--
--    local command4=commands.TURN_RIGHT
--    local queue_cmd4 = commands:new(command4)
--
--    local command5=commands.LOOP
--    local queue_cmd5 = commands:new(command5)
--
--    local command5=commands.LOOP
--    local queue_cmd5 = commands:new(command5)

    --local addedcommands={}

    queue:push(commands.MOVE, "queue")
    lunit.assert_equal(commands.MOVE, queue.actions[1], "Did not get the right value from the queue")

    queue:push(commands.MOVE, "queue")
    lunit.assert_equal(commands.MOVE, queue.actions[2], "Did not get the right value from the queue")

    queue:push(commands.TURN_LEFT, "queue")
    lunit.assert_equal(commands.TURN_LEFT, queue.actions[3], "Did not get the right value from the queue")

    queue:push(commands.TURN_RIGHT, "queue")
    lunit.assert_equal(commands.TURN_RIGHT, queue.actions[4], "Did not get the right value from the queue")

    queue:push(commands.LOOP, "queue")
    lunit.assert_equal(commands.LOOP, queue.actions[5], "Did not get the right value from the queue")

    queue:push(commands.MOVE, "loop")
    lunit.assert_equal(commands.MOVE, queue.loopActions[1][1], "Did not get the right value from the queue")

    queue:push(commands.MOVE, "loop")
    lunit.assert_equal(commands.MOVE, queue.loopActions[1][2], "Did not get the right value from the queue")

    queue:push(commands.TURN_LEFT, "loop")
    lunit.assert_equal(commands.TURN_LEFT, queue.loopActions[1][3], "Did not get the right value from the queue")

    queue:push(commands.TURN_RIGHT, "loop")
    lunit.assert_equal(commands.TURN_RIGHT, queue.loopActions[1][4], "Did not get the right value from the queue")

    queue:push(commands.MOVE, "queue")
    lunit.assert_equal(commands.MOVE, queue.actions[6], "Did not get the right value from the queue")

    queue:push(commands.P1, "queue")
    lunit.assert_equal(commands.P1, queue.actions[7], "Did not get the right value from the queue")

    queue:push(commands.MOVE, "P1")
    lunit.assert_equal(commands.MOVE, queue.p1Actions[1], "Did not get the right value from the queue")

    queue:push(commands.MOVE, "P1")
    lunit.assert_equal(commands.MOVE, queue.p1Actions[2], "Did not get the right value from the queue")

    queue:push(commands.TURN_LEFT, "P1")
    lunit.assert_equal(commands.TURN_LEFT, queue.p1Actions[3], "Did not get the right value from the queue")

    queue:push(commands.TURN_RIGHT, "P1")
    lunit.assert_equal(commands.TURN_RIGHT, queue.p1Actions[4], "Did not get the right value from the queue")

    queue:push(commands.P2, "queue")
    lunit.assert_equal(commands.P1, queue.actions[7], "Did not get the right value from the queue")

    queue:push(commands.MOVE, "P2")
    lunit.assert_equal(commands.MOVE, queue.p2Actions[1], "Did not get the right value from the queue")

    queue:push(commands.MOVE, "P2")
    lunit.assert_equal(commands.MOVE, queue.p2Actions[2], "Did not get the right value from the queue")

    queue:push(commands.TURN_LEFT, "P2")
    lunit.assert_equal(commands.TURN_LEFT, queue.p2Actions[3], "Did not get the right value from the queue")

    queue:push(commands.TURN_RIGHT, "P2")
    lunit.assert_equal(commands.TURN_RIGHT, queue.p2Actions[4], "Did not get the right value from the queue")

end
