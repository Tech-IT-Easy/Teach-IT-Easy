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
local levels = {}
levels = {
    {
      word="car",
      maxNumberOfGuesses = 10,
      wordImage = {imagePath="games/Catch/data/levels/car.png",imageType="png"}
    },
    {
      word="chair",
      maxNumberOfGuesses = 15,
      wordImage = {imagePath="games/Catch/data/levels/chair.png",imageType="png"}
    },
    {
      word="fruit",
      maxNumberOfGuesses = 20,
      wordImage = {imagePath="games/Catch/data/levels/fruit.png",imageType="png"}
    },
    {
      word="parrot",
      maxNumberOfGuesses = 25,
      wordImage = {imagePath="games/Catch/data/levels/parrot.png",imageType="png"}
    },
    {
      word="banana",
      maxNumberOfGuesses = 30,
      wordImage = {imagePath="games/Catch/data/levels/banana.png",imageType="png"}
    },
    {
      word="airplane",
      maxNumberOfGuesses = 35,
      wordImage = {imagePath="games/Catch/data/levels/airplane.png",imageType="png"}
    },
    {
      word="elephant",
      maxNumberOfGuesses = 40,
      wordImage = {imagePath="games/Catch/data/levels/elephant.png",imageType="png"}
    },
    {
      word="butterfly",
      maxNumberOfGuesses = 45,
      wordImage = {imagePath="games/Catch/data/levels/butterfly.png",imageType="png"}
    }
  }
  
return levels