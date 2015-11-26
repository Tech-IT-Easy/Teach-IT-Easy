--
-- Created by IntelliJ IDEA.
-- User: jonathan
-- Date: 2015-11-26
-- Time: 10:55
-- To change this template use File | Settings | File Templates.
--

lunit = require "lunit"
module( "Main_test", package.seeall, lunit.testcase )


main = require "main" -- import the main file

-------------------------------------
-- System test 1
-- Run the first level
-- @system_under_test: main.lua
-- @author name: Jonathan Anderson
-------------------------------------
function test_file()
    onStart()
    onKey("ok","down")
    onKey("ok","down")
    onKey("ok","down")
    -- for key,value in pairs(platformContext.game.bottomMenu.character) do print(key,value) end

    onKey("1","down")
    onKey("1","down")
    onKey("1","down")
    onKey("1","down")
    onKey("3","down")
    onKey("1","down")
    onKey("1","down")
    onKey("3","down")
    onKey("1","down")
    onKey("2","down")
    onKey("1","down")
    onKey("3","down")
    onKey("1","down")
    onKey("0","down")

    while(0<#platformContext.game.bottomMenu.character.queue.actions or platformContext.game.bottomMenu.character.onP1 or platformContext.game.bottomMenu.character.onP2 or platformContext.game.bottomMenu.character.onLoop) do
        start()
    end

    --Must run one more time, to get path coverage in end of execution
    start()
    lunit.assert_true(platformContext.game.bottomMenu.character.hasWon)
end