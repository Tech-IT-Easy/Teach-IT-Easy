--
-- Created by IntelliJ IDEA.
-- User: Andreas Mansson
-- Date: 2015-11-05
-- Time: 11:36
-- To change this template use File | Settings | File Templates.
--

lunit = require "lunit"
module("src_games_Progg_Map", package.seeall, lunit.testcase)
--Map = require "games.Progg.Map"

local SUT = 'games.Progg.Map'

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



function teardown()
    package.loaded['games.Progg.Map'] = nil
    package.preload['games.Progg.Map'] = nil
end

function setup()
    clear_mock()
    Map = require "games.Progg.Map"
end

-------------------------------------
-- Tests the load function in the map class.
-- @system_under_test : Map:new(), Map:load()
-- @author name: Marcus
-------------------------------------
function test_load()
    local mc = create_mock(SUT)

    -- Mock renderui and printbackground
    local square = mc:mock()
    local setGoal = mc:mock()
    local setStart = mc:mock()
    local setCharacter = mc:mock()
    local printObjective = mc:mock()
    --local printbackground = mc:mock()

    local ps = require(SUT)


    package.loaded[SUT].square = square
    package.loaded[SUT].setGoal = setGoal
    package.loaded[SUT].setStart = setStart
    package.loaded[SUT].setCharacter = setCharacter
    package.loaded[SUT].printObjective = printObjective
    -- package.loaded[SUT].printbackground = printbackground

    square(mc.ANYARGS); mc:returns(nil):times(40)
    setGoal(mc.ANYARGS); mc:returns(nil):times(1)
    setStart(mc.ANYARGS); mc:returns(nil):times(1)
    setCharacter(mc.ANYARGS); mc:returns(nil):times(1)
    printObjective(mc.ANYARGS); mc:returns(nil):times(1)
    --printbackground(mc.ANYARGS) ;mc :returns(nil) :times(1)

    mc:replay()

    local b = ps:new()

    b.objectives = { 1, 1 }
    b:load({ objectives = "s", mapData = "a", level=1 })

    verify_mock(mc)
end

-------------------------------------
-- Set character test. Testing all possible paths.
-- @system_under_test : Map:new(), Map:setCharacter()
-- @author name: Marcus
-------------------------------------
function test_setCharacter_one()
    local mc = create_mock(SUT)
    local ps = require(SUT)
    local ps2 = require("platform.PlatformContext")
    local ps3 = require("platform.Profile")
 --local ps2 = require("platform.Profile")
    _G.profiles = {}
    table.insert(profiles, ps3:new("Knatte", 'data/avatar/cute_robot/DOWN.png', "/cute_robot/"))
    table.insert(profiles, ps3:new("Fnatte", 'data/avatar/insect_robot/DOWN.png', "/insect_robot/"))
    table.insert(profiles, ps3:new("Tjatte", 'data/avatar/strong_robot/DOWN.png', "/strong_robot/"))

    mc:replay()

    local a = ps:new()
    local input = 8
    local context = ps2:new()
    --table.insert(profiles, ps3:new("Knatte", 'data/avatar/cute_robot/DOWN.png', "/cute_robot/"))

    context.profile = profiles[1]
    a.context = context

    a.columns = 8
    a.boxheight = 50
    a.startx = 200
    a.starty = 200
    a.boxpadding = 20
    a.innerboxheight = 40
    a.tiles = { 0, 0, 0, 0, 0, 0, 0 }
    a:setCharacter(input, 0)

    verify_mock(mc)
    _G.profiles=nil
end

function test_setCharacter_two()
    local mc = create_mock(SUT)
    local ps = require(SUT)
    local ps2 = require("platform.PlatformContext")

     local ps3 = require("platform.Profile")
    _G.profiles = {}
    table.insert(profiles, ps3:new("Knatte", 'data/avatar/cute_robot/DOWN.png', "/cute_robot/"))
    table.insert(profiles, ps3:new("Fnatte", 'data/avatar/insect_robot/DOWN.png', "/insect_robot/"))
    table.insert(profiles, ps3:new("Tjatte", 'data/avatar/strong_robot/DOWN.png', "/strong_robot/"))

    mc:replay()
    local a = ps:new()
    --local ps3 = require("platform.Profile")
    local context = ps2:new()
    --table.insert(profiles, ps3:new("Knatte", 'data/avatar/cute_robot/DOWN.png', "/cute_robot/"))
    context.profile = profiles[1]
    a.context = context


    local input = 16
    a.columns = 8
    a.boxheight = 50
    a.startx = 200
    a.starty = 200
    a.boxpadding = 20
    a.innerboxheight = 40
    a.tiles = { 0, 0, 0, 0, 0, 0, 0 }
    a:setCharacter(input,0)

    verify_mock(mc)
    _G.profiles=nil
end

