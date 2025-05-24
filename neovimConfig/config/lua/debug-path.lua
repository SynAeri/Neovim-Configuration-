-- config/lua/debug-paths.lua
print("=== DEBUG: Lua paths and available modules ===")

-- Check lua path
print("package.path:", package.path)

-- Try to find chadrc.lua in different ways
print("Attempting to find chadrc.lua...")

-- Method 1: Direct require
local ok1, result1 = pcall(require, "chadrc")
print("Direct require('chadrc'):", ok1, type(result1))

-- Method 2: Check if file exists
local function file_exists(name)
  local f = io.open(name, "r")
  if f ~= nil then 
    io.close(f) 
    return true 
  else 
    return false 
  end
end

print("chadrc.lua file exists:", file_exists("chadrc.lua"))

-- Method 3: Try loading as a file
local ok3, result3 = pcall(dofile, "chadrc.lua")
print("dofile('chadrc.lua'):", ok3, type(result3))
