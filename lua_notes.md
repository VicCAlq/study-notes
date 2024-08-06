# Lua Notes
## Variables

```lua
-- Global variable
my_var = "My variable"
-- Scoped variable
local my_local_var = "My local variable"
-- Multiple assignment
local one, two, three = 1, 2, 3
-- (Multiple) Reassignment
one, two, three = two, three, one
-- Ignored variable via underscore (_)
local _, result = pcall(foo)
```

## Comments
```lua
-- Common comment
---Docstring
--[[ Multiline comment or in-line block comment]]
--[=[ Multiline comment that contains "]]"]=]
```
#### Docstring format
```lua
---Example of a docstring
---@param my_param bool A common required param
---@param my_optional? number An optional param
---@param my_optional string|nil A param that can be either string or nil
---@return table<bool> internal_var The return type
local function example(my_param, my_optional, my_nullable) 
    ---@type table<any>
    local internal_var = {}

    ---@type boolean
    internal_var["result"] = true

    return internal_var 
end
```

## Data types
```lua
local a = nil -- Nil / Null
local b, c = true, false -- Boolean
local d = 12.25 -- Number
local e = "Sample" -- String
local f = function(param) return param end -- Function
function g(param) return param end -- Also function
f(b) -- returns true
g(c) -- returns false
local h = {a, b, c} -- Table, List, Dict, etc.
local i = coroutine.create(function() end) -- Coroutines / Threads
local j = any
local k = userdata --custom C data type
```

## Operators
####  Arithmetic
```lua
local add = 4 + 5
local subtract = 2 - 5
local mult = 2 * 5
local divide = 5 / 2
local int_divide = 5 // 2
local remainder = 5 % 2
local exponent = 5^2
```
#### Logical and Relational
```lua
local logic_operators = {"not", "and", "or"}

local equality = a == b
local inequality = a ~= b
local smaller = a < b
local larger = a > b
local smaller_or_equal = a <= b
local larger_or_equal = a >= b

```
#### Bitwise and others
```lua
-- Bitwise
local AND = x & y -- Lua 5.3+
AND = bit32.band(x, y) -- Lua 5.2-
local OR = x | y -- Lua 5.3+
OR = bit32.bor(x, y) -- Lua 5.2-
local XOR = x ~ y -- Lua 5.3+
XOR = bit32.bxor(x, y) -- Lua 5.2-
local NOT = ~x -- Lua 5.3+
NOT = bit32.bnot(x) -- Lua 5.2-
local LSHIFT = x << y -- Lua 5.3+
LSHIFT = bit32.lshift(x, y) -- Lua 5.2-
local RSHIFT = x >> y -- Lua 5.3+
RSHIFT = bit32.rshift(x, y) -- Lua 5.2-

-- Others
local concat = "one" .. "two" -- "onetwo"
local length = #concat -- 6
```
## Control structures
#### If-Else

```lua
if a == b then
    print(a + b)
elseif a < b then
    print(b)
else
    print(a)
end
```
#### Whiles
```lua
-- While
while a < 10 do
    a = a + 1
end

-- Do while
repeat
    a = a - 1
until a == 0
```
#### For loops
```lua
-- For (numeric range)
-- index_variable=start, end, step
for index=1, 10, 1 do
    index = index + 1
end

-- For (Traversing table with key-value pairs)
-- If the keys are numbers, they aren't treated
-- as indexes, and are kept on the order they're
-- attributed.
for key, value in pairs(table) do
    print(value)
end

-- For (Traversing table with index-value pairs)
-- In ipairs(), non-numeric keys are ignored,
-- and key-values are ordered by the index number.
-- Gaps in between the indexes cause halts.
for key, value in ipairs(table) do
    print(value)
end

-- pairs() vs ipairs() difference:
local t = {}
t[0] = "a"
t[3] = "d"
t[6] = "f"
t[2] = "c"
t["I HAVE"] = "THE HIGH GROUND"
t[4] = "e"
t[1] = "b"
t[7] = "g"

for k, v in ipairs(t) do print(k, v) end
> 1 b | 2 c | 3 d | 4 e

for k, v in pairs(t) do print(k, v) end
> 0 a | 3 d | 6 f | 2 c | I HAVE THE HIGH GROUND | 4 e | 1 b | 7 g

-- So for safety, only use pairs() if we want to get
-- the real table size.

-- Labels and Goto
::my_label::
goto my_label
```

## Functions

```lua
---Example of a function that receives a table and two numbers
---and fills it with a range between those two numbers
---@param a number Start of range
---@param b number End of range
---@param s number?|nil? Step (optional, default = 1)
---@return table<number> range Table containing a range of numbers
local function range_between(a, b, s)
  if a == b then return {} end

  local range = {}
  local step = s or 1

  for i = a, b, step do
    table.insert(range, i)
  end
  return range
end

Test1 = range_between(10, 30, 2)
Test2 = range_between(30, 10, -3)

for _, v in pairs(Test1) do io.write(string.format("%d, ", v)) end
for _, v in pairs(Test2) do io.write(string.format("%d, ", v)) end
```
#### Variadic Functions (unknown param quantity)

