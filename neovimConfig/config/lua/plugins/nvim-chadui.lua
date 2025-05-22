-- config/lua/plugins/nvim-chadui.lua

-- Set up base46 cache directory
vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46_cache/"

-- Test if chadrc is now available
local chadrc_ok, chadrc = pcall(require, "chadrc")
print("chadrc available:", chadrc_ok)
if chadrc_ok and chadrc.nvdash then
  print("chadrc dashboard header lines:", #chadrc.nvdash.header)
end

-- Load base46 and nvchad (should now find and merge chadrc automatically)
local base46_ok, base46 = pcall(require, "base46")
if base46_ok and base46.load_all_highlights then
  base46.load_all_highlights()
end

-- Load nvchad (should automatically find and merge chadrc with nvconfig)
require("nvchad")

-- Test the final merged nvconfig
local final_nvconfig = require("nvconfig")
if final_nvconfig.nvdash then
  print("Final nvconfig dashboard header lines:", #final_nvconfig.nvdash.header)
  print("Final load_on_startup:", final_nvconfig.nvdash.load_on_startup)
end

-- Load cache files
local cache_dir = vim.g.base46_cache
if vim.fn.isdirectory(cache_dir) == 1 then
  for _, v in ipairs(vim.fn.readdir(cache_dir)) do
    pcall(dofile, cache_dir .. v)
  end
end
