-- config/lua/plugins/nvim-chadui.lua
-- Set up base46 cache directory (must be done before lazy setup)
vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46_cache/"

-- Load base46 and nvchad
local base46_ok, base46 = pcall(require, "base46")
if base46_ok and base46.load_all_highlights then
  base46.load_all_highlights()
end

-- Load nvchad (this will automatically look for chadrc.lua)
require("nvchad")

-- Load essential cache files
local cache_dir = vim.g.base46_cache
if vim.fn.isdirectory(cache_dir) == 1 then
  -- Load the essential ones
  pcall(dofile, cache_dir .. "defaults")
  pcall(dofile, cache_dir .. "statusline")
  
  -- Or load all at once (as suggested in the docs)
  for _, v in ipairs(vim.fn.readdir(cache_dir)) do
    pcall(dofile, cache_dir .. v)
  end
end

-- Set up keymaps
vim.keymap.set('n', '<leader>th', function()
  require('nvchad.themes').open()
end, { noremap = true, silent = true, desc = "Theme switcher" })

vim.keymap.set('n', '<leader>ch', ':NvCheatsheet<CR>', { noremap = true, silent = true, desc = "Show cheatsheet" })