function test_setCharacter_three()
    local mc = create_mock(SUT)
    local ps = require(SUT)
    local ps2 = require("platform.PlatformContext")

     local ps3 = require("platform.Profile")
    _G.profiles = {}
    table.insert(profiles, ps3:new("Knatte", 'data/avatar/cute_robot/DOWN.png', "/cute_robot/"))
    table.insert(profiles, ps3:new("Fnatte", 'data/avatar/insect_robot/DOWN.png', "/insect_robot/"))
    table.insert(profiles, ps3:new("Tjatte", 'data/avatar/strong_robot/DOWN.png', "/strong_robot/"))

    mc:replay()
    local a = ps:new()
    --local ps3 = require("platform.Profile")
    local context = ps2:new()
    --table.insert(profiles, ps3:new("Knatte", 'data/avatar/cute_robot/DOWN.png', "/cute_robot/"))
    context.profile = profiles[1]
    a.context = context



    local input = 24
    a.columns = 8
    a.boxheight = 50
    a.startx = 200
    a.starty = 200
    a.boxpadding = 20
    a.innerboxheight = 40
    a.tiles = { 0, 0, 0, 0, 0, 0, 0 }
    a:setCharacter(input,0)

    verify_mock(mc)
    _G.profiles=nil
end

function test_setCharacter_four()
    local mc = create_mock(SUT)
    local ps = require(SUT)
    local ps2 = require("platform.PlatformContext")

    mc:replay()
    local a = ps:new()
    local ps3 = require("platform.Profile")

     --local ps2 = require("platform.Profile")
    _G.profiles = {}
    table.insert(profiles, ps3:new("Knatte", 'data/avatar/cute_robot/DOWN.png', "/cute_robot/"))
    table.insert(profiles, ps3:new("Fnatte", 'data/avatar/insect_robot/DOWN.png', "/insect_robot/"))
    table.insert(profiles, ps3:new("Tjatte", 'data/avatar/strong_robot/DOWN.png', "/strong_robot/"))

    local context = ps2:new()
    --table.insert(profiles, ps3:new("Knatte", 'data/avatar/cute_robot/DOWN.png', "/cute_robot/"))
    context.profile = profiles[1]
    a.context = context



    local input = 32
    a.columns = 8
    a.boxheight = 50
    a.startx = 200
    a.starty = 200
    a.boxpadding = 20
    a.innerboxheight = 40
    a.tiles = { 0, 0, 0, 0, 0, 0, 0 }
    a:setCharacter(input,0)

    verify_mock(mc)
    _G.profiles=nil
end

function test_setCharacter_five()
    local mc = create_mock(SUT)
    local ps = require(SUT)
    local ps2 = require("platform.PlatformContext")

    mc:replay()
    local a = ps:new()
    local ps3 = require("platform.Profile")
     --local ps2 = require("platform.Profile")
    _G.profiles = {}
    table.insert(profiles, ps3:new("Knatte", 'data/avatar/cute_robot/DOWN.png', "/cute_robot/"))
    table.insert(profiles, ps3:new("Fnatte", 'data/avatar/insect_robot/DOWN.png', "/insect_robot/"))
    table.insert(profiles, ps3:new("Tjatte", 'data/avatar/strong_robot/DOWN.png', "/strong_robot/"))

    local context = ps2:new()
    --table.insert(profiles, ps3:new("Knatte", 'data/avatar/cute_robot/DOWN.png', "/cute_robot/"))
    context.profile = profiles[1]
    a.context = context



    local input = 33
    a.columns = 8
    a.boxheight = 50
    a.startx = 200
    a.starty = 200
    a.boxpadding = 20
    a.innerboxheight = 40
    a.tiles = { 0, 0, 0, 0, 0, 0, 0 }
    a:setCharacter(input,0)

    verify_mock(mc)
    _G.profiles=nil
end

-------------------------------------
-- Set goal test. Tests all possible paths.
-- @system_under_test : Map:new(), Map:setGoal(i)
-- @author name: Marcus
-------------------------------------
function test_setGoal_one()
    local mc = create_mock(SUT)
    local ps = require(SUT)
    mc:replay()

    local a = ps:new()
    local input = 8
    a.columns = 8
    a.boxheight = 50
    a.startx = 200
    a.starty = 200
    a.boxpadding = 20
    a.innerboxheight = 40
    a:setGoal(input)

    verify_mock(mc)
end

function test_setGoal_two()
    local mc = create_mock(SUT)
    local ps = require(SUT)
    mc:replay()

    local a = ps:new()
    local input = 16
    a.columns = 8
    a.boxheight = 50
    a.startx = 200
    a.starty = 200
    a.boxpadding = 20
    a.innerboxheight = 40
    a:setGoal(input)

    verify_mock(mc)
end

function test_setGoal_three()
    local mc = create_mock(SUT)
    local ps = require(SUT)
    mc:replay()

    local a = ps:new()
    local input = 24
    a.columns = 8
    a.boxheight = 50
    a.startx = 200
    a.starty = 200
    a.boxpadding = 20
    a.innerboxheight = 40
    a:setGoal(input)

    verify_mock(mc)
