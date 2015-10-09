--
-- Created by IntelliJ IDEA.
-- User: jonathan
-- Date: 2015-09-22
-- Time: 15:43
-- To change this template use File | Settings | File Templates.
--
local my_print = {}

function my_print.printer(a, b)
    --print("a+b: ", tostring(a+b))
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

return my_print


