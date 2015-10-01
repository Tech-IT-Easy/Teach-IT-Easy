lunit = require "lunit"

module( "simple_example", package.seeall, lunit.testcase )

function test_success()
  assert_true( true, "This test never fails.")
end
--
--function test_failure()
--  assert_true( "Hello World!", "This test always fails!")
--end
--

local foobar = nil

function setup()
  foobar = "Hello World"
end

function teardown()
  foobar = nil
end

function test1()
  assert_equal("Hello World", foobar)
  foobar = string.sub(foobar, 1, 5)
  assert_equal("Hell", foobar)
end

function test2()
  assert_equal("Hello World", foobar)
  foobar = string.sub(foobar, -5)
  assert_equal("World", foobar)
end
