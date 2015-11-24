--
-- Created by IntelliJ IDEA.
-- User: daniel
-- Date: 2015-11-24
-- Time: 00:38
-- To change this template use File | Settings | File Templates.
--
local Object = require('toolkit.Object')

local http = require("socket.http")
local ltn12 = require("ltn12")
local json = require("lib.json")

Network = extends(Object)



function Network:new()
  local o = Network:super()

  return Network:init(o)
end


function Network:getFirstname()
  local t = {}
  http.request{
      url = "http://api.randomuser.me/?seed=techiteasy",
      -- url = "http://2015-3.pumi.ida.liu.se:9000/users/",
      sink = ltn12.sink.table(t)
  }
  table = table.concat(t)
  jsonResult = json.parse(table)
  -- For 2015-3.pumi
  -- return jsonResult[1].username
  -- For randomuser.me
  return jsonResult["results"][1].user.name.first
end

return Network