```lua
---Example of an accumulator function
---@param ... number Numbers to accumulate
---@return number sum Sum of numbers
function accumulate_numbers(...)
    local sum = 0
    for _, v in pairs{...} do
        sum = sum + v
    end
    return sum
end
```
#### Multiple Returns
```lua
---Example of a string splitting function
---@param string_to_split string String to split
---@return table<string> strings_list List of words
---@return number word_num Quantity of words
function split_string(string_to_split)
    strings_list = {}
    local word_num = 1

    ---Splits the string on the spaces, removing them and storing
    ---everything else in the table
    for str in string.gmatch(string_to_split, "[^%s]+") do
        strings_list[word_num] = str
        word_num = word_num + 1
    end

    return strings_list, word_num
end
```
#### Closures
```lua
-- Functions have closures, so they can access values
-- in the scope directly above them
function outerFunc()
    local i = 0
    return function()
        i = i + 1
        return i
    end
end
```
#### Function calls
```lua
print("Hello")
print"Hello"
print([[Multiline text]])
print[[Multiline text]]
f({a = true, b = false})
f{a = true, b = false}

-- Using parenthesis is always recommended
```
## Tables
There are no arrays, no lists, no dictionaries, no objects. Only tables.
#### Creation and access
```lua
-- An empty table
local t0 = {}

-- Tables can behave like simple indexed lists
-- Except in Lua indexes start at 1
local t1 = {"a", "b", "c"}
t1[1] -- "a"

-- When you create a table like the above, internally it behaves like this
-- { [1] = "a", [2] = "b", [3] = "c" }
-- You can, however, attribute any kind of index to elements
local t2 = { [2] = "alpha", [5] = "beta", [3] = "gamma" }
t2[3] = "gamma"

-- Tables can have mixed types of elements, even functions
local t3 = { "name" = "Juan", "surname" = "Risitas", "age" = 62 }
t3.name -- "Juan"
-- And they can be accessed either using brackets or dots
t3["age"] -- 62
t3.age -- also 62
```
#### Objects and methods
```lua
-- Tables can also behave like objects, mixing data and methods
local caramel = {
    name = "Caramel",
    species = "cat",
    age = 6,
    meow = function() print("Meow!") end
}

-- Functions can be implemented with or without a self argument
function caramel.pounce(victim) end -- Without self
function caramel:jump(place) end -- With self

-- These two are the same
caramel.jump(caramel --[[self]], place)
caramel:jump(place)

-- These two are also the same, both receive the self argument
function caramel.clean(self, part) end
function caramel:lick(part) end
```
#### Reading a table
```lua
-- Replicating the information in the "For" section, since that's how it's done

-- Traversing table with key-value pairs:
-- If the keys are numbers, they aren't treated as indexes,
-- and are kept on the order they're attributed.
for key, value in pairs(table) do
    print(value)
end

-- Traversing table with index-value pairs:
-- In ipairs(), non-numeric keys are ignored,
-- and key-values are ordered by the index number.
-- Gaps in between the indexes halt the loop and return early.
for key, value in ipairs(table) do
    print(value)
end

-- pairs() vs ipairs() difference:
local t = {}
t[0] = "a"
t[3] = "d"
t[6] = "f"
t[2] = "c"
t["I HAVE"] = "THE HIGH GROUND"
t[4] = "e"
t[1] = "b"
t[7] = "g"

for k, v in ipairs(t) do print(k, v) end
> 1 b | 2 c | 3 d | 4 e

for k, v in pairs(t) do print(k, v) end
> 0 a | 3 d | 6 f | 2 c | I HAVE THE HIGH GROUND | 4 e | 1 b | 7 g

-- So for safety, only use pairs() if we want to get
-- the real table size. Using #table will behave like checking
-- table size with ipairs().
-- If performance is of no concern, pairs() (preceded by ordering 
-- if needed) will always be the safest option.
```
## String manipulation
```lua
-- Unlike some languages, in Lua we concatenate strings using '..'
local name = "Grug"
local greeting = "Hello " .. name .. "!" -- Hello Grug!

-- Converting a value to a string
tostring(42)
```
#### Basic methods
```lua
-- Getting the https://github.com/kndndrj/nvim-dbeelength of a string
string.len(greeting) -- 11

-- Upper and lower casing the string
string.upper(greeting) -- HELLO GRUG!
string.lower(greeting) -- hello grug!

-- Repeating and reversing a string
string.rep(greeting, 3) -- Hello Grug!Hello Grug!Hello Grug!
string.reverse(greeting) -- !gurG olleH
```
#### Pattern matching methods
```lua
-- Getting a section of the string
-- (string, init, end?)
string.sub(greeting, 3, 5) -- llo

-- Variable / expression insertion in strings
-- (string_with_placeholders, expressions)
string.format("Speed: %.1f KMp/H", 68.452) -- Speed: 68.5

-- Find a section of a string
-- (string, pattern, init?: int, plain_text?: boolean, default false)
string.find(greeting, "et", 1, true)

-- Pattern matching on a string
-- (string, pattern, init?: int)
local vehicles = "plane, bicycle, car, motorcycle, tricycle" 
string.match(vehicles, "(%S+cycle)") -- bicycle
string.match(vehicles, "(%w+cycle)", 16) -- motorcycle

-- Getting multiple matches
local results = {}
for word in string.gmatch(vehicles, "(%w+cycle)") do
    table.insert(word)
end
-- {"bicycle", "motorcycle", "tricycle"}

-- Replacing parts of a string
string.gsub(vehicles, "%w+(cycle)", "boat") -- "plane, boat, car, boat, boat"
string.gsub(vehicles, "cycle", "boat") -- "plane, biboat, car, motorboat, triboat"
```
#### Less common methods
```lua
-- Get bytecode for characters
-- (string, init, end)
string.byte(greeting, 1, -1) -- indexes can start from -1 to get last item

-- Get characters from bytecode
string.char(72, 101, 108, 108, 111, 32, 71, 114, 117, 103, 33) -- Hello Grug!

-- Getting binary representation from function
local function my_dump(name)
    print("Hello "..name.."!")
end
local dumped = string.dump(my_dump)

-- Reusing dumped function
loadstring(dumped)("Grug") -- "Hello Grug!"
```

