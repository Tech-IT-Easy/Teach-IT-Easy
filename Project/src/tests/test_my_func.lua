
lunit = require "lunit"
my_func = require "tests.example.my_func"

module( "test_my_func", package.seeall, lunit.testcase )



function test_plus_positive_integers()
  res = my_func.plus(1,3)

  assert_equal(4, res, "Message if the test fails.")
end

function test_plus_negative_integers()
  res = my_func.plus(-1,-3)

  assert_equal(4, res, "Message if the test fails.")
end

function test_plus_one_negative_one_positive_integer()
  res = my_func.plus(1,-3)

  assert_equal(4, res, "Message if the test fails.")
end
