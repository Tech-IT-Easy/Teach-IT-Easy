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
-- This class is handles all the network connection.
--
-- @Author:Created by Daniel, Nov 24,2015
-----------------------------------------------------------

local Object = require('toolkit.Object')

local http = require("socket.http")
local ltn12 = require("ltn12")
local json = require("lib.json")
local server = require("Config.server")

Network = extends(Object)


-----------------------------------------------------------
-- Construct method
-- @return :Network a new instance of a network
-- @author Daniel
-----------------------------------------------------------
function Network:new()
  local o = Network:super()
  return Network:init(o)
end

-----------------------------------------------------------
-- Makes a HTTP request and parse the data and returns the firstname.
-- @return string with the firstname from the API request.
-- @author Daniel
-----------------------------------------------------------
function Network:getFirstname()
  local t = {}
  http.request{
      url = "http://api.randomuser.me/?seed=techiteasy",
      -- url = "http://2015-3.pumi.ida.liu.se:9000/users/",
      sink = ltn12.sink.table(t)
  }
  local table = table.concat(t)
  local jsonResult = json.parse(table)
  -- For 2015-3.pumi
  -- return jsonResult[1].username
  -- For randomuser.me
  return jsonResult["results"][1].user.name.first
end


function Network:getProgress(game, name)
  local t = {}
  local b, c, h = http.request{
    url = server.url.."/"..game.."/progress/"..name.."/",
    sink = ltn12.sink.table(t)
  }
  local table = table.concat(t)
  print(table)
  if c == 200 then -- HTTP STATUS 200
    print("Got progress from server")
    return json.parse(table)
  else
    print("No progress from server")
    if game == "games.Catch.Catch" then
        if name == "Knatte" then
            table = { level = 1, catchABC = false, catchKindergarten= false, catchElementary = false, catchPhd = false }
        elseif name == "Fnatte" then
            table = { level = 3, catchABC = true, catchKindergarten= false, catchElementary = false, catchPhd = false }
        elseif name == "Tjatte" then
            table = { level = 5, catchABC = true, catchKindergarten= true, catchElementary = false, catchPhd = false }
        else
            table = { level = 0, catchABC = false, catchKindergarten= false, catchElementary = false, catchPhd = false }
        end
    elseif game == "games.Progg.ProggGame" then
        if name == "Knatte" then
            table = {level = 1, proggGameBasicLevel = false, proggGameProcLevel= false, proggGameLoopLevel = false, proggGameMaster = false }
        elseif name == "Fnatte" then
            table = {level = 3, proggGameBasicLevel = true, proggGameProcLevel= false, proggGameLoopLevel = false, proggGameMaster = false }
        elseif name == "Tjatte" then
            table  = {level = 5, proggGameBasicLevel = true, proggGameProcLevel= true, proggGameLoopLevel = true, proggGameMaster = false }
        else
            table = {level = 0, proggGameBasicLevel = false, proggGameProcLevel= false, proggGameLoopLevel = false, proggGameMaster = false }
        end
    end
  end
  return table
end


function Network:pushProgress(game, name, progress)
  local t = {}
  local reqbody = json.stringify(progress)
  local b, c, h = http.request{
    method = "PUT",
    url = server.url.."/"..game.."/progress/"..name.."/",
    source = ltn12.source.string(reqbody),
    headers = {
      ["content-type"] = "application/json",
      ["content-length"] = tostring(#reqbody)
    },
    sink = ltn12.sink.table(t)

  }
  local table = table.concat(t)
  if c == 200 then -- HTTP STATUS 200
    print("Updated progress succesfully to server")
    return json.parse(table)
  else
    print("Couldnt update progress to server")
    return "Error"
  end
end


function Network:getLevels(game)
  local t = {}
  local b, c, h = http.request{
    url = server.url.."/"..game.."/levels/",
    sink = ltn12.sink.table(t)
  }
  local table = table.concat(t)
  if c == 200 then -- HTTP STATUS 200
    print("Got levels from server")
    return json.parse(table)
  else
    print("No levels from server")
  end
end

return Network
