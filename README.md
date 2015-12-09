# Technical description
The purpose of this document is to provide a high level technical description for the application Tech IT Easy. How main functions and modules are executed during the main success scenario will be described, as well as constraints of the software and suggestions for further development. Also a detailed map of the architecture will be found in this document.

## Flow of code for main success scenario
This section describes the main functions of the program in the way they are executed in order to accomplish a main success scenario. It should be a first read for developers to increase understandability before reviewing in-code comments and the actual code base.

### General
Input from the user is piped through a central event listener class which manages and standardises the input. An EventHandler super class is also provided to ensure conformity throughout the application. Each user-controllable class implements the super class to add the functionality needed.

### 1. Pick a profile
After loading main the game starts with drawing the menus.ProfileSelection menu where the user will choose one of the avatars from a list of avatars. This is printed by the function renderui().

### 2. Menu
After choosing a profile the menus.MainMenu will be loaded, rendering available menu items ChooseAvatar, CreateProfile, Games, ProfileSelection and TrophyRoom.

The handleinput(key.) in MainMenu handles button-clicks from the user and will send the input from the clicked button to move a new function. When the user clicks on the games icon, menus.Games will load. This class shows the user what games are available, currently games.Progg (The programming game) and games.Reading (The reading game).

After choosing the programming game menus.SelectLevel will display the unlocked levels through renderui (unlocked) and the levels that are not unlocked yet, lockedlevels(x1.). The function handleinput(event) will listen for and handle the input from the user, going to the chosen level.

### 3. Programming game
After choosing an unlocked level, the highest level module for the game, games.Progg.ProggGame, will initiate a new game on the chosen level. The method uses the functions load() and start() to load resources and launch the game. The update() function updates all objects that are part of the game and are displayed on the screen. After initiating the game and its resources, the following methods are used to build up the game functionality:


#### games.Progg.BottomMenu
This class keeps track of the images and position of the commands in the bottom menu based on how they're organized in the queue.

#### games.Progg.BuildArea
This class draws the build area and handles the building of procedures and loops

#### games.Progg.Character
This class represents the character and its position in the game.

#### games.Progg.DrawBottomMenu
Draw all empty command slots for current level.

#### games.Progg.DrawBuildArea
Draw all empty command slots for procedure/loop.

#### games.Progg.DrawRightMenu
This class keeps contains functions to draw elements in the right-hand menu

#### games.Progg.Map
Creates new Map object.

#### games.Progg.RightMenu
This class contains methods for interacting with the right-hand menu

#### games.Progg.Tile
This class represents the different types of tiles or "blocks" that is used by the map class.

#### games.Progg.progg_skin
This class keeps track of fixed positions and freetype objects that are used in the programming game module.

The game uses these methods do the tasks of drawing the game and allowing interaction through using Commands.

## Constraints of the software
The software will be run on the set-top-boxes of Zenterio on which data cannot be stored. The software will use Zenterio’s operating system and will have both online and offline functions. Since the set-top-box does not support sound settings, the application will not have background music or other sounds. The application is developed in 2D and does not contain graphical transparent elements due to lack of support from the set-top-box.

## Suggestion for further development
The application can be extended by adding more games to the platform. Since the games in the application is developed with educational purposes for children, additional games for the platform could be a math game and a geography game. The current games, programming and reading, could also be further developed with more levels and functions. Furthermore, the possibility to develop functionality to connect to social networks and share scores, have shared score boards, send friend requests and send game-challenges to friends could be investigated.
