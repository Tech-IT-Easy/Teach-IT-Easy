#!/bin/bash
export LUA_PATH="/usr/local/share/lua/5.2/?.lua;/usr/local/share/lua/5.2/?/init.lua;/usr/local/lib/lua/5.2/?.lua;/usr/local/lib/lua/5.2/?/init.lua;/usr/share/lua/5.2/?.lua;/usr/share/lua/5.2/?/init.lua;./?.lua;./?/init.lua;./tests/lemock/?.lua;./tests/luacov/src/?.lua;./tests/lunit/?.lua"
export LUA_CPATH="/usr/local/lib/lua/5.2/?.so;/usr/lib/x86_64-linux-gnu/lua/5.2/?.so;/usr/lib/lua/5.2/?.so;/usr/local/lib/lua/5.2/loadall.so;./?.so"
tests/lunit/lunit tests/init.lua
EXITCODE=$?
if [ $EXITCODE -ne 0 ]
  then
    exit 1
fi
STAT_FILE="$(ls tests/luacov/luacov.report.* | sort -n -t _ -k 2 -r | head -1)"
OUTPUT=$STAT_FILE'.xml'
lua tests/luacov/src/bin/luacov-cobertura -o "tests/luacov/coverage.xml"
rm tests/luacov/luacov.stats.out