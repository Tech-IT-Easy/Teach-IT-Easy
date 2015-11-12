-- Under development... feel free to add, edit, remove
-- This class represents the game map.

-- Created by IntelliJ IDEA.
-- User: Adam Lydén
-- Date: 2015-11-04
-- Time: 13:57


local Object = require('toolkit.Object')

local Map = extends(Object)

function Map:new()
  local o = Map:super()

  return Map:init(o)
end


function Map:load()
  self.background = gfx.loadpng('data/game_background_small.png')
  screen:copyfrom(self.background, nil, { x = 0, y = 0, w = screen:get_width()*0.75, h = screen:get_height()*0.65 }, true)
  self.background:destroy()

  self.boxheight = (screen:get_height()*0.65)/6
  local padding = (screen:get_width()*0.75)-(self.boxheight * 8)
  self.startx = padding/2
  self.starty = self.boxheight/2
  self.innerboxheight = self.boxheight-14
  self.boxpadding = 7
  self.borderthickness = self.boxheight*0.07


  --screen:clear({ r = 0, g = 0, b = 0 }, { x = screen:get_width() * 0.05, y = screen:get_height()*0.05, w = screen:get_width() * 0.65, h = screen:get_height()*0.55 })
  --screen:clear({ r = 55, g = 72, b = 160 }, { x = screen:get_width() * 0.055, y = screen:get_height()*0.06, w = screen:get_width() * 0.64, h = screen:get_height()*0.532 })


  -- 1 = free space
  -- 2 = all side block?
  -- 3 = blocked above
  -- 4 = blocked underneth
  -- 5 = blocked to left
  -- 6 = blocked to right
  -- 7 = More combinations under development


  -- Mapdata that is being displayed
  self.mapdata =
    {0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0,}

  --Loop builds map
  for i = 1, 40, 1 do
    self:square(i, self.mapdata[i])
  end

end

function Map:update()

end

function Map:square(i, type)

  local boxwidth = self.boxheight
  local boxheight = self.boxheight

  local leftmargin = self.startx
  local topmargin = self.starty
  local borderthickness = 5

  if(i<9)then
    self:drawBox(type,leftmargin +boxwidth * (i - 1) +1 *(i -1),topmargin )
    -- screen:clear({ g = 83, r = 101, b = 219 }, { x = leftmargin +boxwidth * (i - 1) +1 *(i -1), y = topmargin, w = boxwidth, h = boxheight })
  elseif(i<17)then
    i= i -8
    self:drawBox(type,leftmargin +boxwidth * (i - 1) +1 *(i -1),topmargin+boxheight+1 )

    --screen:clear({ g = 83, r = 101, b = 219 }, { x = leftmargin + boxwidth * (i - 1) +1 *(i -1), y = topmargin+boxheight+1, w = boxwidth, h = boxheight })

  elseif(i<25)then
    i= i -16
    self:drawBox(type,leftmargin +boxwidth * (i - 1) +1 *(i -1),topmargin+boxheight*2+1*2 )

    --screen:clear({ g = 83, r = 101, b = 219 }, { x = leftmargin + boxwidth * (i - 1)+1 *(i -1), y = topmargin+boxheight*2+1*2 ,w = boxwidth, h = boxheight })

  elseif(i<33)then
    i= i -24
    self:drawBox(type,leftmargin +boxwidth * (i - 1) +1 *(i -1),topmargin+boxheight*3+1*3 )

    --screen:clear({ g = 83, r = 101, b = 219 }, { x = leftmargin + boxwidth * (i - 1)+1 *(i -1), y = topmargin+boxheight*3+1*3, w = boxwidth, h = boxheight })

  else
    i= i -32
    self:drawBox(type,leftmargin +boxwidth * (i - 1) +1 *(i -1),topmargin+boxheight*4+1*4 )

    --screen:clear({ g = 83, r = 101, b = 219 }, { x = leftmargin + boxwidth * (i - 1)+1 *(i -1), y = topmargin+boxheight*4+1*4, w = boxwidth, h = boxheight })

  end
end


function Map:drawBox(type, xPos, yPos)

  -- screen:clear({ g = 83, r = 101, b = 219 }, { x = xPos, y = yPos,w = self.boxheight, h = self.boxheight })
  --screen:clear({ g = 200, r = 200, b = 200 }, { x = xPos+self.boxpadding, y = yPos+self.boxpadding,w = self.innerboxheight, h = self.innerboxheight })

  if(type ~=16)then
    self:drawStandardBox(xPos,yPos)
  end

  --[[
  if (type ~= e) then
    self.drawStandardBox(xPos,yPos)
  end

  if (type ==1) then


  elseif (type ==2) then




  elseif (type ==3) then




  elseif (type ==4) then



  elseif (type ==5) then



  elseif (type ==6) then



  elseif (type ==7) then




  elseif (type ==8) then



  elseif (type ==9) then




  elseif (type ==9) then




  elseif (type ==10) then




  elseif (type ==11) then



  elseif (type ==12) then




  elseif (type ==13) then



  elseif (type ==14) then



  elseif (type ==15) then

  else --(type ==16) then


  end
]]
end

