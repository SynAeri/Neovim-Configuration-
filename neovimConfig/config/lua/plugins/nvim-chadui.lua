-- config/lua/plugins/nvim-chadui.lua
print("=== Loading nvchad-ui ===")

-- CRITICAL: Add the config directory to Lua's package path
-- This is the key missing piece!
local config_path = debug.getinfo(1, "S").source:sub(2):match("(.*)/")
if config_path then
  local parent_path = config_path:match("(.*)/plugins")
  if parent_path then
    package.path = parent_path .. "/?.lua;" .. parent_path .. "/?/init.lua;" .. package.path
    print("Added to package.path:", parent_path)
  end
end

-- Now test if chadrc can be required
local chadrc_ok, chadrc = pcall(require, "chadrc")
print("chadrc loaded after path fix:", chadrc_ok)

if chadrc_ok then
  print("SUCCESS! chadrc loaded:", type(chadrc))
  if chadrc.nvdash then
    print("Dashboard header lines:", #chadrc.nvdash.header)
  end
else
  print("Still failed:", chadrc)
end

-- Set up base46 cache directory
vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46_cache/"

-- Load base46 and nvchad
local base46_ok, base46 = pcall(require, "base46")
if base46_ok and base46.load_all_highlights then
  base46.load_all_highlights()
  print("base46 highlights loaded")
end

-- Load nvchad
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
