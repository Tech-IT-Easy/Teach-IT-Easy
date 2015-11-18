--
-- Created by IntelliJ IDEA.
-- User: Andreas Mansson
-- Date: 2015-11-05
-- Time: 11:36
-- To change this template use File | Settings | File Templates.
--

lunit = require "lunit"
module( "src_games_Progg_Map", package.seeall, lunit.testcase )
Map = require "src.games.Progg.Map"

local SUT = 'src.games.Progg.Map'

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
  package.loaded['src.games.Progg.Map'] = nil
  package.preload['src.games.Progg.Map'] = nil
end

function test_load()
  local mc = create_mock(SUT)

  -- Mock renderui and printbackground
   local square = mc:mock()
   local setGoal = mc:mock()
   local setStart = mc:mock()
   local setCharacter = mc:mock()
  --local printbackground = mc:mock()

  local ps = require(SUT)

  package.loaded[SUT].square = square
  package.loaded[SUT].setGoal = setGoal
  package.loaded[SUT].setStart = setStart
  package.loaded[SUT].setCharacter = setCharacter
 -- package.loaded[SUT].printbackground = printbackground

  square(mc.ANYARGS) ;mc :returns(nil) :times(40)
  setGoal(mc.ANYARGS) ;mc :returns(nil) :times(1)
  setStart(mc.ANYARGS) ;mc :returns(nil) :times(1)
  setCharacter(mc.ANYARGS) ;mc :returns(nil) :times(1)
  --printbackground(mc.ANYARGS) ;mc :returns(nil) :times(1)

  mc:replay()

  local b = ps:new()
  b:load()

  verify_mock(mc)
end

--setCharacter tests
function test_setCharacter_one()
  local mc = create_mock(SUT)
  local ps = require(SUT)
  mc:replay()

  local a = ps:new()
  local input = 8
  a.boxheight = 50
  a.startx = 200
  a.starty = 200
  a.boxpadding = 20
  a.innerboxheight = 40
  a:setCharacter(input)

  verify_mock(mc)
end

function test_setCharacter_two()
  local mc = create_mock(SUT)
  local ps = require(SUT)
  mc:replay()

  local a = ps:new()
  local input = 16
  a.boxheight = 50
  a.startx = 200
  a.starty = 200
  a.boxpadding = 20
  a.innerboxheight = 40
  a:setCharacter(input)

  verify_mock(mc)
end

function test_setCharacter_three()
  local mc = create_mock(SUT)
  local ps = require(SUT)
  mc:replay()

  local a = ps:new()
  local input = 24
  a.boxheight = 50
  a.startx = 200
  a.starty = 200
  a.boxpadding = 20
  a.innerboxheight = 40
  a:setCharacter(input)

  verify_mock(mc)
end

function test_setCharacter_four()
  local mc = create_mock(SUT)
  local ps = require(SUT)
  mc:replay()

  local a = ps:new()
  local input = 32
  a.boxheight = 50
  a.startx = 200
  a.starty = 200
  a.boxpadding = 20
  a.innerboxheight = 40
  a:setCharacter(input)

  verify_mock(mc)
end

function test_setCharacter_five()
  local mc = create_mock(SUT)
  local ps = require(SUT)
  mc:replay()

  local a = ps:new()
  local input = 33
  a.boxheight = 50
  a.startx = 200
  a.starty = 200
  a.boxpadding = 20
  a.innerboxheight = 40
  a:setCharacter(input)

  verify_mock(mc)
end

--setGoal tests
function test_setGoal_one()
  local mc = create_mock(SUT)
  local ps = require(SUT)
  mc:replay()

  local a = ps:new()
  local input = 8
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
  a.boxheight = 50
  a.startx = 200
  a.starty = 200
  a.boxpadding = 20
  a.innerboxheight = 40
  a:setGoal(input)

  verify_mock(mc)
end

--setStart tests
function test_setStart_one()
  local mc = create_mock(SUT)
  local ps = require(SUT)
  mc:replay()

  local a = ps:new()
  local input = 8
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
  a.boxheight = 50
  a.startx = 200
  a.starty = 200
  a.boxpadding = 20
  a.innerboxheight = 40
  a:setStart(input)

  verify_mock(mc)
end