end

function test_setGoal_four()
    local mc = create_mock(SUT)
    local ps = require(SUT)
    mc:replay()

    local a = ps:new()
    local input = 32
    a.columns = 8
    a.boxheight = 50
    a.startx = 200
    a.starty = 200
    a.boxpadding = 20
    a.innerboxheight = 40
    a:setGoal(input)

    verify_mock(mc)
end

function test_setGoal_five()
    local mc = create_mock(SUT)
    local ps = require(SUT)
    mc:replay()

    local a = ps:new()
    local input = 33
    a.columns = 8
    a.boxheight = 50
    a.startx = 200
    a.starty = 200
    a.boxpadding = 20
    a.innerboxheight = 40
    a:setGoal(input)

    verify_mock(mc)
end

-------------------------------------
-- Set start test. Tests all possible paths.
-- @system_under_test : Map:new(), Map:setStart(i)
-- @author name: Marcus
-------------------------------------
function test_setStart_one()
    local mc = create_mock(SUT)
    local ps = require(SUT)
    mc:replay()

    local a = ps:new()
    local input = 8
    a.columns = 8
    a.boxheight = 50
    a.startx = 200
    a.starty = 200
    a.boxpadding = 20
    a.innerboxheight = 40
    a:setStart(input)

    verify_mock(mc)
end

function test_setStart_two()
    local mc = create_mock(SUT)
    local ps = require(SUT)
    mc:replay()

    local a = ps:new()
    local input = 16
    a.columns = 8
    a.boxheight = 50
    a.startx = 200
    a.starty = 200
    a.boxpadding = 20
    a.innerboxheight = 40
    a:setStart(input)

    verify_mock(mc)
end

function test_setStart_three()
    local mc = create_mock(SUT)
    local ps = require(SUT)
    mc:replay()

    local a = ps:new()
    local input = 24
    a.columns = 8
    a.boxheight = 50
    a.startx = 200
    a.starty = 200
    a.boxpadding = 20
    a.innerboxheight = 40
    a:setStart(input)

    verify_mock(mc)
end

function test_setStart_four()
    local mc = create_mock(SUT)
    local ps = require(SUT)
    mc:replay()

    local a = ps:new()
    local input = 32
    a.columns = 8
    a.boxheight = 50
    a.startx = 200
    a.starty = 200
    a.boxpadding = 20
    a.innerboxheight = 40
    a:setStart(input)

    verify_mock(mc)
end

function test_setStart_five()
    local mc = create_mock(SUT)
    local ps = require(SUT)
    mc:replay()

    local a = ps:new()
    local input = 33
    a.columns = 8
    a.boxheight = 50
    a.startx = 200
    a.starty = 200
    a.boxpadding = 20
    a.innerboxheight = 40
    a:setStart(input)

    verify_mock(mc)
end

-------------------------------------
-- Square test. Tests all possible paths.
-- @system_under_test : Map:new(), Map:square(i, tile)
-- @author name: Marcus
-------------------------------------
function test_square_one()
    local mc = create_mock(SUT)
    local ps = require(SUT)

    local drawBox = mc:mock()
    package.loaded[SUT].drawBox = drawBox

    local a = ps:new()
    local type = 1
    local input = 8
    a.columns = 8
    a.startx = 200
    a.starty = 200
    a.boxheight = 50

    drawBox(mc.ANYARGS); mc:returns(nil):times(1)
    mc:replay()

    a:square(input, type)

    verify_mock(mc)
end

function test_square_two()
    local mc = create_mock(SUT)
    local ps = require(SUT)

    local drawBox = mc:mock()
    package.loaded[SUT].drawBox = drawBox

    local a = ps:new()
    local type = 1
    local input = 16
    a.columns = 8
    a.startx = 200
    a.starty = 200
    a.boxheight = 50

    drawBox(mc.ANYARGS); mc:returns(nil):times(1)
    mc:replay()

    a:square(input, type)

    verify_mock(mc)
end

function test_square_three()
    local mc = create_mock(SUT)
    local ps = require(SUT)

    local drawBox = mc:mock()
    package.loaded[SUT].drawBox = drawBox

    local a = ps:new()
    local type = 1
    local input = 24
    a.columns = 8
    a.startx = 200
    a.starty = 200
    a.boxheight = 50

    drawBox(mc.ANYARGS); mc:returns(nil):times(1)
    mc:replay()

    a:square(input, type)

    verify_mock(mc)
end

function test_square_four()
    local mc = create_mock(SUT)
    local ps = require(SUT)

    local drawBox = mc:mock()
    package.loaded[SUT].drawBox = drawBox

    local a = ps:new()
    local type = 1
    local input = 32
    a.columns = 8
    a.startx = 200
    a.starty = 200
    a.boxheight = 50

    drawBox(mc.ANYARGS); mc:returns(nil):times(1)
    mc:replay()

    a:square(input, type)

    verify_mock(mc)
