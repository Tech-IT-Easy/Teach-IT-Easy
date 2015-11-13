-- This class represents the game map.

-- Created by IntelliJ IDEA.
-- User: Adam Lydén
-- Date: 2015-11-04
-- Time: 13:57


local Object = require('toolkit.Object')

local Map = extends(Object)

-------------------------------------
-- Creates new Map object.
-- @return (if needed)
-- @author name
-------------------------------------
function Map:new()
  local o = Map:super()

  return Map:init(o)
end


function Map:load()

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

  -- 1 = free space
  -- 2 = all side block?
  -- 3 = blocked above
  -- 4 = blocked underneth
  -- 5 = blocked to left
  -- 6 = blocked to right
  -- 7 = More combinations under development


  -- Mapdata that is being displayed
  self.mapdata =
    {9, "a", "c", 0, 0, 0, 0, 0,
      5, 5, 3, "c", 0, 0, 0, 0,
      5, 1, 0, 0, 0, 0, 0, 0,
      5, 1, 0, 0, "f", 0, 0, 0,
      7, 3, 0, 0, 0, 0, 0, 0,}

  self.goalPos = 20
  self.startPos = 33
  self.charPos = 2

  --Loop builds map
  for i = 1, 40, 1 do
    self:square(i, self.mapdata[i])
  end
  self:setGoal(self.goalPos)
  self:setStart(self.startPos)
  self:setCharacter(self.charPos)

end

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


function Map:square(i, type)
  if(i<9)then
    self:drawBox(type,self.startx +self.boxheight * (i - 1),self.starty )
  elseif(i<17)then
    i= i -8
    self:drawBox(type,self.startx +self.boxheight * (i - 1),self.starty+self.boxheight )
  elseif(i<25)then
    i= i -16
    self:drawBox(type,self.startx +self.boxheight * (i - 1) ,self.starty+self.boxheight*2 )
  elseif(i<33)then
    i= i -24
    self:drawBox(type,self.startx +self.boxheight * (i - 1) ,self.starty+self.boxheight*3 )
  else
    i= i -32
    self:drawBox(type,self.startx +self.boxheight * (i - 1),self.starty+self.boxheight*4 )

  end

end


function Map:drawBox(type, xPos, yPos)

  if(type ~="f")then
    self:drawStandardBox(xPos,yPos)

    if (type ==1) then
      self:drawLeftBorder(xPos, yPos)
    elseif (type ==2) then
      self:drawBottomBorder(xPos, yPos)
    elseif (type ==3) then
      self:drawLeftBorder(xPos, yPos)
      self:drawBottomBorder(xPos, yPos)
    elseif (type ==4) then
      self:drawRightBorder(xPos, yPos)
    elseif (type ==5) then
      self:drawRightBorder(xPos, yPos)
      self:drawLeftBorder(xPos, yPos)
    elseif (type ==6) then
      self:drawRightBorder(xPos, yPos)
      self:drawBottomBorder(xPos, yPos)
    elseif (type ==7) then
      self:drawRightBorder(xPos, yPos)
      self:drawBottomBorder(xPos, yPos)
      self:drawLeftBorder(xPos, yPos)
    elseif (type ==8) then
      self:drawTopBorder(xPos, yPos)
    elseif (type ==9) then
      self:drawTopBorder(xPos, yPos)
      self:drawLeftBorder(xPos, yPos)
    elseif (type =="a") then
      self:drawTopBorder(xPos, yPos)
      self:drawBottomBorder(xPos, yPos)
    elseif (type =="b") then
      self:drawTopBorder(xPos, yPos)
      self:drawLeftBorder(xPos, yPos)
      self:drawBottomBorder(xPos, yPos)
    elseif (type =="c") then
      self:drawTopBorder(xPos, yPos)
      self:drawRightBorder(xPos, yPos)
    elseif (type =="d") then
      self:drawTopBorder(xPos, yPos)
      self:drawLeftBorder(xPos, yPos)
      self:drawRightBorder(xPos, yPos)
    elseif (type =="e") then
      self:drawTopBorder(xPos, yPos)
      self:drawRightBorder(xPos, yPos)
      self:drawBottomBorder(xPos, yPos)
    end
  end

end

function Map:drawStandardBox(xPos, yPos)
  screen:clear({ g = 28, r = 70, b = 122 }, { x = xPos, y = yPos,w = self.boxheight, h = self.boxheight })
  screen:clear({ g = 83, r = 101, b = 219 }, { x = xPos+self.boxpadding, y = yPos+self.boxpadding,
    w = self.innerboxheight, h = self.innerboxheight })
end

function Map:drawTopBorder(xPos, yPos)
  screen:clear({ g = 255, r = 255, b = 255 }, { x = xPos, y =yPos ,w = self.boxheight, h = self.borderthickness })

end
function Map:drawBottomBorder(xPos, yPos)
  yPos = yPos+self.boxheight-self.borderthickness
  screen:clear({ g = 255, r = 255, b = 255 }, { x = xPos, y =yPos ,w = self.boxheight, h = self.borderthickness })
end
function Map:drawLeftBorder(xPos, yPos)
  screen:clear({ g = 255, r = 255, b = 255 }, { x = xPos, y = yPos,w = self.borderthickness, h = self.boxheight })
end
function Map:drawRightBorder(xPos, yPos)
  xPos = xPos+self.boxheight-self.borderthickness
  screen:clear({ g = 255, r = 255, b = 255 }, { x = xPos, y = yPos,w = self.borderthickness, h = self.boxheight })

end

return Map


