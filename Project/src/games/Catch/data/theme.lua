--[[TEACH IT EASY, an educational games platform
    Copyright (C) 2015  Linköping University

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.


    MIT LICENSE:
    Copyright (c) 2015 Zenterio AB

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:



    The above copyright notice and this permission notice shall be included in
    all copies or substantial portions of the Software.


    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
    THE SOFTWARE.


    ]]
local THEME = {}

THEME.COLOR = {
  RED = {r=0,g=255,b=0,a=255 },
  WHITE = {g=255, r=255, b=255, a=255},
  BLUE =  {r=0,g=0,b=255,a=255 },
  LIGHT_BLUE = {r=78,g=114,b=210,a=255 },
  GREEN = {r=0,g=255,b=0,a=255 },
  DARK_GRAY = {r=27,g=29,b=52,a=255 },
  DARK_GRAY_1 = {r=36,g=60,b=93,a=255 },
  LIGHT_GRAY = {r=92,g=128,b=149,a=255 },
  WHITE_HALF = { g = 228, r = 187, b = 235, a =255 },
  DARK_BLUE = { g = 131, r = 0, b = 143, a=255 }
}

THEME.IMAGE = {
  GAME_BACKGROUND = {imagePath="games/Catch/data/readinggame_background.png",imageType="png"},
  COP_BACKGROUND = {imagePath="games/Catch/data/cop.png",imageType="png"},
  THIEF_BACKGROUND = {imagePath="games/Catch/data/thief.png",imageType="png"},
  LOCK_LEVEL = {imagePath="games/Catch/data/lock.png",imageType="png"}
}
THEME.LEVEL = {
  ROWS = 2,
  COLUMNS = 4,
  RECTANGLE_SIZE = 200,
  RECTANGLE_SPACE = 20,
  FONT_SIZE = 50
}
THEME.MENU = {
  ROWS = 3,
  COLUMNS = 3,
  BORDER_WIDTH = 4,
  RECTANGLE_SIZE = 80,
  FONT_SIZE = 50,
  TIP_FONT_SIZE = 30
}

THEME.FRAME = {
  COP = {x=100,y=400,w=100,h=100},
  THIEF = {x=300,y=400,w=100,h=100},
  BUTTON = {x=1,y=1,w=THEME.MENU.RECTANGLE_SIZE,h=THEME.MENU.RECTANGLE_SIZE},
  RECTANGLE = {x=0,y=30,w=THEME.MENU.RECTANGLE_SIZE,h=THEME.MENU.RECTANGLE_SIZE}
}

THEME.WORDBOX = {
  RECTANGLE_SPACE = 10,
  RECTANGLE_SIZE = 80
}
THEME.DEFAULT = {
  MOVE_UNIT = 20
}


return THEME