end

function test_square_five()
    local mc = create_mock(SUT)
    local ps = require(SUT)

    local drawBox = mc:mock()
    package.loaded[SUT].drawBox = drawBox

    local a = ps:new()
    local type = 1
    local input = 33
    a.columns = 8
    a.startx = 200
    a.starty = 200
    a.boxheight = 50

    drawBox(mc.ANYARGS); mc:returns(nil):times(1)
    mc:replay()

    a:square(input, type)

    verify_mock(mc)
end

-------------------------------------
-- drawBox tests. Tests all possible paths.
-- @system_under_test : Map:new(), Map:drawBox(tile, xPos, yPos)
-- @author name: Marcus
-------------------------------------
function test_drawBox_one()
    local mc = create_mock(SUT)
    local ps = require(SUT)

    local drawStandardBox = mc:mock()

    package.loaded[SUT].drawStandardBox = drawStandardBox

    local ps2 = require("games.Progg.Tile")
    local a = ps:new()
    local tile = ps2:new("0")
    local xPos = 200
    local yPos = 200

    drawStandardBox(mc.ANYARGS); mc:returns(nil):anytimes()
    mc:replay()

    a:drawBox(tile, xPos, yPos)

    verify_mock(mc)
end

function test_drawBox_two()
    local mc = create_mock(SUT)
    local ps = require(SUT)

    local drawStandardBox = mc:mock()
    local drawBottomBorder = mc:mock()
    package.loaded[SUT].drawStandardBox = drawStandardBox
    package.loaded[SUT].drawBottomBorder = drawBottomBorder

    local ps2 = require("games.Progg.Tile")
    local a = ps:new()
    local tile = ps2:new("2")
    local xPos = 200
    local yPos = 200

    drawStandardBox(mc.ANYARGS); mc:returns(nil):anytimes()
    drawBottomBorder(mc.ANYARGS); mc:returns(nil):anytimes()
    mc:replay()

    a:drawBox(tile, xPos, yPos)

    verify_mock(mc)
end

function test_drawBox_three()
    local mc = create_mock(SUT)
    local ps = require(SUT)

    local drawStandardBox = mc:mock()
    local drawRightBorder = mc:mock()

    package.loaded[SUT].drawStandardBox = drawStandardBox
    package.loaded[SUT].drawRightBorder = drawRightBorder

    local ps2 = require("games.Progg.Tile")
    local a = ps:new()
    local tile = ps2:new("4")
    local xPos = 200
    local yPos = 200

    drawStandardBox(mc.ANYARGS); mc:returns(nil):anytimes()
    drawRightBorder(mc.ANYARGS); mc:returns(nil):anytimes()
    mc:replay()

    a:drawBox(tile, xPos, yPos)

    verify_mock(mc)
end

function test_drawBox_four()
    local mc = create_mock(SUT)
    local ps = require(SUT)

    local drawStandardBox = mc:mock()
    local drawTopBorder = mc:mock()

    package.loaded[SUT].drawStandardBox = drawStandardBox
    package.loaded[SUT].drawTopBorder = drawTopBorder

    local ps2 = require("games.Progg.Tile")
    local a = ps:new()
    local tile = ps2:new("8")
    local xPos = 200
    local yPos = 200

    drawStandardBox(mc.ANYARGS); mc:returns(nil):anytimes()
    drawTopBorder(mc.ANYARGS); mc:returns(nil):anytimes()
    mc:replay()

    a:drawBox(tile, xPos, yPos)

    verify_mock(mc)
end

function test_drawBox_five()
    local mc = create_mock(SUT)
    local ps = require(SUT)

    local drawStandardBox = mc:mock()
    local drawLeftBorder = mc:mock()

    package.loaded[SUT].drawStandardBox = drawStandardBox
    package.loaded[SUT].drawLeftBorder = drawLeftBorder

    local ps2 = require("games.Progg.Tile")
    local a = ps:new()
    local tile = ps2:new("1")
    local xPos = 200
    local yPos = 200

    drawStandardBox(mc.ANYARGS); mc:returns(nil):anytimes()
    drawLeftBorder(mc.ANYARGS); mc:returns(nil):anytimes()
    mc:replay()

    a:drawBox(tile, xPos, yPos)

    verify_mock(mc)
end

-------------------------------------
-- Tests drawStandardBox.
-- @system_under_test : Map:new(), Map:drawStandardBox(xPos, yPos)
-- @author name: Marcus
-------------------------------------
function test_drawStandardBox()
    local mc = create_mock(SUT)
    local ps = require(SUT)

    local a = ps:new()
    local xPos = 200
    local yPos = 200;
    a.xPos = 200
    a.yPos = 200
    a.boxheight = 50;
    a.boxpadding = 20;
    a.innerboxheight = 40;
    mc:replay()

    a:drawStandardBox(xPos, yPos)

    verify_mock(mc)
