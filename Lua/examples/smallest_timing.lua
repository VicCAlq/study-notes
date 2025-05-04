---@meta Checks the smallest integer fully divisible by every integer from 1 to x
--- Result for x = 20          = 232792560
--- Execution time for Lua 5.4 =       18s
--- Execution time for Lua 5.1 =       20s
--- Execution time for Luajit  =        3s
local start = os.time()
function Smallest_Multiple(x)
	local n = 1
	while true do
		for i = 1, x do
			if n % i ~= 0 then
				break
			elseif i == x then
				return n
			end
		end
		n = n + 1
	end
end
print(Smallest_Multiple(17))
local finish = os.time()
print(os.difftime(finish, start))
