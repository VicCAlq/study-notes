-- Loops are faster than recursion

local fib_mt = {
	__index = function(self, key)
		if key < 2 then
			return 1
		end
		-- Recursion starts here, saving intermediate results and updating the table
		self[key] = self[key - 2] + self[key - 1]
		return self[key]
	end,
}

local fib = setmetatable({}, fib_mt)

local function nacci(n)
	if n <= 1 then
		return n
	end

	local a, b, next = 0, 1, 0

	for i = 1, n do
		next = a + b
		a = b
		b = next
	end

	return b
end

local function time_test(n)
	local start = os.clock()
	print(fib[n])
	print("Recursion time for " .. n .. " fibs is " .. (os.clock() - start) * 1000)

	local init = os.clock()
	print(nacci(n))
	print("Loop time for " .. n .. " fibs is " .. (os.clock() - init) * 1000)
end

-- time_test(16366) -- Max number supported by LuaJit
-- time_test(392) -- Max number supported by Lua 5.1
-- time_test(392) -- Max number supported by Lua 5.4
time_test(8) -- Example with small number
