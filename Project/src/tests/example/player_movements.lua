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