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
-- User: johannaskolling
-- Date: 15-11-12
-- Time: 10:51
-- To change this template use File | Settings | File Templates.
--

lunit = require "lunit"
module( "Integration_commands_queue", package.seeall, lunit.testcase )
local event = require "toolkit.Event"
local SUT1 =  'games.Progg.Queue'
local SUT2 =  'games.Progg.Commands'

local function create_mock(class_to_mock)
  -- unload the package if loaded to dissmiss previous mocks
  package.loaded[class_to_mock] = nil
  package.preload[class_to_mock] = nil
  -- import lemock
  local lemock = require 'lemock'
  -- initiate mock controller
  local mc = lemock.controller()
  return mc
end

local function verify_mock(mc)
  local status, err = pcall(function ()
    -- Verify that the mocks has been called as stated.
    mc:verify()
  end)
  if err then -- if error fail the test.
    fail(err)
  end
end

function setup()

end

function teardown()
  package.loaded['games.Progg.Queue'] = nil
  package.preload['games.Progg.Queue'] = nil
end

--Add command to queue and check that this command exists in queue
function test_queue_with_commands()
  local class_to_mock = "games.Progg.BottomMenu"

  local mc = create_mock(class_to_mock)
  local drawIcons = mc:mock()
  local setQueue = mc:mock()

  --Only drawIcons in ButtomMenu need to be mocked. Reload class
  local ps=require(class_to_mock)

  package.loaded[class_to_mock].drawIcons = drawIcons
  package.loaded[class_to_mock].setQueue = setQueue

  -- import lemock
  -- local lemock = require 'lemock'

  -- local mc = lemock.controller()


  -- local drawIcons = mc:mock()

  drawIcons(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  setQueue(mc.ANYARGS) ;mc :returns(nil) :anytimes()
  mc:replay()

  --local newBottomMenu = require "games.Progg.BottomMenu"


  local ps1 = require(SUT2)
  local ps4=ps:new()

  local event = require "toolkit.Event"
  event.key = event.KEY_ONE

  local a = ps1:new(event)
 -- a.command = a.MOVE
 -- SUT1 =  'games.Progg.Queue'
 -- SUT2 =  'games.Progg.Commands'
  local bb = require(SUT1)
  local b = bb:new(ps4,nil)
  b:push(a,"queue")

  local c1 = b.actions[1]
  lunit.assert_equal(a, c1, "Did not found the correct element in the queue")
end