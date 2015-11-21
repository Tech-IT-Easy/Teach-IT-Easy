-- This class represents the game map.

-- Created by IntelliJ IDEA.
-- User: Adam Lydén
-- Date: 2015-11-04
-- Time: 13:57


local Object = require('toolkit.Object')
local Tile = require('games.Progg.Tile')
local Map = extends(Object)


Map.UP = 0
Map.RIGHT = 1
Map.DOWN = 2
Map.LEFT = 3
-------------------------------------
-- Creates new Map object.
-- @return Map New map
-- @author Adam
-------------------------------------
function Map:new()
    local o = Map:super()
    o.rows = 5
    o.columns = 8
    return Map:init(o)
end


-------------------------------------
-- Loads the map depending on data.
-- @param input The mapdata.
-- @author Erik
-------------------------------------
function Map:load()
    -- implement parameter with mapdata

    self.background = gfx.loadpng('data/game_background_small.png')

    screen:copyfrom(self.background, nil, {
        x = 0,
        y = 0,
        w = screen:get_width() * 0.75,
        h = screen:get_height() * 0.65
    }, true)
    self.background:destroy()

    self.boxheight = (screen:get_height() * 0.65) / (self.rows+1)
    local padding = (screen:get_width() * 0.75) - (self.boxheight * self.columns)
    self.startx = padding / 2
    self.starty = self.boxheight / 2
    self.innerboxheight = self.boxheight - 20
    self.boxpadding = 10
    self.borderthickness = self.boxpadding / 2

    -- Mapdata that is being displayed
    -- set as input, when input is implemented
    --[[
    self.mapdata2 =
    {
        9, "a", "c", 0, 0, 0, 0, 0,
        5, 0, 3, "c", 0, 0, 0, 0,
        5, 0, 0, 7, 0, 0, 0, 0,
        5, 0, 0, 0, "f", 0, 0, 0,
        7, 0, 0, 0, 0, 0, 0, 0,
    }
    ]]

    self.file = io.open("games/Progg/levels/level" .. tostring(1) .. ".txt", "r")
    --self.data = self.file:read("*a")
    self.mapdata = {}
    for line in self.file:lines() do
        -- print(line)
        table.insert(self.mapdata, line)
    end

    self.tiles = {}
    --Creating tiles from mapdata

    for i = 1, #self.mapdata do
        table.insert(self.tiles, Tile:new(self.mapdata[i]))
    end

    self.goalPos = 20
    self.startPos = 33
    --self.objectives = { 17, 1 }
    --self.inGameObjectives = self.objectives
    self.charPos = self.startPos

    --Loop builds map
    for i = 1, #self.tiles, 1 do
        self:square(i, self.tiles[i])
    end
    self:setGoal(self.goalPos)
    self:setStart(self.startPos)
    self:setCharacter(self.charPos)

    --[[
     for i = 1, #self.objectives, 1 do
        self:printObjective(self.objectives[i])
    end
    ]]
end



-------------------------------------
-- Called by a character to activate a "broken" tile
-- @param x X value on map
-- @param y Y value on map
-- @author Erik
-------------------------------------
function Map:activateBox(x, y)
    local pos = self:getPosition(x, y)
    for _, v in pairs(self.inGameObjectives) do
        if v == pos then
            self:printObjectiveAsDone(pos)
            self.inGameObjectives.remove(_)
            break
        end
    end
end

function Map:printInnerBox(i, color)
    if (i < 9) then
        screen:clear(color, {
            x = self.startx + self.boxheight * (i - 1) + self.boxpadding,
            y = self.starty + self.boxpadding,
            w = self.innerboxheight,
            h = self.innerboxheight
        })
    elseif (i < 17) then
        i = i - 8
        screen:clear(color, {
            x = self.startx + self.boxheight * (i - 1) + self.boxpadding,
            y = self.starty + self.boxheight + self.boxpadding,
            w = self.innerboxheight,
            h = self.innerboxheight
        })
    elseif (i < 25) then
        i = i - 16
        screen:clear(color, {
            x = self.startx + self.boxheight * (i - 1) + self.boxpadding,
            y = self.starty + self.boxheight * 2 + self.boxpadding,
            w = self.innerboxheight,
            h = self.innerboxheight
        })
    elseif (i < 33) then
        i = i - 24
        screen:clear(color, {
            x = self.startx + self.boxheight * (i - 1) + self.boxpadding,
            y = self.starty + self.boxheight * 3 + self.boxpadding,
            w = self.innerboxheight,
            h = self.innerboxheight
        })
    else
        i = i - 32
        screen:clear(color, {
            x = self.startx + self.boxheight * (i - 1) + self.boxpadding,
            y = self.starty + self.boxheight * 4 + self.boxpadding,
            w = self.innerboxheight,
            h = self.innerboxheight
        })
    end
