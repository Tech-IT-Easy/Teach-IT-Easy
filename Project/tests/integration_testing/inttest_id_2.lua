--
-- Created by IntelliJ IDEA.
-- User: Andreas Mansson
-- Date: 2015-11-12
-- Time: 12:28
-- To change this template use File | Settings | File Templates.
--

lunit = require "lunit"
module( "inttest_id_2", package.seeall, lunit.testcase )

local SUT_1 = 'games.Progg.Character'
local SUT_2 = 'games.Progg.Position'
local SUT_3 = 'games.Progg.Queue'
local commands=require('games.Progg.Commands')

local function create_queue(inqueue)
    inqueue:push(commands.MOVE, "queue")
    inqueue:push(commands.MOVE, "queue")
    inqueue:push(commands.MOVE, "queue")
    inqueue:push(commands.MOVE, "queue")
    inqueue:push(commands.TURN_RIGHT, "queue")
    inqueue:push(commands.MOVE, "queue")
    inqueue:push(commands.MOVE, "queue")
    inqueue:push(commands.TURN_RIGHT, "queue")
    inqueue:push(commands.MOVE, "queue")
--    inqueue:push(commands.MOVE, "queue")
--    inqueue:push(commands.P1, "queue")
--    inqueue:push(commands.MOVE, "P1")
--    inqueue:push(commands.MOVE, "P1")
--    inqueue:push(commands.TURN_LEFT, "P1")
--    inqueue:push(commands.TURN_RIGHT, "P1")
--    inqueue:push(commands.P2, "queue")
--    inqueue:push(commands.MOVE, "P2")
--    inqueue:push(commands.MOVE, "P2")
--    inqueue:push(commands.TURN_LEFT, "P2")
--    inqueue:push(commands.TURN_RIGHT, "P2")
end

function test_execute_commads()
    local Position = require(SUT_2)
    local character = require(SUT_1):new(Position:new(1,5))
    local myqueue=require(SUT_3):new(nil,nil,{["queue"] = 9, ["loop"] = 11, ["P1"] = 13, ["P2"] = 16 })

    create_queue(myqueue)

    local executionqueue = myqueue:getExecutionQueue()

    local iterationcnt = #executionqueue.actions

    character.executionTimer = sys.new_timer(500, "start")

    for i=1, iterationcnt do
        character:execute(executionqueue.actions[iterationcnt+1-i])
    end

    local x_position = character.position:getX()
    local y_position = character.position:getY()

    lunit.assert_equal(3, x_position, "Not correct x-position")
    lunit.assert_equal(2, y_position, "Not correct y-position")
end

function test_command_queue_bottomMenu()
--    local class_to_mock="games.Progg.BottmMenu"
--    local mc = create_mock(class_to_mock)
--
--    local a = require(SUT_1)
--    local b = require(SUT_2)
--    local c = require(SUT_3)
--
--    local bottommenu = c:new()
--    local queue = a:new(bottommenu)
--    local object1 = b:new()
--
--    queue:push(object1)
--    local Character = require(SUT_1)
--    local Position = require(SUT_2)
--    local char = Character:new(Position:new(1,5))

end


