-- config/lua/plugins/nvim-chadui.lua

-- Add the config directory to Lua's package path
local config_path = debug.getinfo(1, "S").source:sub(2):match("(.*)/")
if config_path then
  local parent_path = config_path:match("(.*)/plugins")
  if parent_path then
    package.path = parent_path .. "/?.lua;" .. parent_path .. "/?/init.lua;" .. package.path
  end
end

-- Set up base46 cache directory
vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46_cache/"

-- Load YOUR chadrc configuration
local my_chadrc = require("chadrc")

-- CRITICAL: Override nvconfig with your chadrc BEFORE loading nvchad
-- This ensures nvchad uses YOUR config instead of the default
package.loaded["nvconfig"] = my_chadrc

-- Verify the override worked
local nvconfig_test = require("nvconfig")
if nvconfig_test.nvdash and nvconfig_test.nvdash.header then
  print("nvconfig override successful - header lines:", #nvconfig_test.nvdash.header)
  print("load_on_startup:", nvconfig_test.nvdash.load_on_startup)
else
  print("nvconfig override failed!")
end

-- Load base46 with YOUR theme
local base46_ok, base46 = pcall(require, "base46")
if base46_ok then
  -- Apply your theme from chadrc
  if my_chadrc.base46 and my_chadrc.base46.theme then
    vim.g.nvchad_theme = my_chadrc.base46.theme
  end
  
  if base46.load_all_highlights then
    base46.load_all_highlights()
  end
end

-- Now load nvchad - it will use your overridden nvconfig
require("nvchad")

-- Load cache files
local cache_dir = vim.g.base46_cache
if vim.fn.isdirectory(cache_dir) == 1 then
  for _, v in ipairs(vim.fn.readdir(cache_dir)) do
    pcall(dofile, cache_dir .. v)
  end
end

print("nvchad-ui loaded with custom configuration")
