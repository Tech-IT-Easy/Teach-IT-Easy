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

local function create_queue(inqueue)
    inqueue:push(commands.MOVE, "queue")
    inqueue:push(commands.MOVE, "queue")
    inqueue:push(commands.TURN_LEFT, "queue")
    inqueue:push(commands.TURN_RIGHT, "queue")
    inqueue:push(commands.LOOP, "queue")
    inqueue:push(commands.MOVE, "loop")
    inqueue:push(commands.MOVE, "loop")
    inqueue:push(commands.TURN_LEFT, "loop")
    inqueue:push(commands.TURN_RIGHT, "loop")
    inqueue:push(commands.MOVE, "queue")
    inqueue:push(commands.P1, "queue")
    inqueue:push(commands.MOVE, "P1")
    inqueue:push(commands.MOVE, "P1")
    inqueue:push(commands.TURN_LEFT, "P1")
    inqueue:push(commands.TURN_RIGHT, "P1")
    inqueue:push(commands.P2, "queue")
    inqueue:push(commands.MOVE, "P2")
    inqueue:push(commands.MOVE, "P2")
    inqueue:push(commands.TURN_LEFT, "P2")
    inqueue:push(commands.TURN_RIGHT, "P2")
end

function test_execute_commads()
    local myqueue=require(SUT_3):new(nil,nil,{["queue"] = 16, ["loop"] = 11, ["P1"] = 13, ["P2"] = 16 })
    create_queue(myqueue)

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
    local Character = require(SUT_1)
    local Position = require(SUT_2)
    local char = Character:new(Position:new(1,5))

end


