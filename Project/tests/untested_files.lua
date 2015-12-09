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
require "games.Progg.BottomMenu"
require "games.Progg.BuildArea"
require "games.Progg.Character"
require "games.Progg.Commands"
require "games.Progg.DrawBottomMenu"
require "games.Progg.DrawBuildArea"
require "games.Progg.DrawRightMenu"
require "games.Progg.Map"
require "games.Progg.progg_skin"
require "games.Progg.ProggGame"
require "games.Progg.Queue"
require "games.Progg.RightMenu"
require "games.Progg.Tile"

require "games.GameFactory"

--require "lib.json"

require "menus.ChooseAvatar"
require "menus.CreateProfile"
require "menus.Games"
require "menus.MainMenu"
require "menus.ProfileSelection"
require "menus.skin"
require "menus.TrophyRoom"

require "platform.PlatformContext"
require "platform.PlatformMenu"
require "platform.Profile"

require "toolkit.UIKit.UIButtonView"
require "toolkit.UIKit.UIImage"
require "toolkit.UIKit.UILabelView"
require "toolkit.UIKit.UIView"
require "toolkit.UIKit.UICollectionCellView"
require "toolkit.UIKit.UIImageView"
require "toolkit.UIKit.UILayoutView"
require "toolkit.UIKit.UIWindowViewController"
require "toolkit.UIKit.UICollectionView"
require "toolkit.UIKit.UIKeyboardView"
require "toolkit.UIKit.UIPanelView"
require "toolkit.UIKit.UIWindowView"
require "toolkit.UIKit.UIDefaultTheme"
require "toolkit.UIKit.UILabel"
require "toolkit.UIKit.UITextInputView"

require "toolkit.Utils.List"
require "toolkit.Utils.ListNode"

require "toolkit.Controllable"
require "toolkit.Event"
require "toolkit.EventHandler"
require "toolkit.EventListener"
require "toolkit.EventTimer"
require "toolkit.Game"
require "toolkit.GameProgress"
require "toolkit.Hook"
require "toolkit.MenuSuperClass"
--require "toolkit.Network"
require "toolkit.Object"

--require "main"