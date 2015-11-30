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

Map.STARTCOLOR = { g = 240, r = 19, b = 56 }
Map.GOALCOLOR = { g = 194, r = 225, b = 42 }
Map.INNERBOXCOLOR = { g = 83, r = 101, b = 219 }
Map.OUTERBOXCOLOR = { g = 28, r = 70, b = 122 }
Map.OBJECTIVECOLOR = { g = 9, r = 115, b = 13 }
-------------------------------------
-- Creates new Map object.
-- @return map:Map a new instance of Map
-- @author Adam
-------------------------------------
function Map:new()
    local o = Map:super()

    return Map:init(o)
end


-------------------------------------
-- Loads the map depending on data. "Hard-coded" 23/11
-- @param input The mapdata. Not used 23/11
-- @author Erik
-------------------------------------
function Map:load(levelData)
    -- implement parameter with mapdata

    self.background = gfx.loadpng('data/game_background_small.png')

    screen:copyfrom(self.background, nil, {
        x = 0,
        y = 0,
        w = screen:get_width() * 0.75,
        h = screen:get_height() * 0.65
    }, true)
    self.background:destroy()

    -- Variables of level, should be read from file?
    self.rows = 5
    self.columns = 8
    self.goalPos = levelData.levelGoalPosition
    self.startPos = levelData.levelStartPosition
    self.charPos = self.startPos
    --Fro creating the inGame objectives
    self.objectives = levelData.objectives
    self.inGameObjectives = {}
    for i = 1, #self.objectives do
        self.inGameObjectives[i] = self.objectives[i]
    end
    -- Calculates variables of map
    self.boxheight = (screen:get_height() * 0.65) / (self.rows + 1)
    local padding = (screen:get_width() * 0.75) - (self.boxheight * self.columns)
    self.startx = padding / 2
    self.starty = self.boxheight / 2
    self.innerboxheight = self.boxheight - 20
    self.boxpadding = 10
    self.borderthickness = self.boxpadding / 2


    self.mapdata = {}
    --    {
    --        "9", "a", "c", "f", "f", "f", "f", "f",
    --        "5", "f", "3", "c", "f", "f", "f", "f",
    --        "5", "f", "f", "7", "f", "f", "f", "f",
    --        "5", "f", "f", "f", "f", "f", "f", "f",
    --        "7", "f", "f", "f", "f", "f", "f", "f",
    --    }
    local levelMapData = levelData.mapData

    for i = 1, #levelMapData do
        local c = levelMapData:sub(i, i)
        table.insert(self.mapdata, c)
    end


    self.tiles = {}

    for i = 1, #self.mapdata do
        --@member tiles:Tile
        table.insert(self.tiles, Tile:new(self.mapdata[i]))
    end


    self.goalPos = 20
    self.startPos = 33
    self.charPos = self.startPos

    --Loop builds map
    for i = 1, 40, 1 do
        self:square(i, self.tiles[i])
    end
    self:setGoal(self.goalPos)
    self:setStart(self.startPos)
    self:setCharacter(self.charPos, Map.UP)

    --Restart the list of objectives
    for i = 1, #self.objectives do
        self.inGameObjectives[i] = self.objectives[i]
    end
    --And redraw all the objectives
    for i = 1, #self.objectives, 1 do
        self:printObjective(self.objectives[i])
    end
end



-------------------------------------
-- Called by a character to activate a "broken" tile
-- @param x X value on map
-- @param y Y value on map
-- @author Erik
-------------------------------------
function Map:activateBox(x, y)
    local pos = self:getPosition(x, y)
    for k, v in pairs(self.inGameObjectives) do
        if v == pos then
            self:printObjectiveAsDone(pos)
            table.remove(self.inGameObjectives, k)
            break
        end
    end
end

-------------------------------------
-- Returns x placement in table(as if two dimensional)
-- @param i Placement in table
-- @return x Placement in a row
-- @author Erik
-------------------------------------
function Map:getX(i)
    local searching = true
    while searching do
        i = i - self.columns
        if not (i > 0) then
            i = i + self.columns
            return self.startx + self.boxheight * (i - 1)
        end
    end
end

-------------------------------------
-- Returns y placement in table(as if two dimensional)
-- @param i Placement in table
-- @return y Placement in a column
-- @author Erik
-------------------------------------
function Map:getY(i)
    local searching = true
    local row = 1
    while searching do
        i = i - self.columns
        if not (i > 0) then
            return self.starty + (self.boxheight * (row - 1))
        end
        row = row + 1
    end
end

