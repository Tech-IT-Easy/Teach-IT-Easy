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
-- User: jonathan
-- Date: 2015-09-22
-- Time: 13:06
-- To change this template use File | Settings | File Templates.
--
love = require "love"
P = {}

function P.movePlayerLeft(player, dt)
    if player.x > 0 then
        player.x = player.x - (player.speed*dt)
    end
end

function P.movePlayerRight(player, dt)
    if player.x < (love.graphics.getWidth() - player.img:getWidth()) then
        player.x = player.x + (player.speed*dt)
    end
end

function P.movePlayerUp(player, dt)
    if player.y > (love.graphics.getHeight() / 2) then
        player.y = player.y - (player.speed*dt)
    end
end

function P.movePlayerDown(player, dt)
    if player.y < (love.graphics.getHeight() - 55) then
        player.y = player.y + (player.speed*dt)
    end
end

return P