end

-------------------------------------
-- Tests drawTopBorder.
-- @system_under_test : Map:new(), Map:drawTopBorder(xPos, yPos)
-- @author name: Marcus
-------------------------------------
function test_drawTopBorder()
    local mc = create_mock(SUT)
    local ps = require(SUT)

    local a = ps:new()
    local xPos = 200
    local yPos = 200;
    a.xPos = 200
    a.yPos = 200
    a.boxheight = 50;
    a.borderthickness = 10;
    mc:replay()

    a:drawTopBorder(xPos, yPos)

    verify_mock(mc)
end

-------------------------------------
-- Tests drawBottomBorder
-- @system_under_test : Map:new(), Map:drawBottomBorder(xPos, yPos)
-- @author name: Marcus
-------------------------------------
function test_drawBottomBorder()
    local mc = create_mock(SUT)
    local ps = require(SUT)

    local a = ps:new()
    local xPos = 200
    local yPos = 200;
    a.xPos = 200
    a.yPos = 200
    a.boxheight = 50;
    a.borderthickness = 10;
    mc:replay()

    a:drawBottomBorder(xPos, yPos)

    verify_mock(mc)
end

-------------------------------------
-- Tests drawLeftBorder
-- @system_under_test : Map:new(), Map:drawLeftBorder(xPos, yPos)
-- @author name: Marcus
-------------------------------------
function test_drawLeftBorder()
    local mc = create_mock(SUT)
    local ps = require(SUT)

    local a = ps:new()
    local xPos = 200
    local yPos = 200;
    a.xPos = 200
    a.yPos = 200
    a.boxheight = 50;
    a.borderthickness = 10;
    mc:replay()

    a:drawLeftBorder(xPos, yPos)

    verify_mock(mc)
end

-------------------------------------
-- Tests drawRightBorder.
-- @system_under_test : Map:new(), Map:drawRightBorder(xPos, yPos)
-- @author name: Marcus
-------------------------------------
function test_drawRightBorder()
    local mc = create_mock(SUT)
    local ps = require(SUT)

    local a = ps:new()
    local xPos = 200
    local yPos = 200;
    a.xPos = 200
    a.yPos = 200
    a.boxheight = 50;
    a.borderthickness = 10;
    mc:replay()

    a:drawRightBorder(xPos, yPos)

    verify_mock(mc)
end

-------------------------------------
-- Test the returned value of getPosition.
-- @system_under_test : Map:new(), Map:getPosition(x,y)
-- @author name: Erik
-------------------------------------
function test_getPosition_one()
    local mc = create_mock(SUT)
    local ps = require(SUT)
    mc:replay()

    local a = ps:new()
    a.columns = 8

    local x = 1
    local y = 1

    local answer = a:getPosition(x, y)
    assert_equal(1, answer, "Wrong calculation")

    verify_mock(mc)
end

function test_getPosition_two()
    local mc = create_mock(SUT)
    local ps = require(SUT)
    mc:replay()

    local a = ps:new()
    a.columns = 8

    local x = 3
    local y = 3

    local answer = a:getPosition(x, y)
    assert_equal(19, answer, "Wrong calculation")

    verify_mock(mc)
end

-------------------------------------
-- Tests all statements in moveCharacter
-- @system_under_test : Map:new(), Map:moveCharacter(x ,y , direction)
-- @author name: Erik
-------------------------------------
function test_moveCharacter_one()
    local mc = create_mock(SUT)
    local ps = require(SUT)

    local setCharacter = mc:mock()
    local square = mc:mock()
    local getPosition = mc:mock()
    local setGoal = mc:mock()
    local setStart = mc:mock()

    package.loaded[SUT].setCharacter = setCharacter
    package.loaded[SUT].square = square
    package.loaded[SUT].getPosition = getPosition
    package.loaded[SUT].setGoal = setGoal
    package.loaded[SUT].setStart = setStart

    local a = ps:new()
    a.inGameObjectives = {}
    local x = 2
    local y = 2
    local direction = 0
    a.columns = 8
    a.startPos = 1
    a.tiles = { 0, 0, 0, 0, 0, 0, 0 }

    setCharacter(mc.ANYARGS); mc:returns(nil):anytimes()
    square(mc.ANYARGS); mc:returns(nil):anytimes()
    getPosition(mc.ANYARGS); mc:returns(1):anytimes()
    setGoal(mc.ANYARGS); mc:returns(nil):anytimes()
    setStart(mc.ANYARGS); mc:returns(nil):anytimes()
    mc:replay()

    a:moveCharacter(x, y, direction)

    verify_mock(mc)
end

