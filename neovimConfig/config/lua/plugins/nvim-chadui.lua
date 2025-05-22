-- config/lua/plugins/nvim-chadui.lua
print("=== Loading nvchad-ui ===")

-- Set up base46 cache directory
vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46_cache/"

-- Load chadrc using the method we know works
local function load_chadrc()
  -- Get the directory of the current file
  local current_file = debug.getinfo(1, "S").source:sub(2)
  local current_dir = current_file:match("(.*)/")
  local parent_dir = current_dir:match("(.*)/plugins")
  
  if parent_dir then
    local chadrc_path = parent_dir .. "/chadrc.lua"
    local ok, config = pcall(dofile, chadrc_path)
    if ok and type(config) == "table" then
      print("Loaded chadrc from:", chadrc_path)
      return config
    end
  end
  
  -- Fallback: try relative paths
  local fallback_paths = {"../chadrc.lua", "chadrc.lua"}
  for _, path in ipairs(fallback_paths) do
    local ok, config = pcall(dofile, path)
    if ok and type(config) == "table" then
      print("Loaded chadrc from fallback:", path)
      return config
    end
  end
  
  print("Could not load chadrc")
  return nil
end

local my_chadrc = load_chadrc()

-- Inject chadrc into the module system
if my_chadrc then
  package.loaded["chadrc"] = my_chadrc
  print("Injected chadrc into module system")
  
  -- Test it
  local test_ok, test_chadrc = pcall(require, "chadrc")
  print("chadrc require test:", test_ok, type(test_chadrc))
end

-- Continue with nvchad setup
local base46_ok, base46 = pcall(require, "base46")
if base46_ok and base46.load_all_highlights then
  base46.load_all_highlights()
  print("base46 highlights loaded")
end

local nvchad_ok, nvchad = pcall(require, "nvchad")
print("nvchad loaded:", nvchad_ok)

-- Load cache files
local cache_dir = vim.g.base46_cache
if vim.fn.isdirectory(cache_dir) == 1 then
  for _, v in ipairs(vim.fn.readdir(cache_dir)) do
    pcall(dofile, cache_dir .. v)
  end
end

print("nvchad-ui setup complete")
