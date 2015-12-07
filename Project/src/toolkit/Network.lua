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
    url = "http://localhost:8000/progress/"..name.."/",
    sink = ltn12.sink.table(t)
  }
  local table = table.concat(t)
  print(table)
  if c == 200 then -- HTTP STATUS 200
    print("Got progress from server")
    return json.parse(table)
  else
    print("No progress from server")
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
  return table
end


function Network:pushProgress(game, name, progress)
  local t = {}
  local reqbody = json.stringify(progress)
  local b, c, h = http.request{
    method = "PUT",
    url = "http://localhost:8000/progress/"..name.."/",
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
  end
  return table
end


function Network:getLevels(game)
  local t = {}
  local b, c, h = http.request{
    --url = server.url.. game .."/levels/",
    url = "http://localhost:8000/levels/",
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