function test_moveCharacter_two()
    local mc = create_mock(SUT)
    local ps = require(SUT)

    local setCharacter = mc:mock()
    local square = mc:mock()
    local getPosition = mc:mock()
    local setGoal = mc:mock()
    local setStart = mc:mock()

    package.loaded[SUT].setCharacter = setCharacter
    package.loaded[SUT].square = square
    package.loaded[SUT].getPosition = getPosition
    package.loaded[SUT].setGoal = setGoal
    package.loaded[SUT].setStart = setStart

    local a = ps:new()
    a.inGameObjectives = {}
    local x = 2
    local y = 2
    local direction = 0
    a.columns = 8
    a.startPos = 1
    a.mapdata = {}
    a.tiles = { 0, 0, 0, 0, 0, 0, 0 }

    setCharacter(mc.ANYARGS); mc:returns(nil):anytimes()
    square(mc.ANYARGS); mc:returns(nil):anytimes()
    getPosition(mc.ANYARGS); mc:returns(2):anytimes()
    setGoal(mc.ANYARGS); mc:returns(nil):anytimes()
    setStart(mc.ANYARGS); mc:returns(nil):anytimes()
    mc:replay()

    a:moveCharacter(x, y, direction)

    verify_mock(mc)
end

function test_moveCharacter_three()
    local mc = create_mock(SUT)
    local ps = require(SUT)

    local setCharacter = mc:mock()
    local square = mc:mock()
    local getPosition = mc:mock()
    local setGoal = mc:mock()
    local setStart = mc:mock()

    package.loaded[SUT].setCharacter = setCharacter
    package.loaded[SUT].square = square
    package.loaded[SUT].getPosition = getPosition
    package.loaded[SUT].setGoal = setGoal
    package.loaded[SUT].setStart = setStart

    local a = ps:new()
    a.inGameObjectives = {}
    local x = 2
    local y = 2
    local direction = 3
    a.columns = 8
    a.startPos = 1
    a.mapdata = {}
    a.tiles = { 0, 0, 0, 0, 0, 0, 0 }

    setStart(mc.ANYARGS); mc:returns(nil):anytimes()
    setCharacter(mc.ANYARGS); mc:returns(nil):anytimes()
    square(mc.ANYARGS); mc:returns(nil):anytimes()
    getPosition(mc.ANYARGS); mc:returns(2):anytimes()
    setGoal(mc.ANYARGS); mc:returns(nil):anytimes()
    mc:replay()

    a:moveCharacter(x, y, direction)

    verify_mock(mc)
end

function test_moveCharacter_four()
    local mc = create_mock(SUT)
    local ps = require(SUT)

    local setCharacter = mc:mock()
    local square = mc:mock()
    local getPosition = mc:mock()
    local setGoal = mc:mock()
    local setStart = mc:mock()

    package.loaded[SUT].setCharacter = setCharacter
    package.loaded[SUT].square = square
    package.loaded[SUT].getPosition = getPosition
    package.loaded[SUT].setGoal = setGoal
    package.loaded[SUT].setStart = setStart

    local a = ps:new()
    a.inGameObjectives = {}
    local x = 2
    local y = 2
    local direction = 1
    a.columns = 8
    a.startPos = 1
    a.mapdata = {}
    a.tiles = { 0, 0, 0, 0, 0, 0, 0 }

    setStart(mc.ANYARGS); mc:returns(nil):anytimes()
    setCharacter(mc.ANYARGS); mc:returns(nil):anytimes()
    square(mc.ANYARGS); mc:returns(nil):anytimes()
    getPosition(mc.ANYARGS); mc:returns(2):anytimes()
    setGoal(mc.ANYARGS); mc:returns(nil):anytimes()
    mc:replay()

    a:moveCharacter(x, y, direction)

    verify_mock(mc)
end

function test_moveCharacter_five()
    local mc = create_mock(SUT)
    local ps = require(SUT)

    local setCharacter = mc:mock()
    local square = mc:mock()
    local getPosition = mc:mock()
    local setGoal = mc:mock()
    local setStart = mc:mock()

    package.loaded[SUT].setCharacter = setCharacter
    package.loaded[SUT].square = square
    package.loaded[SUT].getPosition = getPosition
    package.loaded[SUT].setGoal = setGoal
    package.loaded[SUT].setStart = setStart

    local a = ps:new()
    local x = 2
    local y = 2
    local direction = 2
    a.columns = 8
    a.mapdata = {}
    a.tiles = { 0, 0, 0, 0, 0, 0, 0 }
    a.inGameObjectives = {}

    setStart(mc.ANYARGS); mc:returns(nil):anytimes()
    setCharacter(mc.ANYARGS); mc:returns(nil):anytimes()
    square(mc.ANYARGS); mc:returns(nil):anytimes()
    getPosition(mc.ANYARGS); mc:returns(2):anytimes()
    setGoal(mc.ANYARGS); mc:returns(nil):anytimes()
    mc:replay()

    a:moveCharacter(x, y, direction)

    verify_mock(mc)
end

