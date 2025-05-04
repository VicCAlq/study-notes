local loaded_file = loadfile("path/to/file.lua")
loaded_file()
print(found_me("John Lua"))

-- Different way, check the loaded file
local loaded_multi_args = loadfile("path/to/multi_args.lua")
print(loaded_multi_args(1, 2, 3, 4, 5, 6)) -- returns 21

local loaded_string = loadstring("function lucky() return 7 end")
loaded_string()
print(lucky()) -- returns 7

local loaded_load_as_string = load("function mult(a, b) return a * b end")
loaded_load_as_string()
print(mult(21, 2))
