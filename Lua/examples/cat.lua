-- Example in Class and object creation
Cat = {}
Cat.__index = Cat

function Cat.new(name, age) -- Written with dot so that instances can't create new instances
	local self = setmetatable({}, Cat)
	-- Constructor
	self.name, self.age, self.hunger, self.happy, self.energy = name, age, 50, 50, 50
	return self
end

function Cat:play(time) -- Written with colon to have access to "self" argument
	self.happy = self.happy + (10 * time)
	self.hunger = self.hunger + (5 * time)
	self.energy = self.energy - (15 * time)
	print("A fine cat is a playful cat!")
	self:status()
end

function Cat:eat(food)
	self.happy = self.happy + (5 * food)
	self.hunger = self.hunger - (15 * food)
	self.energy = self.energy + (2 * food)
	print("A good cat is a fed cat!")
	self:status()
end

function Cat:rest(time)
	self.happy = self.happy - (2 * time)
	self.hunger = self.hunger + (5 * time)
	self.energy = self.energy + (10 * time)
	print("A healthy cat is a well-sleeping cat!")
	self:status()
end

function Cat:status()
	print(string.format("This is how %s feels now", self.name))
	print("Happiness: " .. self.happy)
	print("Hunger: " .. self.hunger)
	print("Energy: " .. self.energy)
end

TalkativeAnimal = {}
TalkativeAnimal.__index = TalkativeAnimal

function TalkativeAnimal.say(name, sound) -- Class that adds action to any animal
	print(string.format("%s says: %s", name, sound))
end

OrangeCat = {}
OrangeCat.__index = OrangeCat
setmetatable(OrangeCat, Cat) -- Inherits from Cat
-- setmetatable(OrangeCat, TalkativeAnimal) -- Inherits from TalkativeAnimal

function OrangeCat.new(name, age)
	local instance = setmetatable({}, OrangeCat)
	instance.name = name
	instance.age = age
	instance.happy = 50
	instance.hunger = 50
	instance.energy = 50
	instance.sound = "MewOw"

	function instance:say() -- Adding the "say" action from TalkativeAnimal
		TalkativeAnimal.say(instance.name, instance.sound)
		instance.happy = instance.happy + 10
	end

	return instance
end

function OrangeCat:play(time) -- Overloading the play function from the common Cat
	self.happy = self.happy + (20 * time)
	self.hunger = self.hunger + (5 * time)
	self.energy = self.energy - (10 * time)
	local cost = time * 2.5
	print("A fine cat is a playful cat! But it has destroyed what ammounts to $ %d", cost)
	self:say()
	self:status()
end

local bootsy = Cat.new("Bootsy", 3)
local tango = OrangeCat.new("Tango", 2)
bootsy:play(3)
tango:play(7)
