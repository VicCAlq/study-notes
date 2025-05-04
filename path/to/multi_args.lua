local arguments = { ... }

local res = 0

for _, v in ipairs(arguments) do
	res = res + v
end

return res
