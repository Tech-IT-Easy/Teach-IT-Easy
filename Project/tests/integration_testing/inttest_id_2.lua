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

function setup()
    clear_mock()
end


local function create_queue(inqueue, type)
    clear_mock()
    package.loaded['games.Progg.Character'] = nil
    package.loaded['games.Progg.Commands'] = nil
    package.loaded['games.Progg.Position'] = nil
    package.loaded['games.Progg.Queue'] = nil
    local commands=require('games.Progg.Commands')
    if(type=="simple")then
        inqueue:push(commands.MOVE, "queue")
        inqueue:push(commands.MOVE, "queue")
        inqueue:push(commands.MOVE, "queue")
        --inqueue:push(commands.MOVE, "queue")
        inqueue:push(commands.TURN_RIGHT, "queue")
        inqueue:push(commands.MOVE, "queue")
        inqueue:push(commands.MOVE, "queue")
        --inqueue:push(commands.TURN_RIGHT, "queue")
        --inqueue:push(commands.MOVE, "queue")
    else
        inqueue:push(commands.LOOP, "queue")
        inqueue.loopCounter[1]=4
        inqueue:push(commands.MOVE, "loop")
        inqueue:push(commands.FIX, "loop")
        inqueue:push(commands.TURN_RIGHT, "queue")
        inqueue:push(commands.P1, "queue")
        inqueue:push(commands.MOVE, "P1")
        inqueue:push(commands.MOVE, "P1")
        inqueue:push(commands.P2, "queue")
        inqueue:push(commands.TURN_RIGHT, "P2")
        inqueue:push(commands.MOVE, "P2")
        inqueue:push(commands.TURN_LEFT, "queue")
        inqueue:push(commands.MOVE, "queue")
        --inqueue:push(commands.MOVE, "queue")
        inqueue:push(commands.TURN_RIGHT, "queue")
        inqueue:push(commands.MOVE, "queue")
    end
end

function test_execute_simple_commads()
    clear_mock()
    package.loaded['games.Progg.Character'] = nil
    package.loaded['games.Progg.Commands'] = nil
    package.loaded['games.Progg.Position'] = nil
    package.loaded['games.Progg.Queue'] = nil
    package.loaded['games.Progg.levels.ProggLevels'] = nil
    package.loaded['toolkit.GameProgress'] = nil
    local commands=require('games.Progg.Commands')
    local levelData = require('games.Progg.levels.ProggLevels'):new()
    local leveldata = levelData:getProggLevels()
    local GameProgress = require('toolkit.GameProgress')

    local context_sim = {}
    context_sim.profile={}
    context_sim.profile.images={}
    context_sim.profile.images.UP='data/avatar/cute_robot/UP.png'
    context_sim.profile.images.DOWN='data/avatar/cute_robot/UP.png'
    context_sim.profile.images.RIGHT='data/avatar/cute_robot/UP.png'
    context_sim.profile.images.LEFT='data/avatar/cute_robot/UP.png'
    context_sim.profile.gameprogress = GameProgress:new("test_avatar")

    local character = require(SUT_1):new(1,3,nil,leveldata[1],context_sim)
    local myqueue=require(SUT_3):new(nil,nil,{["queue"] = 9, ["loop"] = 11, ["P1"] = 13, ["P2"] = 16 })

    create_queue(myqueue, "simple")

    local executionqueue = myqueue:getExecutionQueue()

    local iterationcnt = #executionqueue.actions

    print("Start timer")

    for i=1, iterationcnt do
        character:execute(executionqueue.actions[iterationcnt+1-i])
    end

    local x_position = character.position.x
    local y_position = character.position.y

    lunit.assert_equal(1, x_position, "Not correct x-position")
    lunit.assert_equal(4, y_position, "Not correct y-position")
end

function test_start_executing_commands()
    clear_mock()
    package.loaded['games.Progg.Character'] = nil
    package.loaded['games.Progg.Commands'] = nil
    package.loaded['games.Progg.Position'] = nil
    package.loaded['games.Progg.Queue'] = nil
    package.loaded['games.Progg.levels.ProggLevels'] = nil
    package.loaded['toolkit.GameProgress'] = nil
    package.loaded["games.Progg.RightMenu"] = nil
    local RightMenu = require("games.Progg.RightMenu")
    local rightMenu = RightMenu:new()
    local levelData = require('games.Progg.levels.ProggLevels'):new()
    local leveldata = levelData:getProggLevels()
    local GameProgress = require('toolkit.GameProgress')

    local context_sim = {}
    context_sim.profile={}
    context_sim.profile.images={}
    context_sim.profile.images.UP='data/avatar/cute_robot/UP.png'
    context_sim.profile.images.DOWN='data/avatar/cute_robot/UP.png'
    context_sim.profile.images.RIGHT='data/avatar/cute_robot/UP.png'
    context_sim.profile.images.LEFT='data/avatar/cute_robot/UP.png'
    context_sim.profile.gameprogress = GameProgress:new("test_avatar")

    leveldata[4].mapData = "9acfffff5f3cffff5ff7ffff5fffffff7fffffff"


    local character = require(SUT_1):new(1,5, rightMenu, leveldata[4],context_sim)
    local myqueue=require(SUT_3):new(nil,nil,{["queue"] = 16, ["loop"] = 11, ["P1"] = 13, ["P2"] = 16 })

    create_queue(myqueue, "complex")

    print("Start timer")

    character:startExecution(myqueue)

    --simulates the timer without delay
    while(0<#character.queue.actions or character.onP1 or character.onP2 or character.onLoop) do
        print("STUCK IN LOOP")
        start()
    end

    --Must run one more time, to get path coverage in end of execution
    --start()

    local is_at_goal = character.hasWon

    lunit.assert_true(is_at_goal, "Has not moved to right position")
end

--function test_command_queue_bottomMenu()
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

--end


