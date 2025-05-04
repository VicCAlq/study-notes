#!/usr/bin/env lua5.4

---@source https://stackoverflow.com/questions/14290527/recreating-setfenv-in-lua-5-2

---@note To recreate setfenv/getfenv in Lua 5.2 you can do the following:
--- RPFeltz's answer (load(string.dump(f)...)) is a clever one and may work for you, but it
--- doesn't deal with functions that have upvalues (other than _ENV).
--- There is also compat-env module that implements Lua 5.1 functions in Lua 5.2 and vice versa.

if not setfenv then -- Lua 5.2+
	-- based on http://lua-users.org/lists/lua-l/2010-06/msg00314.html
	-- this assumes fn is a function

	---@param fn function
	local function findenv(fn)
		local level = 1
		repeat
			local name, value = debug.getupvalue(fn, level)
			if name == "_ENV" then
				return level, value
			end
			level = level + 1
		until name == nil
		return nil
	end

	---@param fn function
	getfenv = function(fn)
		return (select(2, findenv(fn)) or _G)
	end

	---@param fn function
	setfenv = function(fn, t)
		local level = findenv(fn)
		if level then
			debug.setupvalue(fn, level, t)
		end
		return fn
	end
end

---@note Alternativelly, just use "load()"
--- load(lua_code_to_load, "name_for_said_code", mode: "b"|"t"|"bt", env)
--- mode can be "binary only", "text only", "binary or text" (default). "text only" is the safest
--- env is a table containing everything the code should have access to. If I don't put "math" inside
--- the env, the function won't be able to access the math functions
--- Use as such:
--- local untrusted_fn, message = load(untrusted_code, "sandboxed", "t", limited_env)

--- Source: https://leafo.net/guides/setfenv-in-lua52-and-above.html
local function setfenv(fn, env)
	local i = 1
	while true do
		local name = debug.getupvalue(fn, i)
		if name == "_ENV" then
			debug.upvaluejoin(fn, i, function()
				return env
			end, 1)
			break
		elseif not name then
			break
		end

		i = i + 1
	end

	return fn
end

local function run_in_sandbox(env, fn, ...)
	setfenv(fn, env)
	return pcall(fn, ...)
end

return run_in_sandbox
