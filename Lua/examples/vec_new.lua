#!/usr/bin/env lua5.4

---@Note ABOUT METATABLES
--- The first table passed to setmetatable can contain INSTANCE methods
--- The second table is the one who has CLASS methods
local Vec3
Vec3 = setmetatable({
  -- stylua: ignore start
	__add = function(A, B) return Vec3(A.x + B.x, A.y + B.y, A.z + B.z) end,
	__sub = function(A, B) return Vec3(A.x - B.x, A.y - B.y, A.z - B.z) end,
	__mul = function(A, B) return Vec3(A.x * B.x, A.y * B.y, A.z * B.z) end,
	__div = function(A, B) return Vec3(A.x / B.x, A.y / B.y, A.z / B.z) end,
	__unm = function(A) return Vec3(-A.x, -A.y, -A.z) end,
	__mod = function(A, B) return Vec3(A.x % B.x, A.y % B.y, A.z % B.z) end,
	__pow = function(A, B) return Vec3(A.x ^ B.x, A.y ^ B.y, A.z ^ B.z) end,
	__idiv = function(A, B)
		local mf = math.floor
		return Vec3(mf(A.x / B.x), mf(A.y / B.y), mf(A.z / B.z))
	end,
	__tostring = function(self)
		return string.format("Coords stored: <X: %s, Y: %s, Z: %s>", self.x, self.y, self.z)
	end,
	-- stylua: ignore end
}, {
	__index = Vec3,
	__call = function(_, x, y, z)
		---@Note I chose to instantiate the properties inside the table created on setmetatable call
		---@Meta Works just as well
		local self = setmetatable({ x = x or 0, y = y or 0, z = z or 0 }, Vec3)
		return self
	end,
})

local vec_one = Vec3(2, 4, 3)
local vec_two = Vec3(6, 1, 4)

local vec_res = vec_one + vec_two

print(vec_res)
print(vec_res + vec_one)
