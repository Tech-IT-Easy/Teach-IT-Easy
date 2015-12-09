# Change log
All notable changes between releases will be documented in this file.

## [v.0.1] - 2015-10-10
### New
- App runs on STB
- App shows four boxes for profile selection
- Responds to input from arrow keys
- Possible to move around between the boxes
- Shows background

## [v.0.2] - 2015-11-06
### New
- Possible to create new profile with profile name and avatar
- Profile selection menu now shows avatars
- Possible to click on the different profiles
- App responds on input from number keys
- Possible to go back in menus
- Main menu for each profile
- Game menu with images of different games
- Possible to launch programming game from game menu (loads image but not yet playable)
- Built basic structure for game
- Added fonts
- Implemented queue for game actions
- Added 'src' folder with all the code

### Changed
- New code structure

### Removed
- Emulator folder, all code is now in 'src'
- STB_Emulator_default folder, not used code

## [v.0.3] - 2015-11-24
### New
- Started implementing programming game
- Draw map in programming game
- Add, delete and move actions in queue
- Possible to execute queue
- Animation when avatar moves in the map
- Possible to move around in the bottom menu
- Implemented new UI-kit
- All the draw functions in separate classes
- Inheritance between menus
- Separate skin files for menu and programming game
- Back button in profile selection menu
- Possible to add procedures and loops in the queue

### Changed
- New avatars
- New eventhandler (new buttons for OK, back etc.)
- Not longer possible to add more than 4 profiles

## [v.1.0] - 2015-12-09
### New
-- Added reading game, Catch, to the platform
-- Finalized programming game, Teach IT Easy
-- Actions can now be executed
-- New avatars
-- Game progress is saved for each profile
-- Trophy room where a user can see progress and achievements for the different games
-- Different levels with increasing difficulty
-- All actions can now be added to the queue
-- Pop-ups when finishing a level and when backing out of programming game
-- Actions that are blocked in a certain level of programming game do not appear in the right menu
-- Added action for IF-statement and action for picking up a box in programming game
-- Possible to do recursion
-- Instructions menu with instructions on how to play the game
-- Settings menu for changing name, changing avatar or deleting profile
-- Added CodeAnalyser to generate UML-diagram
-- Added LevelGenerator for creating new levels
-- Added LuaDoc

### Changed
-- Refactored code

### Removed
-- Unused folder 'tests' in src-folder
-- Removed folder 'games/Mario' that contained old example code