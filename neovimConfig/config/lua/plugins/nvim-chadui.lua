-- config/lua/plugins/nvim-chadui.lua
print("=== Loading nvchad-ui ===")

-- Set up base46 cache directory (must be done before lazy setup)
vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46_cache/"

-- Define your configuration inline (as a workaround)
local my_nvchad_config = {
  base46 = {
    theme = "onedark",
    transparency = false,
    theme_toggle = { "onedark", "one_light" },
  },
  ui = {
    statusline = {
      theme = "vscode_colored",
      separator_style = "default",
    },
    tabufline = {
      enabled = true,
      lazyload = false,
    },
    cmp = {
      lspkind_text = true,
      style = "default",
    },
    telescope = { style = "borderless" },
  },
  nvdash = {
    load_on_startup = true,
    header = {
      "                            ",
      "⠤⠤⠤⠤⠤⠤⢤⣄⣀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠙⠒⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠤⠤⠶⠶⠶⠦⠤⠤⠤⠤⠤⢤⣤⣀⣀⣀⣀⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⢀⠄⢂⣠⣭⣭⣕⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠤⠀⠀⠀⠤⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠉⠉⠉⠉⠉⠉⠉",
      "⠀⠀⢀⠜⣳⣾⡿⠛⣿⣿⣿⣦⡠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⣤⣤⣤⣤⣤⣤⣤⣤⣤⣍⣀⣦⠦⠄⣀⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠠⣄⣽⣿⠋⠀⡰⢿⣿⣿⣿⣿⣦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⣿⡿⠛⠛⡿⠿⣿⣿⣿⣿⣿⣿⣷⣶⣿⣁⣂⣤⡄⠀⠀⠀⠀⠀⠀",
      "⢳⣶⣼⣿⠃⠀⢀⠧⠤⢜⣿⣿⣿⣿⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣾⠟⠁⠀⠀⠀⡇⠀⣀⡈⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⡀⠁⠐⠀⣀⠀⠀",
      "⠀⠙⠻⣿⠀⠀⠀⠀⠀⠀⢹⣿⣿⡝⢿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⡿⠋⠀⠀⠀⠀⠠⠃⠁⠀⠀⠙⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣿⡿⠋⠀⠀",
      "⠀⠀⠀⠙⡄⠀⠀⠀⠀⠀⢸⣿⣿⡃⢼⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⣿⣿⡏⠉⠉⠻⣿⡿⠋⠀⠀⠀⠀",
      "⠀⠀⠀⠀⢰⠀⠀⠰⡒⠊⠻⠿⠋⠐⡼⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣿⣿⣿⣿⠀⠀⠀⠀⣿⠇⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠸⣇⡀⠀⠑⢄⠀⠀⠀⡠⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢖⠠⠤⠤⠔⠙⠻⠿⠋⠱⡑⢄⠀⢠⠟⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠈⠉⠒⠒⠻⠶⠛⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⡄⠀⠀⠀⠀⠀⠀⠀⠀⠡⢀⡵⠃⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠦⣀⠀⠀⠀⠀⠀⢀⣤⡟⠉⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠉⠉⠉⠙⠛⠓⠒⠲⠿⢍⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "                            ",
    },
    buttons = {
      { txt = " Find File", keys = "ff", cmd = "Telescope find_files" },
      { txt = "󰈔 Recent Files", keys = "fo", cmd = "Telescope oldfiles" },
      { txt = "󰈭 Find Word", keys = "fw", cmd = "Telescope live_grep" },
      { txt = "󱥚 Themes", keys = "th", cmd = ":lua require('nvchad.themes').open()" },
      { txt = "󰪛 Mappings", keys = "ch", cmd = "NvCheatsheet" },
      { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },
      { txt = "  Neovim Ready!", hl = "NvDashFooter", no_gap = true },
      { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },
    },
  },
}

-- Try to override the nvconfig with our configuration
-- This is a workaround to inject our config
local nvconfig_ok, nvconfig = pcall(require, "nvconfig")
if not nvconfig_ok then
  -- Create nvconfig manually since chadrc isn't loading
  package.loaded["nvconfig"] = my_nvchad_config
  print("Created nvconfig manually with our configuration")
end

-- Load base46 and nvchad
local base46_ok, base46 = pcall(require, "base46")
if base46_ok and base46.load_all_highlights then
  base46.load_all_highlights()
  print("base46 highlights loaded")
end

-- Load nvchad
local nvchad_ok, nvchad = pcall(require, "nvchad")
print("nvchad loaded:", nvchad_ok)

-- Manually trigger dashboard with our config
if my_nvchad_config.nvdash and my_nvchad_config.nvdash.load_on_startup then
  vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
      if vim.fn.argc() == 0 then
        vim.defer_fn(function()
          local nvdash_ok, nvdash = pcall(require, "nvchad.nvdash")
          if nvdash_ok and nvdash.open then
            nvdash.open()
          else
            print("Dashboard not available")
          end
        end, 100)
      end
    end,
  })
end

-- Load cache files
local cache_dir = vim.g.base46_cache
if vim.fn.isdirectory(cache_dir) == 1 then
  for _, v in ipairs(vim.fn.readdir(cache_dir)) do
    pcall(dofile, cache_dir .. v)
  end
end

print("nvchad-ui setup complete")