-------------------------------------
-- Tests statements in canMove
-- @system_under_test : Map:new(), Map:canMove(x ,y , direction)
-- @author name: Erik
-------------------------------------
function test_canMove_one()
    local mc = create_mock(SUT)
    local ps = require(SUT)
    local ps2 = require('games.Progg.Tile')

    local getPosition = mc:mock()
    package.loaded[SUT].getPosition = getPosition

    local a = ps:new()
    a.objectives = { 1, 2 }

    local tile = ps2:new("1")


    local x = 1
    local y = 1
    local direction = 0
    a.columns = 8
    a.tiles = { tile }

    getPosition(mc.ANYARGS); mc:returns(1):anytimes()
    mc:replay()

    local answer = a:canMove(x, y, direction)

    assert_true(answer, "cant move")

    verify_mock(mc)
end

function test_canMove_two()
    local mc = create_mock(SUT)
    local ps = require(SUT)
    local ps2 = require('games.Progg.Tile')

    local getPosition = mc:mock()
    package.loaded[SUT].getPosition = getPosition

    local a = ps:new()
    -- a:load()
    local tile = ps2:new("8")


    local x = 1
    local y = 1
    local direction = 0
    a.columns = 8
    a.tiles = { tile }


    getPosition(mc.ANYARGS); mc:returns(1):anytimes()
    mc:replay()

    local answer = a:canMove(x, y, direction)

    assert_false(answer, "cant move")

    verify_mock(mc)
end

function test_canMove_three()
    local mc = create_mock(SUT)
    local ps = require(SUT)
    local ps2 = require('games.Progg.Tile')

    local getPosition = mc:mock()
    package.loaded[SUT].getPosition = getPosition

    local a = ps:new()
    --a:load()
    local tile = ps2:new("3")


    local x = 1
    local y = 1
    local direction = 3
    a.tiles = { tile }

    getPosition(mc.ANYARGS); mc:returns(1):anytimes()
    mc:replay()

    local answer = a:canMove(x, y, direction)

    assert_false(answer, "cant move")

    verify_mock(mc)
end

function test_canMove_four()
    local mc = create_mock(SUT)
    local ps = require(SUT)
    local ps2 = require('games.Progg.Tile')

    local getPosition = mc:mock()
    package.loaded[SUT].getPosition = getPosition

    local a = ps:new()
    -- a:load()
    local tile = ps2:new("4")


    local x = 1
    local y = 1
    local direction = 1
    a.tiles = { tile }

    getPosition(mc.ANYARGS); mc:returns(1):anytimes()
    mc:replay()

    local answer = a:canMove(x, y, direction)

    assert_false(answer, "cant move")

    verify_mock(mc)
end


function test_canMove_five()
    local mc = create_mock(SUT)
    local ps = require(SUT)
    local ps2 = require('games.Progg.Tile')

    local getPosition = mc:mock()
    package.loaded[SUT].getPosition = getPosition

    local a = ps:new()
    -- a:load()
    local tile = ps2:new("2")


    local x = 1
    local y = 1
    local direction = 2
    a.tiles = { tile }

    getPosition(mc.ANYARGS); mc:returns(1):anytimes()
    mc:replay()

    local answer = a:canMove(x, y, direction)

    assert_false(answer, "cant move")

    verify_mock(mc)
end

-------------------------------------
-- Tests the calculation in getX.
-- @system_under_test : Map:new(), Map:getX(i)
-- @author name: Erik
-------------------------------------
function test_getX_one()
    local mc = create_mock(SUT)
    local ps = require(SUT)

    local a = ps:new()

    local i = 1
    a.columns = 8
    a.rows = 5
    a.startx = 2
    a.boxheight = 2

    mc:replay()

    local answer = a:getX(i)

    assert_equal(2, answer, "Wrong x value")

    verify_mock(mc)
end

function test_getX_two()
    local mc = create_mock(SUT)
    local ps = require(SUT)

    local a = ps:new()

    local i = 5
    a.columns = 8
    a.rows = 5
    a.startx = 2
    a.boxheight = 2

    mc:replay()

    local answer = a:getX(i)

    assert_equal(10, answer, "Wrong x value")

    verify_mock(mc)
end

function test_getX_three()
    local mc = create_mock(SUT)
    local ps = require(SUT)

    local a = ps:new()

    local i = 2
    a.columns = 8
    a.rows = 5
    a.startx = 2
    a.boxheight = 2

    mc:replay()

    local answer = a:getX(i)

    assert_not_equal(6, answer, "Should not be this x value")

    verify_mock(mc)
end

-------------------------------------
-- Tests the calculation in getY.
-- @system_under_test : Map:new(), Map:getY(i)
-- @author name: Erik
-------------------------------------
function test_getY_one()
    local mc = create_mock(SUT)
    local ps = require(SUT)

    local a = ps:new()

    local i = 2
    a.columns = 8
    a.rows = 5
    a.starty = 2
    a.boxheight = 2

    mc:replay()

    local answer = a:getY(i)

    assert_equal(2, answer, "Wrong y value")

    verify_mock(mc)
end

