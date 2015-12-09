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
-----------------------------------------------------------
-- SystemFreeType is a global variable for saving free type error
--
-- @Author:Created by Chuck, NOV 19,2015
-----------------------------------------------------------

if SystemFreeType == nil then
  SystemFreeType= {}
end

local script_path = nil
if ADConfig.isSimulator then
  script_path = ""
else
  script_path = sys.root_path()
end

function SystemFreeType:drawLabel(label,globalPosition)
  assert(label.identity and globalPosition,"SystemFreeType:getLabelData(label,globalPosition) label.identity or globalPosition is nil")
  local labelKey = label.identity..globalPosition.x..globalPosition.y
  if SystemFreeType[labelKey] == nil then
      SystemFreeType[labelKey] = sys.new_freetype(label.color, label.size, globalPosition,script_path..label.font)
  end
  SystemFreeType[labelKey]:draw_over_surface(screen, label.text)
end

return SystemFreeType