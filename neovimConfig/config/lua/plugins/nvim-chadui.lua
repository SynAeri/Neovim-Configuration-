-- config/lua/plugins/nvim-chadui.lua

-- Set up base46 cache directory
vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46_cache/"

-- Load base46 and nvchad (nvconfig.lua will be loaded automatically from luanix)
local base46_ok, base46 = pcall(require, "base46")
if base46_ok and base46.load_all_highlights then
  base46.load_all_highlights()
end

-- Load nvchad
require("nvchad")

-- Load cache files
local cache_dir = vim.g.base46_cache
if vim.fn.isdirectory(cache_dir) == 1 then
  for _, v in ipairs(vim.fn.readdir(cache_dir)) do
    pcall(dofile, cache_dir .. v)
  end
end