end

-------------------------------------
-- Prints an objective square.
-- @param i Place of objective
-- @author Erik
-------------------------------------
function Map:printObjective(i)
    local wantedColor = { g = 9, r = 115, b = 13 }
    self:printInnerBox(i, wantedColor)
end

-------------------------------------
-- Prints an objective square as done.
-- @param i Place of objective
-- @author Erik
-------------------------------------
function Map:printObjectiveAsDone(i)
    local wantedColor = { g = 83, r = 101, b = 219 }
    self:printInnerBox(i, wantedColor)
end

-------------------------------------
-- Checks if character can move in wanted direction
-- @param x Place of character
-- @param y Place of character
-- @param direction Wanted direction
-- @return true If the move is accapted
-- @return false If the move is not accapted
-- @author Erik
-------------------------------------
function Map:canMove(x, y, direction)
    if direction == Map.UP and self.tiles[self:getPosition(x, y)].topBorder == true then
        return false
    elseif direction == Map.LEFT and self.tiles[self:getPosition(x, y)].leftBorder == true then
        return false
    elseif direction == Map.RIGHT and self.tiles[self:getPosition(x, y)].rightBorder == true then
        return false
    elseif direction == Map.DOWN and self.tiles[self:getPosition(x, y)].bottomBorder == true then
        return false
    else
        return true
    end
end

-------------------------------------
-- Move character on map.
-- @param x Place of character
-- @param y Place of character
-- @param direction Direction to move
-- @author Erik
-------------------------------------
function Map:moveCharacter(x, y, direction)
    local pos = self:getPosition(x, y)
    local isObjective = false
    --[[for _, v in pairs(self.inGameObjectives) do
        if v == pos then
            isObjective = true
            break
        end
    end
]]
    if pos == self.startPos then
        self:setStart(pos)
    elseif isObjective then
        self:printObjective(pos)
    else
        self:square(pos, self.tiles[pos])
    end
    if direction == Map.UP then
        self:setCharacter(pos - 8)
    elseif direction == Map.LEFT then
        self:setCharacter(pos - 1)
    elseif direction == Map.RIGHT then
        self:setCharacter(pos + 1)
    elseif direction == Map.DOWN then
        self:setCharacter(pos + 8)
    end
end

-------------------------------------
-- Converts x and y value to position in mapdata.
-- @param x Place of character
-- @param y Place of character
-- @return pos The calculated position in table
-- @author Erik
-------------------------------------
function Map:getPosition(x, y)
    local pos = x + (y - 1) * 8
    return pos
end

-------------------------------------
-- Prints character to a place in map.
-- @param i Place of character
-- @author Erik
-------------------------------------
function Map:setCharacter(i)

    self.image1 = gfx.loadpng('data/bowser.png')
    self.image1:premultiply()

    if (i < 9) then
        screen:copyfrom(self.image1, nil, {
            x = self.startx + self.boxheight * (i - 1) + self.boxpadding,
            y = self.starty + self.boxpadding,
            w = self.innerboxheight,
            h = self.innerboxheight
        }, true)
    elseif (i < 17) then
        i = i - 8
        screen:copyfrom(self.image1, nil, {
            x = self.startx + self.boxheight * (i - 1) + self.boxpadding,
            y = self.starty + self.boxheight + self.boxpadding,
            w = self.innerboxheight,
            h = self.innerboxheight
        }, true)
    elseif (i < 25) then
        i = i - 16
        screen:copyfrom(self.image1, nil, {
            x = self.startx + self.boxheight * (i - 1) + self.boxpadding,
            y = self.starty + self.boxheight * 2 + self.boxpadding,
            w = self.innerboxheight,
            h = self.innerboxheight
        }, true)
    elseif (i < 33) then
        i = i - 24
        screen:copyfrom(self.image1, nil, {
            x = self.startx + self.boxheight * (i - 1) + self.boxpadding,
            y = self.starty + self.boxheight * 3 + self.boxpadding,
            w = self.innerboxheight,
            h = self.innerboxheight
        }, true)
    else
        i = i - 32
        screen:copyfrom(self.image1, nil, {
            x = self.startx + self.boxheight * (i - 1) + self.boxpadding,
            y = self.starty + self.boxheight * 4 + self.boxpadding,
            w = self.innerboxheight,
            h = self.innerboxheight
        }, true)
    end

    self.image1:destroy()