function test_getY_two()
    local mc = create_mock(SUT)
    local ps = require(SUT)

    local a = ps:new()

    local i = 10
    a.columns = 8
    a.rows = 5
    a.starty = 2
    a.boxheight = 2

    mc:replay()

    local answer = a:getY(i)

    assert_equal(4, answer, "Wrong y value")

    verify_mock(mc)
end

function test_getY_three()
    local mc = create_mock(SUT)
    local ps = require(SUT)

    local a = ps:new()

    local i = 35
    a.columns = 8
    a.rows = 5
    a.starty = 2
    a.boxheight = 2

    mc:replay()

    local answer = a:getY(i)

    assert_equal(10, answer, "Wrong y value")

    verify_mock(mc)
end

-------------------------------------
-- Tests to call to printInnerBox
-- @system_under_test : Map:new(), Map:printInnerBox(i, color)
-- @author name: Erik
-------------------------------------
function test_printInnerBox_one()
    local mc = create_mock(SUT)
    local ps = require(SUT)

    local getY = mc:mock()
    local getX = mc:mock()
    package.loaded[SUT].getY = getY
    package.loaded[SUT].getX = getX

    local a = ps:new()

    local i = 1
    local color = { g = 83, r = 101, b = 219 }
    a.boxpadding = 1
    a.innerboxheight = 1

    getY(mc.ANYARGS); mc:returns(1):anytimes()
    getX(mc.ANYARGS); mc:returns(1):anytimes()

    mc:replay()

    a:printInnerBox(i, color)

    verify_mock(mc)
end

-------------------------------------
-- Tests the call to printObjective
-- @system_under_test : Map:new(), Map:printObjective(i)
-- @author name: Erik
-------------------------------------
function test_printObjective_one()
    local mc = create_mock(SUT)
    local ps = require(SUT)

    local printInnerBox = mc:mock()

    package.loaded[SUT].printInnerBox = printInnerBox

    local a = ps:new()

    local i = 1
    Map.OBJECTIVECOLOR = { g = 83, r = 101, b = 219 }

    printInnerBox(mc.ANYARGS); mc:returns(1):anytimes()

    mc:replay()

    a:printObjective(i)

    verify_mock(mc)
end

-------------------------------------
-- Tests the call to printObjective
-- @system_under_test : Map:new(), Map:printObjectiveAsDone(i)
-- @author name: Erik
-------------------------------------
function test_printObjectiveAsDone_one()
    local mc = create_mock(SUT)
    local ps = require(SUT)

    local printInnerBox = mc:mock()

    package.loaded[SUT].printInnerBox = printInnerBox

    local a = ps:new()

    local i = 1
    Map.INNERBOXCOLOR = { g = 83, r = 101, b = 219 }

    printInnerBox(mc.ANYARGS); mc:returns(1):anytimes()

    mc:replay()

    a:printObjectiveAsDone(i)

    verify_mock(mc)
end

-------------------------------------
-- Tests return value of isInGoal
-- @system_under_test : Map:new(), Map:isInGoal(x,y)
-- @author name: Erik
-------------------------------------
function test_isInGoal_one()
    local mc = create_mock(SUT)
    local ps = require(SUT)

    local getPosition = mc:mock()

    package.loaded[SUT].getPosition = getPosition

    local a = ps:new()

    local x = 1
    local y = 1
    a.goalPos = 1

    getPosition(mc.ANYARGS); mc:returns(1):anytimes()

    mc:replay()

    local answer = a:isInGoal(x, y)
    assert_true(answer, "wrong return value")

    verify_mock(mc)
end

-------------------------------------
-- Mocks restart character
-- @system_under_test : Map:new(), Map:restartCharacter(x,y)
-- @author name: Erik
-------------------------------------
function test_restartCharacter_one()
    local mc = create_mock(SUT)
    local ps = require(SUT)

    local getPosition = mc:mock()
    local square = mc:mock()
    local setCharacter = mc:mock()
    local setStart = mc:mock()
    local printObjective = mc:mock()

    package.loaded[SUT].getPosition = getPosition
    package.loaded[SUT].square = square
    package.loaded[SUT].setCharacter = setCharacter
    package.loaded[SUT].setStart = setStart
    package.loaded[SUT].printObjective = printObjective

    local a = ps:new()
    a.columns = 1
    a.objectives = { 1 }
    a.inGameObjectives = { 1 }

    local x = 1
    local y = 1
    a.startPos = 1
    a.tiles = {}

    getPosition(mc.ANYARGS); mc:returns(1):anytimes()
    square(mc.ANYARGS); mc:returns(nil):anytimes()
    setCharacter(mc.ANYARGS); mc:returns(nil):anytimes()
    setStart(mc.ANYARGS); mc:returns(nil):anytimes()
    printObjective(mc.ANYARGS); mc:returns(nil):anytimes()

    mc:replay()

    a:restartCharacter(x, y)

    verify_mock(mc)
end