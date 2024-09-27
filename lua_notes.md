# Lua Notes

These are some quick notes about Lua's syntax and functionalities.

## Table of Contents

- [Lua Notes](#lua-notes)
  - [Table of Contents](#table-of-contents)
  - [Variables basics](#variables-basics)
  - [Comments](#comments)
    - [Docstring format](#docstring-format)
  - [Data types](#data-types)
  - [Operators](#operators)
    - [Arithmetic](#arithmetic)
    - [Logical and Relational](#logical-and-relational)
    - [Bitwise and others](#bitwise-and-others)
  - [Control structures](#control-structures)
    - [If-Else](#if-else)
    - [Whiles](#whiles)
    - [For loops](#for-loops)
  - [Functions](#functions)
    - [Variadic Functions (unknown param quantity)](#variadic-functions-unknown-param-quantity)
    - [Multiple Returns](#multiple-returns)
    - [Closures](#closures)
    - [Function calls](#function-calls)
  - [Tables](#tables)
    - [Creation and access](#creation-and-access)
    - [Objects and methods](#objects-and-methods)
    - [Reading a table](#reading-a-table)
    - [Table methods](#table-methods)
    - [OOP - Classes and methods](#oop---classes-and-methods)
    - [Metatables](#metatables)
  - [Modules](#modules)
  - [Coroutines](#coroutines)
  - [General methods](#general-methods)
    - [Variables](#variables)
    - [Methods](#methods)
      - [Basics](#basics)
      - [Table interactions](#table-interactions)
      - [Error handling and debugging](#error-handling-and-debugging)
      - [Low level](#low-level)
  - [String manipulation](#string-manipulation)
    - [Basic methods](#basic-methods)
    - [Pattern matching methods](#pattern-matching-methods)
    - [Less common methods](#less-common-methods)
    - [Patterns](#patterns)
      - [Character classes](#character-classes)
      - [Pattern item and anchors](#pattern-item-and-anchors)
      - [Capture groups](#capture-groups)
      - [Examples](#examples)
  - [Math standard library](#math-standard-library)
  - [IO and files library](#io-and-files-library)
  - [OS library](#os-library)
  - [Debug library](#debug-library)
- [The end](#the-end)

## Variables basics

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

#### Arithmetic

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

#### Table methods

```lua
-- Some sample tables
local simple_table = { "text", 123, "not a number", 45.67}
local object_table = {
    name = "Joan",
    age = 30,
    height = 1.75,
    occupation = "Historian"
}
local sub_tables = {
    address = {
        street = "Void Street",
        number = 77,
        complement = "Apt 7"
    },
    phones = { 404123456789, 404987654321, 200132465798 },
    emails = { "lil_joan@past.org", "current_joan@present.org", }
}

-- Table elements concatenation (for string and number elements only)
-- (table, separator?, start_index?, end_index?)
table.concat(simple_table) -- text123not a number45.67
table.concat(simple_table, " | ") -- text | 123 | not a number | 45.67
table.concat(simple_table, " | ", 2) -- 123 | not a number | 45.67
table.concat(simple_table, " | ", 1, 3) -- text | 123 | not a number

-- Element insertion
-- (table, pos? (defaults to last index), value)
table.insert(simple_table, "end") -- { "text", 123, "not a number", 45.67, "end"}
table.insert(simple_table, 3, "middle") -- { "text", 123, "middle", "not a number", 45.67, "end"}

-- Element removal
-- (table, pos? (defaults to last index), value)
table.insert(simple_table, 3) -- { "text", 123, "not a number", 45.67, "end"}
table.insert(simple_table, -1) -- { "text", 123, "not a number", 45.67}

-- Table length
table.maxn(simple_table) -- 4

-- Table sorting (single type only, sort-in-place)
local numbers = { 4, 6, 3, 9, 2 }
table.sort(numbers) -- { 2, 3, 4, 6, 9 }
```

#### OOP - Classes and methods

```lua
-- Example in Class and object creation
Cat = {}

function Cat:new(name, age)
    local t = setmetatable({}, { __index = Cat })
    -- Constructor
    t.name, t.age, t.hunger, t.happy, t.energy = name, age, 50, 50, 50
    return t
end

function Cat:play(time)
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
    print("Happiness: "..self.happy)
    print("Hunger: "..self.hunger)
    print("Energy: "..self.energy)
end

local bootsy = Cat:new("Bootsy", 3)
bootsy:play(3)
```

#### Metatables

```lua
-- Metatables are used to change the behaviour of a table
local my_table = {}
local my_metatable = {}
setmetatable(my_table, my_metatable)

-- To get the metatable use
local mt = getmetatable(my_table)

-- We can control the main table's behaviour using the following properties
__index -- What happens when we access missing keys. Can be a function or a table
__newindex -- Controls what happens when setting values to missing keys
__call -- Allows the table to be called as a function, and defines what happens then
__(add, sub, mul, div, mod, pow, unm) -- Changes arithmetics behaviour
__(eq, lt, gt, le, ge) -- Behaviour for equality and relational operations
__tostring -- How to confert the table to a string
__concat -- How to concatenate items
__len -- How to get the length (#)
```

## Modules

```lua
-- Modules are imported from top folder from the pov of the entryfile
local example = require("src.subfolder.file")

-- Then we can use things from inside this file
example.do_thing()
```

#### Installing/removing modules

Using Luarocks:

```bash
# Installing globally (not best practice)
sudo luarocks install the_module

# Installing locally
luarocks install --local the_module

# Installing per-project inside a subfolder called lua_modules
luarocks install --tree ./lua_modules the_module
```

## Coroutines

Coroutines are similar to JS workers or threads in most other languages.

When a coroutine "yields", it returns what it has computed up to that point and suspends its execution. On resuming, the coroutine will continue its execution from that point on until it finishes or until the next "yield".

```lua
-- Coroutine creation
function my_func(param) print(param) end
-- (function)
local my_thread = coroutine.create(my_func)
-- or
local my_thread = coroutine.create(function(param) print(param) end)
-- Returns a "thread" object, which can be operated on

-- Starting or resuming a coroutine with given params
-- (thread, params)
coroutine.resume(my_thread, "Hi hi")
-- If the coroutine has yielded (finished), resume will restart it, and the arguments will be the results from the yield.
-- It'll return "true" + the results on success (either the yielded values or the function custom return)
-- It'll return "false" + the error message if it errs

-- Getting the currently running coroutine
coroutine.running()

-- Getting the coroutine status as status strings
-- (thread)
coroutine.status(my_thread)
-- "running": Coroutine is running
-- "suspended": Coroutine is suspended in Yield or didn't yet start
-- "normal": Coroutine is active but not runnint (another coroutine is running)
-- "dead": Coroutine has either successfully finished or terminated in err

-- Yielding a coroutine (suspending execution and returning current values)
-- Is used inside the coroutine body at the moment of its creation
-- Any extra argument is passed as extra results to "resume"
coroutine.yield(...)

-- Another way to create coroutines
-- (function)
local wrapped_thread = coroutine.wrap(my_func)
-- It returns a function that you can call again to resume execution
wrapped_thread("Hi hi") -- This will resume the coroutine, instead of coroutine.resume(wrapped_thread)

-- coroutine.create gives you more control over the thread.
-- You can't use the generic functions when you use coroutine.wrap
```

## General methods

Below are some methods and variables available at the top level.

#### Variables

```lua
arg -- Global table that can receive arguments for a lua script
-- e.g. lua init.lua "my_argument"

_G -- Global object containing the whole environment (And self-references: _G._G == _G)
-- This object cannot be changed, but can be used to import stuff
local error =  _G.error

_VERSION
-- Holds the current interpreter version. e.g. "Lua 5.1"
```

#### Methods

###### Basics

```lua
print(...args)
-- Prints the arguments to standard output, internally using tostring() to first convert them.
-- It doesn't auto format things. use string.format() for that

tonumber("10", 8)
-- Converts the first argument to a number, using the second as the base (2 to 36)
-- In base 10, it accepts floats, exponents and negatives
-- In any other base only accepts positive integers

tostring(param)
-- Converts the argument to a string. Use string.format() to control how numbers are converted

type(arg)
-- Returns a string with the name of the type for the argument
```

###### Table interactions

```lua
-- (table)
ipairs(my_table)
-- Returs an iterator, the table and an index
-- Used to iterate over index - value
-- (table)

-- (table)
pairs(my_table)
-- Returs the `next` function, the table and nil
-- Used to iterate over key - value

-- (object)
getmetatable(my_table)
-- Returns the metatable if present, else it returns nil

next(my_table, idx)
-- Accesses the next index and value of the table

local a, b, c, d, e = unpack(my_table, 1, 5)
-- Returns the table items as individual returns. Used to destructure an object

```

###### Error handling and debugging

```lua
-- Result assertion (like .expect() in Jest)
-- (value_to_test, error_message?: string)
assert(1+1 == 2, "This is wrong, kiddo")
-- If you don't give it an error message, it defaults to "assertion error"

-- (message: string, level?: int)
error("sample error", 1)
-- Terminates the function and returns the error message.
-- level 1: default, where the function whas called
-- level 2: parent of level 1
-- 0: no level is returned

-- (function?)
getfenv()
-- Returns a table containing the environment in use by the function, or the global environment

setfenv(func, my_table)
-- Sets the environment used by the given function. If function is 0 it sets the environment of the running thread

-- (function, ...args?: arguments)
pcall(print, "hi")
-- Calls the function in protected mode. The first return is a boolean
-- indicating success or failure.
-- In case of failure, the second return is the error message
-- In case of success, every other return are the results of that function

xpcall(print, function handle_my_error(err) print(err) end)
-- Similar to pcall, except you can have a custom error handler

rawequal(value1, value2)
-- Value checking which ignores any metamethod

rawget(my_table, index)
-- Gets table[index] ignoring metamethods

rawset(my_table, index, value)
-- Sets value to table[index] ignoring any metamethods

warn("Message")
-- Displays a warning. Lua 5.4 and above only
```

###### Low level

```lua
-- Manipulates the garbage  collector directly
-- (option?: string, arg?: string)
collectgarbage("step", 100)
-- It has the following options:
-- collect: Default. Runs a full garbage collection cycle
-- stop: Stops the collector
-- restart: Restarts the collector
-- count: Returns the total used memory by Lua in Kbytes
-- step, arg: Performs a collection step, with "step" size being controlled by the arg param. Returns true after finishing a cycle.
-- setpause, arg: Sets a new pause for the collector and returns the previous one.
-- setstepmul: Sets value for step multiplier of the collector, and returns previous value

dofile("/path/to/file")
-- Opens and runs file as a lua chunk. If filename is empty it refers to standard input. Returns values executed by the lua chunk, of propagates the error

load(func, "chunkname")
loadfile("filename")
loadstring(str, "chunkname")
-- Functions for loading chunks from functions, files and strings
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
-- (string, init?, end?)
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

## Math standard library

```lua
-- Most used
math.abs(-3) -- Absolute: 3
math.ceil(3.4) -- Round up: 4
math.floor(3.4) -- Round down: 3
math.fmod(15.4, 4) -- Division module (remainder): 3.4
math.huge -- Similar to positive infinity
math.max(4, 5, 8, 2, 3) -- Returns max: 8
math.min(4, 5, 8, 2, 3) -- Returns min: 2
math.modf(3.4) -- Returns integral and fractional parts of x: 3, 0.4
math.pi -- Self-explanatory
math.pow(x, y) -- Same as x^y
math.random(x?, y?) -- Pseudo random from 0 to 1, or from range between x and y
math.sqrt(x) -- Square root of x. Same as x^0.5

-- Trigonometry
math.acos(x) -- Arc cosine in radians
math.asin(x) -- Arc sine in radians
math.atan(x) -- Arc tangent in radians
math.atan2(x, y) -- Arc tangent of y / x in radians to find quadrant.
math.cos(x) -- Cosine, assumes number is in radians
math.cosh(x) -- Hyperbolic Cosine, assumes number is in radians
math.deg(x) -- Angle in degrees from number in radians
math.rag(x) -- Returns the angle x in radians
math.sin(x) -- Sine of x (x being in radians)
math.sinh(x) -- Hyperbolic sine of x (again, x in radians)
math.tan(x) -- Tangent of x (also in radians)
math.tanh(x) -- Hyperbolic tangent of x (in radians)

-- Others
math.exp(x) -- Returns e^x
math.frexp(x) -- Returns m and e such that x = m2^e. e is an int,and m ranges from 0.5 to 1
math.ldexp(m, 3) -- Returns m2^e
math.log(x) -- Natural logarithm of x
math.log10(x) -- Base 10 logarithm of x
math.randomseed(x) -- Sets x as the seed from the pseudo-random generator
```

## IO and files library

```lua
-- Common IO returns:
-- Success = expected value
-- Fail =  nil, lua err, system-dependent err

-- opening a file
local file = io.open("./rust-notes.md", "r+")
-- File modes:
-- r: read (default)
-- w: write
-- a: append
-- r: read (default)
-- w: write
-- a: append
-- Mode + "b" = opens in binary mode for some systems e.g. "r+b"

file:close() -- Closes the file.
io.close(file --[[?]]) -- Same as above. Without a file, closes the default output

io.input(file --[[?]]) -- Without a filename, returns current defalt input file. With a file it opens it in textmode and sets it as the default input file.
io.read(...) -- Same as io.input():read(). It reads input (usually CLI) and returns it to the program
file:read(...) -- Receives a mode denoting how to read the file:
-- "*n": Reads and returns a number
-- "*a": Reads whole file from current position. Returns "" on eof
-- "*l": Default mode. Reads next line from current position. Ignores eol. Returns "" on eof
-- any number: Reads this number of characters, returning nil on eof

file:lines() -- Returns an iterator, used like "for line in file:lines() do ... end"
io.lines(file --[[?]]) -- Same as above. Without a filename works like "io.input():lines()"

file:write(...) -- Writes the arguments to the file.

file:flush() -- Saves written data to file
io.flush() -- Same as above, but for the default output file

io.output(file --[[?]]) -- Similar to io.input, but operates on the default output file.
io.write(...) -- Same as io.output():write()

file:seek(param?) -- Gets current file position. "set" puts position at start, "cur" is current, "end" puts at eof

io.popen(prog, mode --[[?]]) -- Starts prog in another process and returns a file handle representing it. This is system-dependent

io.tmpfile() -- Returns handle for a temporary file, in update mode

io.type(obj) -- Checks if obj is a valid file handle
```

## OS library

```lua
os.clock() -- Aprox. time in seconds used by the program

-- (format?: string, time?: int, unix time)
os.date() -- By default, returns current time (www dd MMM yyyy hh:mm:ss tz)
os.date("!*t") -- Gets a table containing the current time.

os.time() -- Gets current time in unixcode
os.time(table) -- Gets the unixtime for table passed following the format in os.date, with hour, min and sec being required.

os.difftime(t2, t1) -- Difference between two unix times (t2 - t1)

os.execute(command) -- Runs shell command

os.exit(code?) -- Calls the C function "exit"

os.getenv(name) -- Gets the value of the environment variable passed in "name"

os.remove(name) -- Removes the file/directory. Directories must be empty to be removed.

os.rename(oldname, newname) -- Self-explanatory

os.setlocale(locale, category?) -- Sets current program locale. Category describes which category to change from "all" (default), "collate", "ctype", "monetary", "numeric" or "time"

os.tmpname() -- Returns a string with an available name for a tempfile. Does not automatically open this file nor closes it.
```

## Debug library

```lua
-- Lets do this later...
```

# The end

This marks the end of these notes for now. I tried to summarize the contents from the manual in a format that can be referenced faster and with some examples on more complicated functionalities. If there's anything missing (apart from the debug library, I'm not touching that for now) feel free to let me know.
