local my_class = {}

local my_class_mt = {}

function my_class.new()
	print("Constructing new instance")
	return setmetatable({}, my_class_mt)
end

function my_class:instance_method()
	print("Instances can access this method")
end

local instance = my_class.new()
instance:instance_method()
