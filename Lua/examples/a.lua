--- Operation complexity levels (best to worst)
---
--- O(1) -> O(log(n)) -> O(n) -> O(n log(n)) -> O(n^2) -> O(2^n) -> O(n!)
---
--- Time complexity = Computation cycles
--- Space complexity = Memory usage

--- Arrays
--- Good for picking data at any position
--- Bad at storing, searching and deleting data
---
--- Time complexity for operations
--- Type       | best case | worst case
--- Access     | O(1)      | O(1)
--- Search     | O(n)      | O(n)
--- Insertion  | O(n)      | O(n)
--- Deletion   | O(n)      | O(n)
---
--- Space complexity: O(n)
---
---@see length - Must have a stactic, pre-defined length (as in number of entities)
---@see type - Must contain a single type of entities
---@see memory - Is stored contiguously in memory
---@see access - Elements are indexed with integers
local array = { 1, 2, 3, 4, 5 }

--- Stack
--- Last In, First Out (LIFO)
--- First In, Last Out (FILO)
--- The first access is by the last inserted item
--- Insertions and deletions are efficient, but access and searches are not
---
--- Time complexity for operations
--- Type       | best case | worst case
--- Access     | O(n)      | O(n)
--- Search     | O(n)      | O(n)
--- Insertion  | O(1)      | O(1)
--- Deletion   | O(1)      | O(1)
---
--- Space complexity: O(n)
---
---@see length - Must have a stactic, pre-defined length (as in number of entities)
---@see type - Must contain a single type of entities
---@see memory - Is stored contiguously in memory
---@see access - Elements are indexed with integers
local stack = { 1, 2, 3, 4, 5 }

--- Queue
--- First In, First Out (FIFO)
--- Same deal as stacks, but the first access is by the oldest inserted item
---
--- Time complexity for operations
--- Type       | best case | worst case
--- Access     | O(n)      | O(n)
--- Search     | O(n)      | O(n)
--- Insertion  | O(1)      | O(1)
--- Deletion   | O(1)      | O(1)
---
--- Space complexity: O(n)
---
---@see length - Must have a stactic, pre-defined length (as in number of entities)
---@see type - Must contain a single type of entities
---@see memory - Is stored contiguously in memory
---@see access - Elements are indexed with integers
local queue = { 1, 2, 3, 4, 5 }

--- Single Linked List
--- Each "item" is a node, and an individual object
--- This object contains a pointer/reference to the next object in the list (last object having a null reference)
--- Items _must_ be accessed sequentially
--- Good for frequent insertions and deletions
--- Accessing and searching items require you to go through the list in order
---
--- Time complexity for operations
--- Type       | best case | worst case
--- Access     | O(n)      | O(n)
--- Search     | O(n)      | O(n)
--- Insertion  | O(1)      | O(1)
--- Deletion   | O(1)      | O(1)
---
--- Space complexity: O(n)
---
---@see length - Must have a stactic, pre-defined length (as in number of entities)
---@see type - Must contain a single type of entities
---@see memory - Is NOT stored contiguously in memory
---@see access - Elements are indexed with integers
local sll = { 1, 2, 3, 4, 5 }

--- Doubly Linked List
--- Each "item" is a node, and an individual object
--- Each object contains a pointer/reference to both the next and the previous objects
--- Good for frequent insertions and deletions
--- Accessing and searching items require you to go through the list in order
---
--- Time complexity for operations
--- Type       | best case | worst case
--- Access     | O(n)      | O(n)
--- Search     | O(n)      | O(n)
--- Insertion  | O(1)      | O(1)
--- Deletion   | O(1)      | O(1)
---
--- Space complexity: O(n)
---
---@see length - Must have a stactic, pre-defined length (as in number of entities)
---@see type - Must contain a single type of entities
---@see memory - Is stored contiguously in memory
---@see access - Elements are indexed with integers
local dll = { 1, 2, 3, 4, 5 }

--- Skip List
---
--- Time complexity for operations
--- Type       | best case | worst case
--- Access     | O(log(n)) | O(n)
--- Search     | O(log(n)) | O(n)
--- Insertion  | O(log(n)) | O(n)
--- Deletion   | O(log(n)) | O(n)
---
--- Space complexity: O(n log(n))
---
---@see length - Must have a stactic, pre-defined length (as in number of entities)
---@see type - Must contain a single type of entities
---@see memory - Is stored contiguously in memory
---@see access - Elements are indexed with integers
local skip = { 1, 2, 3, 4, 5 }

