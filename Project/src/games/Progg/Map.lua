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

  screen:copyfrom(self.background, nil, { x = 0, y = 0, w = screen:get_width()*0.75,
    h = screen:get_height()*0.65 }, true)
  self.background:destroy()

  self.boxheight = (screen:get_height()*0.65)/6
  local padding = (screen:get_width()*0.75)-(self.boxheight * 8)
  self.startx = padding/2
  self.starty = self.boxheight/2
  self.innerboxheight = self.boxheight-20
  self.boxpadding = 10
  self.borderthickness = self.boxpadding/2

  -- Mapdata that is being displayed
  -- set as input, when input is implemented
  self.mapdata =
    {9, "a", "c", 0, 0, 0, 0, 0,
      5, 5, 3, "c", 0, 0, 0, 0,
      5, 1, 0, 0, 0, 0, 0, 0,
      5, 1, 0, 0, "f", 0, 0, 0,
      7, 3, 0, 0, 0, 0, 0, 0,}


  self.tiles = {}
  --Creating tiles from mapdata

  for i=1, #self.mapdata do
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
  self:setCharacter(self.charPos)

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
function Map:canMove(x ,y , direction)
  if direction == Map.UP and self.tiles[self:getPosition(x,y)].topBorder == true then
    return false
  elseif direction == Map.LEFT and self.tiles[self:getPosition(x,y)].leftBorder == true then
    return false
  elseif direction == Map.RIGHT and self.tiles[self:getPosition(x,y)].rightBorder == true then
    return false
  elseif direction == Map.DOWN and self.tiles[self:getPosition(x,y)].bottomBorder == true then
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
function Map:moveCharacter(x ,y , direction)
  local pos = self:getPosition(x,y)
    if pos == self.startPos then
      self:setStart(pos)
    else
     self:square(pos, self.tiles[pos])
    end
    if direction == Map.UP then
      self:setCharacter(pos-8)
    elseif direction == Map.LEFT then
      self:setCharacter(pos-1)
    elseif direction == Map.RIGHT then
      self:setCharacter(pos+1)
    elseif direction == Map.DOWN then
      self:setCharacter(pos+8)
    end
    gfx.update()
end

-------------------------------------
-- Converts x and y value to position in mapdata.
-- @param x Place of character
-- @param y Place of character
-- @return pos The calculated position in table
-- @author Erik
-------------------------------------
function Map:getPosition(x,y)
  local pos = x+(y-1)*8
  return pos
end

-------------------------------------
-- Prints character to a place in map.
-- @param i Place of character
-- @author Erik
-------------------------------------
function Map:setCharacter(i)

  self.image1 = gfx.loadpng('data/bowser.png')

  if(i<9)then
    screen:copyfrom(self.image1, nil, { x = self.startx +self.boxheight * (i - 1)+self.boxpadding,
      y = self.starty+self.boxpadding, w = self.innerboxheight, h = self.innerboxheight }, true)
  elseif(i<17)then
    i= i -8
    screen:copyfrom(self.image1, nil, { x = self.startx +self.boxheight * (i - 1)+self.boxpadding,
      y = self.starty+self.boxheight+self.boxpadding, w = self.innerboxheight, h = self.innerboxheight}, true)
  elseif(i<25)then
    i= i -16
    screen:copyfrom(self.image1, nil, { x = self.startx +self.boxheight * (i - 1)+self.boxpadding,
      y = self.starty+self.boxheight*2+self.boxpadding, w = self.innerboxheight, h = self.innerboxheight}, true)
  elseif(i<33)then
    i= i -24
    screen:copyfrom(self.image1, nil, { x = self.startx +self.boxheight * (i - 1)+self.boxpadding,
      y =self.starty+self.boxheight*3+self.boxpadding, w = self.innerboxheight, h = self.innerboxheight }, true)
  else
    i= i -32
    screen:copyfrom(self.image1, nil, { x = self.startx +self.boxheight * (i - 1)+self.boxpadding,
      y =self.starty+self.boxheight*4+self.boxpadding, w = self.innerboxheight, h = self.innerboxheight }, true)
  end

  self.image1:destroy()
end

-------------------------------------
-- Prints a tile in color of goal.
-- @param i Place of goal
-- @author Erik
-------------------------------------
function Map:setGoal(i)

  if(i<9)then
    screen:clear({ g = 194, r = 225, b = 42}, { x = self.startx +self.boxheight * (i - 1)+self.boxpadding,
      y = self.starty+self.boxpadding,w = self.innerboxheight, h = self.innerboxheight })
  elseif(i<17)then
    i= i -8
    screen:clear({ g = 194, r = 225, b = 42 }, { x = self.startx +self.boxheight * (i - 1)+self.boxpadding,
      y = self.starty+self.boxheight+self.boxpadding,w = self.innerboxheight, h = self.innerboxheight })
  elseif(i<25)then
    i= i -16
    screen:clear({g = 194, r = 225, b = 42 }, { x = self.startx +self.boxheight * (i - 1)+self.boxpadding,
      y = self.starty+self.boxheight*2+self.boxpadding,w = self.innerboxheight, h = self.innerboxheight })
  elseif(i<33)then
    i= i -24
    screen:clear({ g = 194, r = 225, b = 42 }, { x = self.startx +self.boxheight * (i - 1)+self.boxpadding,
      y = self.starty+self.boxheight*3+self.boxpadding,w = self.innerboxheight, h = self.innerboxheight })
  else
    i= i -32
    screen:clear({ g = 194, r = 225, b = 42 }, { x = self.startx +self.boxheight * (i - 1)+self.boxpadding,
      y = self.starty+self.boxheight*4+self.boxpadding,w = self.innerboxheight, h = self.innerboxheight })
  end
