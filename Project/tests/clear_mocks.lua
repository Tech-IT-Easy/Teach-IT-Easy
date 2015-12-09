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
--
-- Created by IntelliJ IDEA.
-- User: Andreas Mansson
-- Date: 2015-12-03
-- Time: 15:24
-- To change this template use File | Settings | File Templates.
--

function clear_mock()
    package.preload["games.Progg.BottomMenu"]=nil
    package.preload["games.Progg.BuildArea"]=nil
    package.preload["games.Progg.Character"]=nil
    package.preload["games.Progg.Commands"]=nil
    package.preload["games.Progg.DrawBottomMenu"]=nil
    package.preload["games.Progg.DrawBuildArea"]=nil
    package.preload["games.Progg.DrawRightMenu"]=nil
    package.preload["games.Progg.Map"]=nil
    package.preload["games.Progg.progg_skin"]=nil
    package.preload["games.Progg.ProggGame"]=nil
    package.preload["games.Progg.Queue"]=nil
    package.preload["games.Progg.RightMenu"]=nil
    package.preload["games.Progg.Tile"]=nil
    package.preload["games.GameFactory"]=nil
    package.preload["lib.json"]=nil
    package.preload["menus.ChooseAvatar"]=nil
    package.preload["menus.CreateProfile"]=nil
    package.preload["menus.Games"]=nil
    package.preload["menus.MainMenu"]=nil
    package.preload["menus.ProfileSelection"]=nil
    package.preload["menus.skin"]=nil
    package.preload["menus.TrophyRoom"]=nil
    package.preload["platform.PlatformContext"]=nil
    package.preload["platform.PlatformMenu"]=nil
    package.preload["platform.Profile"]=nil
    package.preload["platform.UIStartWindowController"]=nil
    package.preload["platform.UIStartWindowView"]=nil
    package.preload["toolkit.UIKit.UIButtonView"]=nil
    package.preload["toolkit.UIKit.UIImage"]=nil
    package.preload["toolkit.UIKit.UILabelView"]=nil
    package.preload["toolkit.UIKit.UIView"]=nil
    package.preload["toolkit.UIKit.UICollectionCellView"]=nil
    package.preload["toolkit.UIKit.UIImageView"]=nil
    package.preload["toolkit.UIKit.UILayoutView"]=nil
    package.preload["toolkit.UIKit.UIWindowViewController"]=nil
    package.preload["toolkit.UIKit.UICollectionView"]=nil
    package.preload["toolkit.UIKit.UIKeyboardView"]=nil
    package.preload["toolkit.UIKit.UIPanelView"]=nil
    package.preload["toolkit.UIKit.UIWindowView"]=nil
    package.preload["toolkit.UIKit.UIDefaultTheme"]=nil
    package.preload["toolkit.UIKit.UILabel"]=nil
    package.preload["toolkit.UIKit.UITextInputView"]=nil
    package.preload["toolkit.Utils.List"]=nil
    package.preload["toolkit.Utils.ListNode"]=nil
    package.preload["toolkit.Controllable"]=nil
    package.preload["toolkit.Event"]=nil
    package.preload["toolkit.EventHandler"]=nil
    package.preload["toolkit.EventListener"]=nil
    package.preload["toolkit.EventTimer"]=nil
    package.preload["toolkit.Game"]=nil
    package.preload["toolkit.GameProgress"]=nil
    package.preload["toolkit.Hook"]=nil
    package.preload["toolkit.MenuSuperClass"]=nil
    package.preload["toolkit.Object"]=nil
    package.preload["main"]=nil

    package.loaded["games.Progg.BottomMenu"]=nil
    package.loaded["games.Progg.BuildArea"]=nil
    package.loaded["games.Progg.Character"]=nil
    package.loaded["games.Progg.Commands"]=nil
    package.loaded["games.Progg.DrawBottomMenu"]=nil
    package.loaded["games.Progg.DrawBuildArea"]=nil
    package.loaded["games.Progg.DrawRightMenu"]=nil
    package.loaded["games.Progg.Map"]=nil
    package.loaded["games.Progg.progg_skin"]=nil
    package.loaded["games.Progg.ProggGame"]=nil
    package.loaded["games.Progg.Queue"]=nil
    package.loaded["games.Progg.RightMenu"]=nil
    package.loaded["games.Progg.Tile"]=nil
    package.loaded["games.GameFactory"]=nil
    package.loaded["lib.json"]=nil
    package.loaded["menus.ChooseAvatar"]=nil
    package.loaded["menus.CreateProfile"]=nil
    package.loaded["menus.Games"]=nil
    package.loaded["menus.MainMenu"]=nil
    package.loaded["menus.ProfileSelection"]=nil
    package.loaded["menus.skin"]=nil
    package.loaded["menus.TrophyRoom"]=nil
    package.loaded["platform.PlatformContext"]=nil
    package.loaded["platform.PlatformMenu"]=nil
    package.loaded["platform.Profile"]=nil
    package.loaded["platform.UIStartWindowController"]=nil
    package.loaded["platform.UIStartWindowView"]=nil
    package.loaded["toolkit.UIKit.UIButtonView"]=nil
    package.loaded["toolkit.UIKit.UIImage"]=nil
    package.loaded["toolkit.UIKit.UILabelView"]=nil
    package.loaded["toolkit.UIKit.UIView"]=nil
    package.loaded["toolkit.UIKit.UICollectionCellView"]=nil
    package.loaded["toolkit.UIKit.UIImageView"]=nil
    package.loaded["toolkit.UIKit.UILayoutView"]=nil
    package.loaded["toolkit.UIKit.UIWindowViewController"]=nil
    package.loaded["toolkit.UIKit.UICollectionView"]=nil
    package.loaded["toolkit.UIKit.UIKeyboardView"]=nil
    package.loaded["toolkit.UIKit.UIPanelView"]=nil
    package.loaded["toolkit.UIKit.UIWindowView"]=nil
    package.loaded["toolkit.UIKit.UIDefaultTheme"]=nil
    package.loaded["toolkit.UIKit.UILabel"]=nil
    package.loaded["toolkit.UIKit.UITextInputView"]=nil
    package.loaded["toolkit.Utils.List"]=nil
    package.loaded["toolkit.Utils.ListNode"]=nil
    package.loaded["toolkit.Controllable"]=nil
    package.loaded["toolkit.Event"]=nil
    package.loaded["toolkit.EventHandler"]=nil
    package.loaded["toolkit.EventListener"]=nil
    package.loaded["toolkit.EventTimer"]=nil
    package.loaded["toolkit.Game"]=nil
    package.loaded["toolkit.GameProgress"]=nil
    package.loaded["toolkit.Hook"]=nil
    package.loaded["toolkit.MenuSuperClass"]=nil
    package.loaded["toolkit.Object"]=nil
    package.loaded["main"]=nil
end