-------------------------------------
-- Prints only the inner part of an box.
-- @param i The position of the box in the table.
-- @param color The color of the box.
-- @author Erik
-------------------------------------
function Map:printInnerBox(i, color)
    screen:clear(color, {
        x = self:getX(i) + self.boxpadding,
        y = self:getY(i) + self.boxpadding,
        w = self.innerboxheight,
        h = self.innerboxheight
    })
end

-------------------------------------
-- Prints an objective square.
-- @param i Place of objective
-- @author Erik
-------------------------------------
function Map:printObjective(i)
    local wantedColor = Map.OBJECTIVECOLOR
    self:printInnerBox(i, wantedColor)
end

-------------------------------------
-- Prints an objective square as done.
-- @param i Place of objective
-- @author Erik
-------------------------------------
function Map:printObjectiveAsDone(i)
    local wantedColor = Map.INNERBOXCOLOR
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

    --Check if its in a objective
    for _, v in pairs(self.inGameObjectives) do
        if v == pos then
            isObjective = true
            break
        end
    end

    if pos == self.startPos then
        self:setStart(pos)
    elseif isObjective then
        self:printObjective(pos)
    else
        self:square(pos, self.tiles[pos])
    end
    if direction == Map.UP then
        self:setCharacter(pos - self.columns, direction)
    elseif direction == Map.LEFT then
        self:setCharacter(pos - 1, direction)
    elseif direction == Map.RIGHT then
        self:setCharacter(pos + 1, direction)
    elseif direction == Map.DOWN then
        self:setCharacter(pos + self.columns, direction)
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
    local pos = x + (y - 1) * self.columns
    return pos
end

-------------------------------------
-- Return a bool saying if the character is in the goal.
-- @param x Place of character
-- @param y Place of character
-- @return true or false
-- @author Mario Pizcueta
-------------------------------------
function Map:isInGoal(x, y)
    return self:getPosition(x, y) == self.goalPos
end

-------------------------------------
-- Restarts the character to the start position
-- @param x Place of character
-- @param y Place of character
-- @author Mario Pizcueta
-------------------------------------
function Map:restartCharacter(x, y)
    local pos = self:getPosition(x, y)
    if pos == self.startPos then
        self:setStart(self.startPos)
    else
        self:square(pos, self.tiles[pos])
    end
    self:setCharacter(self.startPos, Map.UP)

    --Restart the list of objectives
    for i = 1, #self.objectives do
        self.inGameObjectives[i] = self.objectives[i]
    end
    --And redraw all the objectives
    for i = 1, #self.objectives, 1 do
        self:printObjective(self.objectives[i])
    end
end

-------------------------------------
-- Prints character to a place in map.
-- @param i Place of character
-- @author Erik
-------------------------------------
function Map:setCharacter(i, direction)
    self.image1 = gfx.loadpng('data/avatar/cute_robot/UP.png')
    self.image1:premultiply()
    if direction == Map.UP then
        self.image1 = gfx.loadpng('data/avatar/cute_robot/UP.png')
    elseif direction == Map.DOWN then
        self.image1 = gfx.loadpng('data/avatar/cute_robot/DOWN.png')
    elseif direction == Map.RIGHT then
        self.image1 = gfx.loadpng('data/avatar/cute_robot/RIGHT.png')
    elseif direction == Map.LEFT then
        self.image1 = gfx.loadpng('data/avatar/cute_robot/LEFT.png')
    end

    screen:copyfrom(self.image1, nil, {
        x = self:getX(i) + self.boxpadding,
        y = self:getY(i) + self.boxpadding,
        w = self.innerboxheight,
        h = self.innerboxheight
    }, true)
    self.image1:destroy()
    gfx.update()
end

-------------------------------------
-- Prints a tile in color of goal.
-- @param i Place of goal
-- @author Erik
-------------------------------------
function Map:setGoal(i)
    local wantedColor = Map.GOALCOLOR
    self:printInnerBox(i, wantedColor)
end

-------------------------------------
-- Prints a tile in color of start.
-- @param i Place of start
-- @author Erik
-------------------------------------
function Map:setStart(i)
    local wantedColor = Map.STARTCOLOR
    self:printInnerBox(i, wantedColor)
end


function Map:update()
end

-------------------------------------
-- Calculates x and y values of tile.
-- @param i Place of tile
-- @param tile:Tile The type of tile to be printed
-- @author Erik
-------------------------------------
function Map:square(i, tile)
    self:drawBox(tile, self:getX(i), self:getY(i))
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
    screen:clear(Map.OUTERBOXCOLOR, { x = xPos, y = yPos, w = self.boxheight, h = self.boxheight })
    screen:clear(Map.INNERBOXCOLOR, {
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