end

-------------------------------------
-- Prints a tile in color of goal.
-- @param i Place of goal
-- @author Erik
-------------------------------------
function Map:setGoal(i)
    local wantedColor = { g = 194, r = 225, b = 42 }
    self:printInnerBox(i, wantedColor)
end

-------------------------------------
-- Prints a tile in color of start.
-- @param i Place of start
-- @author Erik
-------------------------------------
function Map:setStart(i)
    local wantedColor = { g = 240, r = 19, b = 56 }
    self:printInnerBox(i, wantedColor)
end


function Map:update()
end

-------------------------------------
-- Calculates x and y values of tile.
-- @param i Place of tile
-- @param type The type of tile to be printed
-- @author Erik
-------------------------------------
function Map:square(i, tile)
    if (i < 9) then
        self:drawBox(tile, self.startx + self.boxheight * (i - 1), self.starty)
    elseif (i < 17) then
        i = i - 8
        self:drawBox(tile, self.startx + self.boxheight * (i - 1), self.starty + self.boxheight)
    elseif (i < 25) then
        i = i - 16
        self:drawBox(tile, self.startx + self.boxheight * (i - 1), self.starty + self.boxheight * 2)
    elseif (i < 33) then
        i = i - 24
        self:drawBox(tile, self.startx + self.boxheight * (i - 1), self.starty + self.boxheight * 3)
    else
        i = i - 32
        self:drawBox(tile, self.startx + self.boxheight * (i - 1), self.starty + self.boxheight * 4)
    end
end

-------------------------------------
-- Prints a tile on the board.
-- @param type The type of tile to be printed
-- @param xPos X placement of tile
-- @param yPos Y placement of tile
-- @author Erik
-------------------------------------
function Map:drawBox(tile, xPos, yPos)

    if tile.active then
        self:drawStandardBox(xPos, yPos)
        if tile.topBorder then
            self:drawTopBorder(xPos, yPos)
        end
        if tile.leftBorder then
            self:drawLeftBorder(xPos, yPos)
        end
        if tile.rightBorder then
            self:drawRightBorder(xPos, yPos)
        end
        if tile.bottomBorder then
            self:drawBottomBorder(xPos, yPos)
        end
    end
end

-------------------------------------
-- Prints a standard tile with inner box to the board.
-- @param xPos X placement of tile
-- @param yPos Y placement of tile
-- @author Erik
-------------------------------------
function Map:drawStandardBox(xPos, yPos)
    screen:clear({ g = 28, r = 70, b = 122 }, { x = xPos, y = yPos, w = self.boxheight, h = self.boxheight })
    screen:clear({ g = 83, r = 101, b = 219 }, {
        x = xPos + self.boxpadding,
        y = yPos + self.boxpadding,
        w = self.innerboxheight,
        h = self.innerboxheight
    })
end

-------------------------------------
-- Prints a border on the top of the tile.
-- @param xPos X placement of tile
-- @param yPos Y placement of tile
-- @author Erik
-------------------------------------
function Map:drawTopBorder(xPos, yPos)
    screen:clear({ g = 255, r = 255, b = 255 }, { x = xPos, y = yPos, w = self.boxheight, h = self.borderthickness })
end

-------------------------------------
-- Prints a border on the bottom of the tile.
-- @param xPos X placement of tile
-- @param yPos Y placement of tile
-- @author Erik
-------------------------------------
function Map:drawBottomBorder(xPos, yPos)
    yPos = yPos + self.boxheight - self.borderthickness
    screen:clear({ g = 255, r = 255, b = 255 }, { x = xPos, y = yPos, w = self.boxheight, h = self.borderthickness })
end

-------------------------------------
-- Prints a border on the left side of the tile.
-- @param xPos X placement of tile
-- @param yPos Y placement of tile
-- @author Erik
-------------------------------------
function Map:drawLeftBorder(xPos, yPos)
    screen:clear({ g = 255, r = 255, b = 255 }, { x = xPos, y = yPos, w = self.borderthickness, h = self.boxheight })
end

-------------------------------------
-- Prints a border on the right side of the tile.
-- @param xPos X placement of tile
-- @param yPos Y placement of tile
-- @author Erik
-------------------------------------
function Map:drawRightBorder(xPos, yPos)
    xPos = xPos + self.boxheight - self.borderthickness
    screen:clear({ g = 255, r = 255, b = 255 }, { x = xPos, y = yPos, w = self.borderthickness, h = self.boxheight })
end

return Map