end

-------------------------------------
-- Prints a tile in color of start.
-- @param i Place of start
-- @author Erik
-------------------------------------
function Map:setStart(i)

  if(i<9)then
    screen:clear({ g = 240, r = 19, b = 56}, { x = self.startx +self.boxheight * (i - 1)+self.boxpadding,
      y = self.starty+self.boxpadding,w = self.innerboxheight, h = self.innerboxheight })
  elseif(i<17)then
    i= i -8
    screen:clear({ g = 240, r = 19, b = 56 }, { x = self.startx +self.boxheight * (i - 1)+self.boxpadding,
      y = self.starty+self.boxheight+self.boxpadding,w = self.innerboxheight, h = self.innerboxheight })
  elseif(i<25)then
    i= i -16
    screen:clear({g = 240, r = 19, b = 56 }, { x = self.startx +self.boxheight * (i - 1)+self.boxpadding,
      y = self.starty+self.boxheight*2+self.boxpadding,w = self.innerboxheight, h = self.innerboxheight })
  elseif(i<33)then
    i= i -24
    screen:clear({ g = 240, r = 19, b = 56 }, { x = self.startx +self.boxheight * (i - 1)+self.boxpadding,
      y = self.starty+self.boxheight*3+self.boxpadding,w = self.innerboxheight, h = self.innerboxheight })
  else
    i= i -32
    screen:clear({ g = 240, r = 19, b = 56 }, { x = self.startx +self.boxheight * (i - 1)+self.boxpadding,
      y = self.starty+self.boxheight*4+self.boxpadding,w = self.innerboxheight, h = self.innerboxheight })
  end
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
  if(i<9)then
    self:drawBox(tile,self.startx +self.boxheight * (i - 1),self.starty )
  elseif(i<17)then
    i= i -8
    self:drawBox(tile,self.startx +self.boxheight * (i - 1),self.starty+self.boxheight )
  elseif(i<25)then
    i= i -16
    self:drawBox(tile,self.startx +self.boxheight * (i - 1) ,self.starty+self.boxheight*2 )
  elseif(i<33)then
    i= i -24
    self:drawBox(tile,self.startx +self.boxheight * (i - 1) ,self.starty+self.boxheight*3 )
  else
    i= i -32
    self:drawBox(tile,self.startx +self.boxheight * (i - 1),self.starty+self.boxheight*4 )

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
    self:drawStandardBox(xPos,yPos)
    if tile.topBorder then
      self:drawTopBorder(xPos,yPos)
    end
    if tile.leftBorder then
      self:drawLeftBorder(xPos,yPos)
    end
    if tile.rightBorder then
      self:drawRightBorder(xPos,yPos)
    end
    if tile.bottomBorder then
      self:drawBottomBorder(xPos,yPos)
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
  screen:clear({ g = 28, r = 70, b = 122 }, { x = xPos, y = yPos,w = self.boxheight, h = self.boxheight })
  screen:clear({ g = 83, r = 101, b = 219 }, { x = xPos+self.boxpadding, y = yPos+self.boxpadding,
    w = self.innerboxheight, h = self.innerboxheight })
end

-------------------------------------
-- Prints a border on the top of the tile.
-- @param xPos X placement of tile
-- @param yPos Y placement of tile
-- @author Erik
-------------------------------------
function Map:drawTopBorder(xPos, yPos)
  screen:clear({ g = 255, r = 255, b = 255 }, { x = xPos, y =yPos ,w = self.boxheight, h = self.borderthickness })
end

-------------------------------------
-- Prints a border on the bottom of the tile.
-- @param xPos X placement of tile
-- @param yPos Y placement of tile
-- @author Erik
-------------------------------------
function Map:drawBottomBorder(xPos, yPos)
  yPos = yPos+self.boxheight-self.borderthickness
  screen:clear({ g = 255, r = 255, b = 255 }, { x = xPos, y =yPos ,w = self.boxheight, h = self.borderthickness })
end

-------------------------------------
-- Prints a border on the left side of the tile.
-- @param xPos X placement of tile
-- @param yPos Y placement of tile
-- @author Erik
-------------------------------------
function Map:drawLeftBorder(xPos, yPos)
  screen:clear({ g = 255, r = 255, b = 255 }, { x = xPos, y = yPos,w = self.borderthickness, h = self.boxheight })
end

-------------------------------------
-- Prints a border on the right side of the tile.
-- @param xPos X placement of tile
-- @param yPos Y placement of tile
-- @author Erik
-------------------------------------
function Map:drawRightBorder(xPos, yPos)
  xPos = xPos+self.boxheight-self.borderthickness
  screen:clear({ g = 255, r = 255, b = 255 }, { x = xPos, y = yPos,w = self.borderthickness, h = self.boxheight })

end

return Map


