-- config/lua/plugins/nvim-chadui.lua

-- Initialize NvChad UI
require("nvchad").setup({
  -- Your configuration options here
  ui = {
    theme = "onedark",  -- Or whatever theme you prefer
  }
})

-- If you need to load base46 highlights
require("base46").load_all_highlights()
