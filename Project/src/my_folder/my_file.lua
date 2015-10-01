--
-- Created by IntelliJ IDEA.
-- User: jonathan
-- Date: 2015-10-01
-- Time: 16:30
-- To change this template use File | Settings | File Templates.
--

local my_file = {}

function my_file.addition_of_positive_numbers(a, b)
    if a < 0 then
        a = a * -1
    else
        a = a * 1
    end
    if b < 0 then
        b = b * -1
    else
        b = b * 1
    end
    return a+b
end


function my_file.movePlayerUp(player, dt)
    if player.y > (love.graphics.getHeight() / 2) then
        player.y = player.y - (player.speed*dt)
    end
end

return my_file




