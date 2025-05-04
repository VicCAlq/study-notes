local b_tree = { 4, 2, 3, 7, 9, 1, 6 }

math.randomseed(os.time())
local test = {}

for _ = 1, 15 do
	table.insert(test, math.ceil(math.random() * 100))
end

local function split(arr)
	local copy = {}
	for _, v in ipairs(arr) do
		table.insert(copy, v)
	end

	local counter = 0
	local node_level = 1
	local splits = {}

	local function split_push(list)
		while #list > 0 do
			local node_split = {}
			while counter ~= node_level do
				table.insert(node_split, table.remove(list, 1))
				counter = counter + 1
			end
			node_level = node_level * 2
			table.insert(splits, node_split)
			counter = 0
		end
	end

	split_push(arr)

	for _, tbl in ipairs(splits) do
		for i = 1, math.floor(#tbl / 2) do
			local tmp = tbl[i]
			tbl[i] = tbl[#tbl - i + 1]
			tbl[#tbl - i + 1] = tmp
		end
	end

	local result = {}

	for _, tbl in ipairs(splits) do
		for _, item in ipairs(tbl) do
			table.insert(result, item)
		end
	end

	local og_tree = ""
	local new_tree = ""

	for _, i in ipairs(copy) do
		og_tree = og_tree .. tostring(i) .. ", "
	end

	for _, i in ipairs(result) do
		new_tree = new_tree .. tostring(i) .. ", "
	end

	print("Original array => ", og_tree)
	print("Reversed array => ", new_tree)

	return result
end

split(b_tree)
split(test)
