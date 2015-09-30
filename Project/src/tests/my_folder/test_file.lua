lunit = require "lunit"
module( "test_my_folder_my_file", package.seeall, lunit.testcase )


function test_success()
  assert_false( false, "This test never fails.")
end

--
--function test_failure()
--  fail( "This test always fails!" )
--end
--