#### Patterns
###### Character classes
```lua
"abc" -- Matches the characters "abc" themselves
"." -- All characters
"%a" -- All letters
"%c" -- All control characters
"%d" -- All digits
"%l" -- All lowercase letters
"%u" -- All uppercase characters
"%p" -- All punctuation characters
"%s" -- All space characters
"%S" -- All non-space characters
"%w" -- All alphanumeric characters
"%x" -- All hexadecimal digits
"%z" -- the character with representation 0
"%?" -- Matches the "magic" character corresponding to the ?. % is used to escape the character
"[pattern]" -- [] denotes a union set
"(pattern)" -- () denotes a capture group, can go inside a set

-- Set examples
"[a-z]" -- Characters from a to z
"[0-7]" -- Numbers from 0 to 7 (octals)
"[%w_]" or "[_%w]" -- All alphanumeric + underscore
"[0-7%l%-]" -- Octals + any lowercase letter + minus character
"[%a-z]" -- Non-valid, can't combine classes with ranges
"[^set]" -- Compliment of the set
```
###### Pattern item and anchors
```lua
-- In these examples, x is a placeholder
"%x" -- All character classes can be a pattern item
"%x*" -- Matches 0 or more repetitions of characters in the class. Prioritize longest sequence
"%x+" -- Matches 1 or more repetitions of characters in the class. Prioritize longest sequence
"%x-" -- Matches 0 or more repetitions of characters in the class. Prioritize shortest sequence
"%x?" -- Matches 0 or 1 occurrence of characters in the class. Prioritize shortest sequence
"%n" -- "n" being any number from 1 to 9. Matches the corresponding capture group
"%bxy" -- Matches strings starting with "x" and ending with "y". Each "x" counts as +1, "y" as -1, and count must reach 0

-- Anchors
"^%x" -- Anchors the match at the beginning of the subject string
"%x$" -- Anchors the match at the end of the subject string
```
###### Capture groups
```lua
-- Capture groups are sub-patterns limited by parentheses
local serial = "NE-714.agb57c"
local pattern = "((%a%a)%-(%d%d%d)).(%w+)"
-- 1st capture: NE-714
-- 2nd capture: NE
-- 3rd capture: 714
-- 4th capture: agb57c

-- When using string.gsub(), we can reference each capture by the pattern %n, examples:
string.gsub(serial, pattern, "%4.%3-%2") -- "agb57c.714-NE"
```
###### Examples
```lua
-- Possible matches
local str = "This 1 is a 23 test 4 string, best 56 7 example to 8 bring"
string.gmatch(str, "is") -- is, is
string.gmatch(str, "%a%a%a%a") -- This, test
string.gmatch(str, "%a+") -- Every word individually
string.gmatch(str, "%a%a+") -- Every word with 2 letters +
string.gmatch(str, "%w%w+") -- Every sequence with 2 letters +
string.gmatch(str, "%s") -- Only the spaces
string.gmatch(str, "%S") -- Every non-space character
string.gmatch(str, "%d") -- Every digit
string.gmatch(str, "%d+") -- Every number
string.gmatch(str, "[aeiou]") -- Only vowels
string.gmatch(str, "[c-o]") -- Letters from c to o
string.gmatch(str, "[^%d]+") -- Any non-digit
string.gmatch("The date is 29/02/2024", "%d%d%/%d%d%/%d%d%d%d") 
-- ^ single match 29/02/2024
string.gmatch("The date is 29/02/2024", "(%d%d)%/(%d%d)%/(%d%d%d%d)") 
-- ^ Three individual matches 29, 02, 2024
```
## Table manipulation
```lua

```

```lua

```

```lua

```

```lua

```

```lua

```

```lua

```

```lua

```

```lua

```

```lua

```

```lua

```

```lua

```

