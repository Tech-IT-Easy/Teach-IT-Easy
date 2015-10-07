local my_print = require "tests.example.my_print"
local my_func = {}

function my_func.plus(a, b)
	res = my_print.printer(a, b)
	return res
end
return my_func