--- Hash Table
--- Stores key-value pairs, fast if we know what key we want
--- Good for BIIIIIG datasets
---
--- Time complexity for operations
--- Type       | best case | worst case
--- Access     | N / A     | N / A
--- Search     | O(1)      | O(n)
--- Insertion  | O(1)      | O(n)
--- Deletion   | O(1)      | O(n)
---
--- Space complexity: O(n)
---
---@see length - Must have a stactic, pre-defined length (as in number of entities)
---@see type - Must contain a single type of entities
---@see memory - Is stored contiguously in memory
---@see access - Elements are indexed with integers
local hash_table = { 1, 2, 3, 4, 5 }

--- Binary Search Tree
---
--- Time complexity for operations
--- Type       | best case | worst case
--- Access     | O(log(n)) | O(n)
--- Search     | O(log(n)) | O(n)
--- Insertion  | O(log(n)) | O(n)
--- Deletion   | O(log(n)) | O(n)
---
--- Space complexity: O(n)
---
---@see length - Must have a stactic, pre-defined length (as in number of entities)
---@see type - Must contain a single type of entities
---@see memory - Is stored contiguously in memory
---@see access - Elements are indexed with integers
local bin_search_tree = { 1, 2, 3, 4, 5 }

--- Cartesian Tree
---
--- Time complexity for operations
--- Type       | best case | worst case
--- Access     | N / A     | N / A
--- Search     | O(log(n)) | O(n)
--- Insertion  | O(log(n)) | O(n)
--- Deletion   | O(log(n)) | O(n)
---
--- Space complexity: O(n)
---
---@see length - Must have a stactic, pre-defined length (as in number of entities)
---@see type - Must contain a single type of entities
---@see memory - Is stored contiguously in memory
---@see access - Elements are indexed with integers
local cart_tree = { 1, 2, 3, 4, 5 }

--- B-Tree
---
--- Time complexity for operations
--- Type       | best case | worst case
--- Access     | O(log(n)) | O(log(n))
--- Search     | O(log(n)) | O(log(n))
--- Insertion  | O(log(n)) | O(log(n))
--- Deletion   | O(log(n)) | O(log(n))
---
--- Space complexity: O(n)
---
---@see length - Must have a stactic, pre-defined length (as in number of entities)
---@see type - Must contain a single type of entities
---@see memory - Is stored contiguously in memory
---@see access - Elements are indexed with integers
local btree = { 1, 2, 3, 4, 5 }

--- Red-Black Tree
---
--- Time complexity for operations
--- Type       | best case | worst case
--- Access     | O(log(n)) | O(log(n))
--- Search     | O(log(n)) | O(log(n))
--- Insertion  | O(log(n)) | O(log(n))
--- Deletion   | O(log(n)) | O(log(n))
---
--- Space complexity: O(n)
---
---@see length - Must have a stactic, pre-defined length (as in number of entities)
---@see type - Must contain a single type of entities
---@see memory - Is stored contiguously in memory
---@see access - Elements are indexed with integers
local rbtree = { 1, 2, 3, 4, 5 }

--- Splay Tree
---
--- Time complexity for operations
--- Type       | best case | worst case
--- Access     | N / A     | N / A
--- Search     | O(log(n)) | O(log(n))
--- Insertion  | O(log(n)) | O(log(n))
--- Deletion   | O(log(n)) | O(log(n))
---
--- Space complexity: O(n)
---
---@see length - Must have a stactic, pre-defined length (as in number of entities)
---@see type - Must contain a single type of entities
---@see memory - Is stored contiguously in memory
---@see access - Elements are indexed with integers
local splay_tree = { 1, 2, 3, 4, 5 }

--- AVL Tree
---
--- Time complexity for operations
--- Type       | best case | worst case
--- Access     | O(log(n)) | O(log(n))
--- Search     | O(log(n)) | O(log(n))
--- Insertion  | O(log(n)) | O(log(n))
--- Deletion   | O(log(n)) | O(log(n))
---
--- Space complexity: O(n)
---
---@see length - Must have a stactic, pre-defined length (as in number of entities)
---@see type - Must contain a single type of entities
---@see memory - Is stored contiguously in memory
---@see access - Elements are indexed with integers
local avl_tree = { 1, 2, 3, 4, 5 }

--- KD Tree
---
--- Time complexity for operations
--- Type       | best case | worst case
--- Access     | O(log(n)) | O(n)
--- Search     | O(log(n)) | O(n)
--- Insertion  | O(log(n)) | O(n)
--- Deletion   | O(log(n)) | O(n)
---
--- Space complexity: O(n)
---
---@see length - Must have a stactic, pre-defined length (as in number of entities)
---@see type - Must contain a single type of entities
---@see memory - Is stored contiguously in memory
---@see access - Elements are indexed with integers
local kd_tree = { 1, 2, 3, 4, 5 }
