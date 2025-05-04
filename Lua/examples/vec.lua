-- Class definition
local Vec3 = {}
Vec3.__index = Vec3

function Vec3:__call(x, y, z)
	self = setmetatable({}, Vec3)
	self.x = x or 0
	self.y = y or 0
	self.z = z or 0
	return self
end

setmetatable(Vec3, Vec3) -- Sets the __call metamethod to the Vec3 class so it can be used to instantiate objects

function Vec3.__add(vecA, vecB)
	local newVec = Vec3(vecA.x + vecB.x, vecA.y + vecB.y, vecA.z + vecB.z)
	return newVec
end

function Vec3:__tostring()
	return string.format("X: %s, Y: %s, Z: %s", self.x, self.y, self.z)
end

local vec_one = Vec3(2, 4, 3)
local vec_two = Vec3(6, 1, 4)

local vec_res = vec_one + vec_two

print(vec_res)
