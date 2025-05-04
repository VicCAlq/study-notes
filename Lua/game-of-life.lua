os.execute("clear")
-- Generating seeds for the pseudo-random number generator
math.randomseed(os.time())

--- @param time number Time in seconds to wait
local function sleep(time)
  local system = io.popen("uname -a", "r")

  if system ~= nil then
    for line in system:lines("*a") do
      system = line
    end
  end

  if string.find(system, "Linux") then
    os.execute("sleep " .. tonumber(time) .. " && clear")
  else
    os.execute("timeout /t " .. tonumber(time) .. " && cls")
  end
end

--- @param grid table<table<number>> Matrix containing which positions are occupied
--- @return table<table<number>> future Matrix containing next positions
local function next_gen(grid)
  local nrows, ncols = #grid, #grid[1]
  local future = {}

  -- Filling future grid with zeroes
  for _ = 1, nrows, 1 do
    local row = {}
    for _ = 1, ncols, 1 do table.insert(row, 0) end
    table.insert(future, row)
  end

  -- Looping through every cell
  for y = 1, nrows, 1 do
    for x = 1, ncols, 1 do
      -- Holding alive neighbours
      local alive_neighbours = 0
      local neighbours_range = { -1, 0, 1 }

      for _, row in ipairs(neighbours_range) do
        for _, col in ipairs(neighbours_range) do
          if ((y + row >= 1 and y + row < nrows) and
                (x + col >= 1 and x + col < ncols)) then
            alive_neighbours = alive_neighbours + grid[y + row][x + col]
          end
        end
      end

      -- Removing neighbours already accounted for
      alive_neighbours = alive_neighbours - grid[y][x]

      -- Deciding who lives and who dies
      if ((grid[y][x] == 1) and (alive_neighbours < 2)) then
        future[y][x] = 0
      elseif ((grid[y][x] == 1) and (alive_neighbours > 3)) then
        future[y][x] = 0
      elseif ((grid[y][x] == 0) and (alive_neighbours == 3)) then
        future[y][x] = 1
      else
        future[y][x] = grid[y][x]
      end
    end
  end

  return future
end

--- @param grid table<table<number>> Grid to print
local function print_grid(grid)
  for _, row in ipairs(grid) do
    for _, field in ipairs(row) do
      if field == 0 then
        io.write("  ")
      else
        io.write(" @")
      end
    end
    print()
  end
  print()
end

--- @param grid table<table<number>>? Grid to use on the main loop
local function main(grid)
  local prev_grid = {}

  -- If no grid is passed, uses a random seed
  if grid == nil then
    grid = {}

    for _ = 1, 12, 1 do
      local arr = {}

      for _ = 1, 10, 1 do
        local x = math.random()
        if x <= 0.7 then x = math.floor(x) else x = math.ceil(x) end
        table.insert(arr, x)
      end
      table.insert(grid, arr)
    end
  end

  -- Configure game-loop runtime with the ending range
  for _ = 1, 50 do
    grid = next_gen(grid)

    if grid == prev_grid then
      break
    end

    print("Game of Life")
    print_grid(grid)

    prev_grid = grid
    sleep(0.2)
  end

  os.exit()
end

-- Test seed (floater)
local test_grid = {
  { 0, 0, 1, 0, 0, 0, 0, 0, 0, 0 },
  { 1, 0, 1, 0, 0, 0, 0, 0, 0, 0 },
  { 0, 1, 1, 0, 0, 0, 0, 0, 0, 0 },
  { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
  { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
  { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
  { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
  { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
  { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
  { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
  { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
  { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
}

main()
