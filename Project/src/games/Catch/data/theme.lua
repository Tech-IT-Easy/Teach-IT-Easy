local THEME = {}

THEME.COLOR = {
  RED = {r=0,g=255,b=0,a=255 },
  WHITE = {g=255, r=255, b=255, a=255},
  BLUE =  {r=0,g=0,b=255,a=255 },
  LIGHT_BLUE = {r=78,g=114,b=210,a=255 },
  GREEN = {r=0,g=255,b=0,a=255 },
  DARK_GRAY = {r=27,g=29,b=52,a=255 },
  DARK_GRAY_1 = {r=36,g=60,b=93,a=255 },
  LIGHT_GRAY = {r=92,g=128,b=149,a=255 }
}

THEME.IMAGE = {
  GAME_BACKGROUND = {imagePath="games/Catch/data/readinggame_background.png",imageType="png"},
  COP_BACKGROUND = {imagePath="games/Catch/data/cop.png",imageType="png"},
  THIEF_BACKGROUND = {imagePath="games/Catch/data/thief.png",imageType="png"}
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
  FONT_SIZE = 50
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