-- config/lua/nvchad-ui.lua

-- Set up base46 cache directory (required by nvchad-ui)
vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46_cache/"

-- Load base46 (theme engine) first
local base46_ok, base46 = pcall(require, "base46")
if base46_ok and base46.load_all_highlights then
  base46.load_all_highlights()
end

-- Load nvchad UI (this will look for nvconfig.lua)
require("nvchad")

-- Load base46 cache files
local cache_dir = vim.g.base46_cache
if vim.fn.isdirectory(cache_dir) == 1 then
  local defaults_file = cache_dir .. "defaults"
  local statusline_file = cache_dir .. "statusline"
  local tabufline_file = cache_dir .. "tabufline"
  
  if vim.fn.filereadable(defaults_file) == 1 then
    dofile(defaults_file)
  end
  
  if vim.fn.filereadable(statusline_file) == 1 then
    dofile(statusline_file)
  end
  
  if vim.fn.filereadable(tabufline_file) == 1 then
    dofile(tabufline_file)
  end
end

-- Set up some useful keymaps
vim.keymap.set('n', '<leader>th', ':Telescope themes<CR>', { noremap = true, silent = true, desc = "Theme switcher" })
vim.keymap.set('n', '<leader>ch', ':NvCheatsheet<CR>', { noremap = true, silent = true, desc = "Show cheatsheet" })