--square tests
function test_square_one()
  local mc = create_mock(SUT)
  local ps = require(SUT)

  local drawBox = mc:mock()
  package.loaded[SUT].drawBox = drawBox

  local a = ps:new()
  local type = 1
  local input = 8
  a.startx = 200
  a.starty = 200
  a.boxheight = 50

  drawBox(mc.ANYARGS) ;mc :returns(nil) :times(1)
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
  a.startx = 200
  a.starty = 200
  a.boxheight = 50

  drawBox(mc.ANYARGS) ;mc :returns(nil) :times(1)
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
  a.startx = 200
  a.starty = 200
  a.boxheight = 50

  drawBox(mc.ANYARGS) ;mc :returns(nil) :times(1)
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
  a.startx = 200
  a.starty = 200
  a.boxheight = 50

  drawBox(mc.ANYARGS) ;mc :returns(nil) :times(1)
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
  a.startx = 200
  a.starty = 200
  a.boxheight = 50

  drawBox(mc.ANYARGS) ;mc :returns(nil) :times(1)
  mc:replay()

  a:square(input, type)

  verify_mock(mc)
end

--drawBox tests
function test_drawBox_one()
  local mc = create_mock(SUT)
  local ps = require(SUT)

  local drawStandardBox = mc:mock()

  package.loaded[SUT].drawStandardBox = drawStandardBox

  local ps2 = require("src.games.Progg.Tile")
  local a = ps:new()
  local tile = ps2:new(0)
  local xPos = 200
  local yPos = 200

  drawStandardBox(mc.ANYARGS) ;mc :returns(nil) :anytimes()
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

  local ps2 = require("src.games.Progg.Tile")
  local a = ps:new()
  local tile = ps2:new(2)
  local xPos = 200
  local yPos = 200

  drawStandardBox(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  drawBottomBorder(mc.ANYARGS) ;mc :returns(nil) :anytimes()
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

  local ps2 = require("src.games.Progg.Tile")
  local a = ps:new()
  local tile = ps2:new(4)
  local xPos = 200
  local yPos = 200

  drawStandardBox(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  drawRightBorder(mc.ANYARGS) ;mc :returns(nil) :anytimes()
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

  local ps2 = require("src.games.Progg.Tile")
  local a = ps:new()
  local tile = ps2:new(8)
  local xPos = 200
  local yPos = 200

  drawStandardBox(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  drawTopBorder(mc.ANYARGS) ;mc :returns(nil) :anytimes()
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

  local ps2 = require("src.games.Progg.Tile")
  local a = ps:new()
  local tile = ps2:new(1)
  local xPos = 200
  local yPos = 200

  drawStandardBox(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  drawLeftBorder(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  mc:replay()

  a:drawBox(tile, xPos, yPos)

  verify_mock(mc)
end

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

function test_getPosition_one()
  local mc = create_mock(SUT)
  local ps = require(SUT)
  mc:replay()

  local a = ps:new()

  local x =1
  local y =1

  local answer = a:getPosition(x,y)
  assert_equal( 1, answer, "Wrong calculation" )

  verify_mock(mc)
end

function test_getPosition_two()
  local mc = create_mock(SUT)
  local ps = require(SUT)
  mc:replay()

  local a = ps:new()

  local x =3
  local y =3

  local answer = a:getPosition(x,y)
  assert_equal( 19, answer, "Wrong calculation" )

  verify_mock(mc)
end

function test_moveCharacter_one()
  local mc = create_mock(SUT)
  local ps = require(SUT)

  local setCharacter = mc:mock()
  local square = mc:mock()
  local getPosition = mc:mock()
  local setGoal = mc:mock()

  package.loaded[SUT].setCharacter = setCharacter
  package.loaded[SUT].square = square
  package.loaded[SUT].getPosition = getPosition
  package.loaded[SUT].setGoal = setGoal

  local a = ps:new()
  local x = 2 
  local y = 2 
  local direction = "up"
  a.startPos = 1

  setCharacter(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  square(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  getPosition(mc.ANYARGS) ;mc :returns(1) :anytimes()
  setGoal(mc.ANYARGS) ;mc :returns(nil) :anytimes()
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

  package.loaded[SUT].setCharacter = setCharacter
  package.loaded[SUT].square = square
  package.loaded[SUT].getPosition = getPosition
  package.loaded[SUT].setGoal = setGoal

  local a = ps:new()
  local x = 2 
  local y = 2 
  local direction = "up"
  a.startPos = 1
  a.mapdata= {}

  setCharacter(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  square(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  getPosition(mc.ANYARGS) ;mc :returns(2) :anytimes()
  setGoal(mc.ANYARGS) ;mc :returns(nil) :anytimes()
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

  package.loaded[SUT].setCharacter = setCharacter
  package.loaded[SUT].square = square
  package.loaded[SUT].getPosition = getPosition
  package.loaded[SUT].setGoal = setGoal

  local a = ps:new()
  local x = 2 
  local y = 2 
  local direction = "left"
  a.startPos = 1
  a.mapdata= {}

  setCharacter(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  square(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  getPosition(mc.ANYARGS) ;mc :returns(2) :anytimes()
  setGoal(mc.ANYARGS) ;mc :returns(nil) :anytimes()
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

  package.loaded[SUT].setCharacter = setCharacter
  package.loaded[SUT].square = square
  package.loaded[SUT].getPosition = getPosition
  package.loaded[SUT].setGoal = setGoal

  local a = ps:new()
  local x = 2 
  local y = 2 
  local direction = "right"
  a.startPos = 1
  a.mapdata= {}

  setCharacter(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  square(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  getPosition(mc.ANYARGS) ;mc :returns(2) :anytimes()
  setGoal(mc.ANYARGS) ;mc :returns(nil) :anytimes()
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

  package.loaded[SUT].setCharacter = setCharacter
  package.loaded[SUT].square = square
  package.loaded[SUT].getPosition = getPosition
  package.loaded[SUT].setGoal = setGoal

  local a = ps:new()
  local x = 2 
  local y = 2 
  local direction = "down"
  a.startPos = 1
  a.mapdata= {}

  setCharacter(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  square(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  getPosition(mc.ANYARGS) ;mc :returns(2) :anytimes()
  setGoal(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  mc:replay()

  a:moveCharacter(x, y, direction)

  verify_mock(mc)
end

function test_canMove_one()
  local mc = create_mock(SUT)
  local ps = require(SUT)
  local ps2 = require('src.games.Progg.Tile')
  
  local getPosition = mc:mock()
  package.loaded[SUT].getPosition = getPosition

  local a = ps:new()
  local tile = ps2:new(1)
  

  local x =1
  local y =1
  local direction = "up"
  a.tiles = {tile}
  
  getPosition(mc.ANYARGS) ;mc :returns(1) :anytimes()
  mc:replay()

  local answer = a:canMove(x,y,direction)

  assert_true( answer, "cant move")

  verify_mock(mc)
end

function test_canMove_two()
  local mc = create_mock(SUT)
  local ps = require(SUT)
  local ps2 = require('src.games.Progg.Tile')
  
  local getPosition = mc:mock()
  package.loaded[SUT].getPosition = getPosition

  local a = ps:new()
  local tile = ps2:new(8)
  

  local x =1
  local y =1
  local direction = "up"
  a.tiles = {tile}
  
  getPosition(mc.ANYARGS) ;mc :returns(1) :anytimes()
  mc:replay()

  local answer = a:canMove(x,y,direction)

  assert_false( answer, "cant move")

  verify_mock(mc)
end

function test_canMove_three()
  local mc = create_mock(SUT)
  local ps = require(SUT)
  local ps2 = require('src.games.Progg.Tile')
  
  local getPosition = mc:mock()
  package.loaded[SUT].getPosition = getPosition

  local a = ps:new()
  local tile = ps2:new(3)
  

  local x =1
  local y =1
  local direction = "left"
  a.tiles = {tile}
  
  getPosition(mc.ANYARGS) ;mc :returns(1) :anytimes()
  mc:replay()

  local answer = a:canMove(x,y,direction)

  assert_false( answer, "cant move")

  verify_mock(mc)
end

function test_canMove_four()
  local mc = create_mock(SUT)
  local ps = require(SUT)
  local ps2 = require('src.games.Progg.Tile')
  
  local getPosition = mc:mock()
  package.loaded[SUT].getPosition = getPosition

  local a = ps:new()
  local tile = ps2:new(4)
  

  local x =1
  local y =1
  local direction = "right"
  a.tiles = {tile}
  
  getPosition(mc.ANYARGS) ;mc :returns(1) :anytimes()
  mc:replay()

  local answer = a:canMove(x,y,direction)

  assert_false( answer, "cant move")

  verify_mock(mc)
end


function test_canMove_five()
  local mc = create_mock(SUT)
  local ps = require(SUT)
  local ps2 = require('src.games.Progg.Tile')
  
  local getPosition = mc:mock()
  package.loaded[SUT].getPosition = getPosition

  local a = ps:new()
  local tile = ps2:new(2)
  

  local x =1
  local y =1
  local direction = "down"
  a.tiles = {tile}
  
  getPosition(mc.ANYARGS) ;mc :returns(1) :anytimes()
  mc:replay()

  local answer = a:canMove(x,y,direction)

  assert_false( answer, "cant move")

  verify_mock(mc)
end
-- Delete this function when the real test is done
--[[
function test_Map_fail()
   fail("Map class and functions not tested yet!")
end]]