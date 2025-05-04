local linkedlist = setmetatable({
	__index = {
		tail = function(link)
			while link.rest do
				link = link.rest
			end
			return link
		end, -- N.B. O(n)!

		push = function(link, value, t)
			t = link:tail()
			t.rest = setmetatable({ val = value }, getmetatable(link))
			return t
		end,

		cram = function(link, value)
			return setmetatable({ val = value, rest = link }, getmetatable(link))
		end,

		each = function(link, value)
			return function()
				if link then
					value, link = link.val, link.rest
					return value
				end
			end
		end,
	},
}, {
	__call = function(lmeta, v, ...)
		local head, tail = setmetatable({ val = v }, lmeta)
		tail = head
		for i, v in ipairs({ ... }) do
			tail = tail:push(v)
		end
		return head
	end,
})

local numbers = linkedlist(1, 2, 3, 4)
for n in numbers:each() do
	print(n)
end
--> 1
--> 2
--> 3
--> 4

local head, rest = numbers.val, numbers.rest
print(head)
--> 1

for n in rest:each() do
	print(n)
end
--> 2
--> 3
--> 4

local unrest = rest:cram("99")
for n in unrest:each() do
	print(n)
end
--> 99
--> 2
--> 3
--> 4