function Map:drawStandardBox(xPos, yPos)
  screen:clear({ g = 28, r = 70, b = 122 }, { x = xPos, y = yPos,w = self.boxheight, h = self.boxheight })
  screen:clear({ g = 83, r = 101, b = 219 }, { x = xPos+self.boxpadding, y = yPos+self.boxpadding,w = self.innerboxheight, h = self.innerboxheight })

  --screen:clear({ g = 83, r = 101, b = 219 }, { x = xPos, y = yPos,w = self.boxheight, h = self.boxheight })
  --screen:clear({ g = 83, r = 101, b = 219 }, { x = xPos, y = yPos,w = self.boxheight, h = self.boxheight })
end

function Map:drawTopBorder(x, y)
end
function Map:drawBottomBorder(x, y)
end
function Map:drawLeftBorder(x, y)
end
function Map:drawRightBorder(x, y)
end




function Map:printsquare(i, mapdata)

  local boxwidth = 68
  local boxheight = 68
  local leftmargin = 80
  local topmargin = 50
  local borderthickness = 5

  if mapdata[i]==0 then

    if(i<9)then

      screen:clear({ g = 83, r = 101, b = 219 }, { x = leftmargin +boxwidth * (i - 1) +1 *(i -1), y = topmargin, w = boxwidth, h = boxheight })
    elseif(i<17)then
      i= i -8
      screen:clear({ g = 83, r = 101, b = 219 }, { x = leftmargin + boxwidth * (i - 1) +1 *(i -1), y = topmargin+boxheight+1, w = boxwidth, h = boxheight })

    elseif(i<25)then
      i= i -16
      screen:clear({ g = 83, r = 101, b = 219 }, { x = leftmargin + boxwidth * (i - 1)+1 *(i -1), y = topmargin+boxheight*2+1*2 ,w = boxwidth, h = boxheight })

    elseif(i<33)then
      i= i -24
      screen:clear({ g = 83, r = 101, b = 219 }, { x = leftmargin + boxwidth * (i - 1)+1 *(i -1), y = topmargin+boxheight*3+1*3, w = boxwidth, h = boxheight })

    else
      i= i -32
      screen:clear({ g = 83, r = 101, b = 219 }, { x = leftmargin + boxwidth * (i - 1)+1 *(i -1), y = topmargin+boxheight*4+1*4, w = boxwidth, h = boxheight })

    end
  end

  if mapdata[i]==2 then
    if(i<9)then

      screen:clear({ g = 83, r = 101, b = 219 }, { x = leftmargin +boxwidth * (i - 1) +1 *(i -1), y = topmargin, w = boxwidth, h = boxheight })

    elseif(i<17)then
      i= i -8

      screen:clear({ g = 83, r = 101, b = 219 }, { x = leftmargin + boxwidth * (i - 1) +1 *(i -1), y = topmargin+boxheight+1, w = boxwidth, h = boxheight })

    elseif(i<25)then
      i= i -16

      screen:clear({ g = 83, r = 101, b = 219 }, { x = leftmargin + boxwidth * (i - 1)+1 *(i -1), y = topmargin+boxheight*2+2 ,w = boxwidth, h = boxheight })

    elseif(i<33)then
      i= i -24

      screen:clear({ g = 83, r = 101, b = 219 }, { x = leftmargin + boxwidth * (i - 1)+1 *(i -1), y = topmargin+boxheight*3+3, w = boxwidth, h = boxheight })

    else
      i= i -32

      screen:clear({ g = 83, r = 101, b = 219 }, { x = leftmargin + boxwidth * (i - 1)+1 *(i -1), y = topmargin+boxheight*4+4, w = boxwidth, h = boxheight })


    end
  end

  if mapdata[i]==3 then

    if(i<9)then

      screen:clear({ g = 83, r = 101, b = 219 }, { x = leftmargin +boxwidth * (i - 1) +1 *(i -1), y = topmargin, w = boxwidth, h = boxheight })
      screen:clear({ g = 0, r = 0, b = 0 }, { x = leftmargin +boxwidth * (i - 1) +1 *(i -1), y = topmargin, w = boxwidth, h = borderthickness })

    elseif(i<17)then
      i= i -8
      screen:clear({ g = 83, r = 101, b = 219 }, { x = leftmargin + boxwidth * (i - 1) +1 *(i -1), y = topmargin+boxheight+1, w = boxwidth, h = boxheight })
      screen:clear({ g = 0, r = 0, b = 0 }, { x = leftmargin +boxwidth * (i - 1) +1 *(i -1), y = topmargin+boxheight+1, w = boxwidth, h = borderthickness })

    elseif(i<25)then
      i= i -16
      screen:clear({ g = 83, r = 101, b = 219 }, { x = leftmargin + boxwidth * (i - 1)+1 *(i -1), y = topmargin+boxheight*2+1*2 ,w = boxwidth, h = boxheight })
      screen:clear({ g = 0, r = 0, b = 0 }, { x = leftmargin +boxwidth * (i - 1) +1 *(i -1), y = topmargin+boxheight*2+2, w = boxwidth, h = borderthickness })

    elseif(i<33)then
      i= i -24
      screen:clear({ g = 83, r = 101, b = 219 }, { x = leftmargin + boxwidth * (i - 1)+1 *(i -1), y = topmargin+boxheight*3+1*3, w = boxwidth, h = boxheight })
      screen:clear({ g = 0, r = 0, b = 0 }, { x = leftmargin +boxwidth * (i - 1) +1 *(i -1), y = topmargin+boxheight*3+3, w = boxwidth, h = borderthickness })

    else
      i= i -32
      screen:clear({ g = 83, r = 101, b = 219 }, { x = leftmargin + boxwidth * (i - 1)+1 *(i -1), y = topmargin+boxheight*4+1*4, w = boxwidth, h = boxheight })
      screen:clear({ g = 0, r = 0, b = 0 }, { x = leftmargin +boxwidth * (i - 1) +1 *(i -1), y = topmargin+boxheight*4+4, w = boxwidth, h = borderthickness })

    end




  end







  if mapdata[i]==4 then
    if(i<9)then

      screen:clear({ g = 83, r = 101, b = 219 }, { x = leftmargin +boxwidth * (i - 1) +1 *(i -1), y = topmargin, w = boxwidth, h = boxheight })
      screen:clear({ g = 0, r = 0, b = 0 }, { x = leftmargin +boxwidth * (i - 1) +1 *(i -1), y = topmargin+boxheight-borderthickness, w = boxwidth, h = borderthickness })

    elseif(i<17)then
      i= i -8
      screen:clear({ g = 83, r = 101, b = 219 }, { x = leftmargin + boxwidth * (i - 1) +1 *(i -1), y = topmargin+boxheight+1, w = boxwidth, h = boxheight })
      screen:clear({ g = 0, r = 0, b = 0 }, { x = leftmargin +boxwidth * (i - 1) +1 *(i -1), y = topmargin+boxheight*2+1-borderthickness, w = boxwidth, h = borderthickness })

    elseif(i<25)then
      i= i -16
      screen:clear({ g = 83, r = 101, b = 219 }, { x = leftmargin + boxwidth * (i - 1)+1 *(i -1), y = topmargin+boxheight*2+1*2 ,w = boxwidth, h = boxheight })
      screen:clear({ g = 0, r = 0, b = 0 }, { x = leftmargin +boxwidth * (i - 1) +1 *(i -1), y = topmargin+boxheight*3+2-borderthickness, w = boxwidth, h = borderthickness })

    elseif(i<33)then
      i= i -24
      screen:clear({ g = 83, r = 101, b = 219 }, { x = leftmargin + boxwidth * (i - 1)+1 *(i -1), y = topmargin+boxheight*3+1*3, w = boxwidth, h = boxheight })
      screen:clear({ g = 0, r = 0, b = 0 }, { x = leftmargin +boxwidth * (i - 1) +1 *(i -1), y = topmargin+boxheight*4+3-borderthickness, w = boxwidth, h = borderthickness })

    else
      i= i -32
      screen:clear({ g = 83, r = 101, b = 219 }, { x = leftmargin + boxwidth * (i - 1)+1 *(i -1), y = topmargin+boxheight*4+1*4, w = boxwidth, h = boxheight })
      screen:clear({ g = 0, r = 0, b = 0 }, { x = leftmargin +boxwidth * (i - 1) +1 *(i -1), y = topmargin+boxheight*5+4-borderthickness, w = boxwidth, h = borderthickness })


    end
  end


  if mapdata[i]==5 then
    if(i<9)then

      screen:clear({ g = 83, r = 101, b = 219 }, { x = leftmargin +boxwidth * (i - 1) +1 *(i -1), y = topmargin, w = boxwidth, h = boxheight })
      screen:clear({ g = 0, r = 0, b = 0 }, { x = leftmargin +boxwidth * (i - 1) +1 *(i -1), y = topmargin, w = borderthickness, h = boxheight})

    elseif(i<17)then
      i= i -8
      screen:clear({ g = 83, r = 101, b = 219 }, { x = leftmargin + boxwidth * (i - 1) +1 *(i -1), y = topmargin+boxheight+1, w = boxwidth, h = boxheight })
      screen:clear({ g = 0, r = 0, b = 0 }, { x = leftmargin +boxwidth * (i - 1) +1 *(i -1), y = topmargin+boxheight+1, w = borderthickness, h = boxheight })

    elseif(i<25)then
      i= i -16
      screen:clear({ g = 83, r = 101, b = 219 }, { x = leftmargin + boxwidth * (i - 1)+1 *(i -1), y = topmargin+boxheight*2+1*2 ,w = boxwidth, h = boxheight })
      screen:clear({ g = 0, r = 0, b = 0 }, { x = leftmargin +boxwidth * (i - 1) +1 *(i -1), y = topmargin+boxheight*2+2, w = borderthickness, h = boxheight })

    elseif(i<33)then
      i= i -24
      screen:clear({ g = 83, r = 101, b = 219 }, { x = leftmargin + boxwidth * (i - 1)+1 *(i -1), y = topmargin+boxheight*3+1*3, w = boxwidth, h = boxheight })
      screen:clear({ g = 0, r = 0, b = 0 }, { x = leftmargin +boxwidth * (i - 1) +1 *(i -1), y = topmargin+boxheight*3+3, w = borderthickness, h = boxheight })

    else
      i= i -32
      screen:clear({ g = 83, r = 101, b = 219 }, { x = leftmargin + boxwidth * (i - 1)+1 *(i -1), y = topmargin+boxheight*4+1*4, w = boxwidth, h = boxheight })
      screen:clear({ g = 0, r = 0, b = 0 }, { x = leftmargin +boxwidth * (i - 1) +1 *(i -1), y = topmargin+boxheight*4+4, w = borderthickness, h = boxheight })


    end
  end

  if mapdata[i]==6 then
    if(i<9)then

      screen:clear({ g = 83, r = 101, b = 219 }, { x = leftmargin +boxwidth * (i - 1) +1 *(i -1), y = topmargin, w = boxwidth, h = boxheight })
      screen:clear({ g = 0, r = 0, b = 0 }, { x = leftmargin+boxwidth+(boxwidth * (i -1))+1*(i - 1)-borderthickness, y = topmargin, w = borderthickness, h = boxheight})

    elseif(i<17)then
      i= i -8
      screen:clear({ g = 83, r = 101, b = 219 }, { x = leftmargin + boxwidth * (i - 1) +1 *(i -1), y = topmargin+boxheight+1, w = boxwidth, h = boxheight })
      screen:clear({ g = 0, r = 0, b = 0 }, { x = leftmargin+boxwidth+(boxwidth * (i -1))+1*(i - 1)-borderthickness, y= topmargin +boxheight+1, w = borderthickness, h = boxheight })

    elseif(i<25)then
      i= i -16
      screen:clear({ g = 83, r = 101, b = 219 }, { x = leftmargin + boxwidth * (i - 1)+1 *(i -1), y = topmargin+boxheight*2+1*2 ,w = boxwidth, h = boxheight })
      screen:clear({ g = 0, r = 0, b = 0 }, { x = leftmargin+boxwidth+(boxwidth * (i -1))+1*(i - 1)-borderthickness, y=topmargin +(boxheight*2)+2,  w = borderthickness, h = boxheight })

    elseif(i<33)then
      i= i -24
      screen:clear({ g = 83, r = 101, b = 219 }, { x = leftmargin + boxwidth * (i - 1)+1 *(i -1), y = topmargin+boxheight*3+1*3, w = boxwidth, h = boxheight })
      screen:clear({ g = 0, r = 0, b = 0 }, { x = leftmargin+boxwidth+(boxwidth * (i -1))+1*(i - 1)-borderthickness, y= topmargin +(boxheight*3)+3, w = borderthickness, h = boxheight })

    else
      i= i -32
      screen:clear({ g = 83, r = 101, b = 219 }, { x = leftmargin + boxwidth * (i - 1)+1 *(i -1), y = topmargin+boxheight*4+1*4, w = boxwidth, h = boxheight })
      screen:clear({ g = 0, r = 0, b = 0 }, { x = leftmargin+boxwidth+(boxwidth * (i -1))+1*(i - 1)-borderthickness, y= topmargin +(boxheight*4)+4, w = borderthickness, h = boxheight })

    end
  end


end


return Map


