--- Pretty prints a table
local function tostring_pretty(value, cache, ident)
	if type(value) ~= "table" then
		if type(value) == "string" then
			return '"' .. tostring(value) .. '"'
		end
		return tostring(value)
	end
	cache = cache or {}
	ident = ident or "  "

	if cache[value] then
		return cache[value]
	end

	local ks = {}
	for k, _ in pairs(value) do
		table.insert(ks, k)
	end
	table.sort(ks, function(a, b)
		return tostring(a) < tostring(b)
	end)

	local ps = { "{" }
	if #ks > 0 then
		table.insert(ps, "\n")
	else
		ident = ""
	end
	for i = 1, #ks do
		local k = ks[i]
		local v = value[k]
		local vs = tostring_pretty(v, cache, ident .. "  ")
		if type(k) == "number" then
			if i == 1 then
				table.insert(ps, ident)
			end
			table.insert(ps, vs .. ", ")
			if type(ks[i + 1]) ~= "number" then
				table.insert(ps, "\n")
			end
		else
			cache[value] = vs
			table.insert(ps, ident .. k .. " = " .. vs .. ",\n")
		end
	end

	ident = ident:sub(1, #ident - 2)
	table.insert(ps, ident .. "}")
	return table.concat(ps, "")
end

--- Adds a tag to specify an object's type
local function set_tag(tbl, tag)
	assert(type(tbl) == "table")

	local mtable = getmetatable(tbl) or {}
	mtable.__tag = tag

	return setmetatable(tbl, mtable)
end

--- Adds the object's tag
local function get_tag(tbl)
	assert(type(tbl) == "table")

	return (getmetatable(tbl) or {}).__tag
end

--- Checks if the table has a given tag
local function is(tbl, tag)
	if type(tbl) ~= "table" then
		return type(tbl) == tag
	end

	return (get_tag(tbl)) == tag
end

--- Adds every key/value pair in b to a
local function extend(a, b)
	for k, v in pairs(b) do
		a[k] = v
	end

	return a
end

--- Enables metamethod overwriting in a record
local function extract_metamethods(tbl)
	local methods = {}

	for k, v in pairs(tbl) do
		if type(k) == "string" and k:sub(1, 2) == "__" and type(v) == "function" then
			methods[k] = v
			tbl[k] = nil
		end
	end

	return methods
end

--- Makes creating new keys in a table impossible
local function record(tbl)
	set_tag(tbl, "record")
	local mtable = getmetatable(tbl) or {}
	local metamethods = extract_metamethods(tbl)

	return setmetatable(
		tbl,
		extend(
			mtable,
			extend({
				__index = function(self, key)
					if rawget(self, key) == nil then
						error("Record doesn't have field " .. key)
					end
					return rawget(self, key)
				end,

				__newindex = function(self, key, _)
					error("This record is immutable, cannot add key " .. key)
				end,

				__tostring = function(self)
					return tostring_pretty(self)
				end,
			}, metamethods)
		)
	)
end

--- Creates a struct
local function struct(name)
	return function(tbl)
		set_tag(tbl, name)
		local mtable = getmetatable(tbl) or {}
		local metamethods = extract_metamethods(tbl)

		return setmetatable(
			tbl,
			extend(
				mtable,
				extend({
					__index = function(self, key)
						if rawget(self, key) == nil then
							error("Struct doesn't have field " .. key)
						end
						return rawget(self, key)
					end,

					__newindex = function(self, key, _)
						error("This struct is immutable, cannot add key " .. key)
					end,

					__tostring = function(self)
						return tostring_pretty(self)
					end,
				}, metamethods)
			)
		)
	end
end

local function test()
	local global_tags = {
		PLAYER = "Player",
		OBJ_STATIC = "Obj_Static",
		OBJ_DYNAC = "Obj_Dynamic",
		NPC = "NPC",
	}

	local player = {}
	set_tag(player, global_tags.PLAYER)

	assert(get_tag(player) == "Player")

	local Vec2 = record({
		x = 100,
		y = 200,
	})

	print(Vec2.x)
	print(Vec2.y)
	print(Vec2)
	-- print(Vec2.z)

	local function create_player(x, y)
		return struct("Player")({
			x = x or 0,
			y = y or 0,
			health = 100,
			hurt = function(self, v)
				self.health = self.health - (v or 1)
			end,
			heal = function(self, v)
				self.health = self.health + (v or 1)
			end,
		})
	end

	local p = create_player(100, 200)
	p:hurt(10)
	print(p)
end

test()

return {
	tostring_pretty,
	set_tag,
	get_tag,
	record,
	struct,
	extend,
	is,
	extract_metamethods,
}
