-- config/lua/plugins/nvim-neo-tree.lua
require("neo-tree").setup({
  filesystem = {
    follow_current_file = {
      enabled = true
    },
    filtered_items = { hide_dotfiles = false },
    hijack_netrw_behavior = "open_default",
  },
  window = {
    width = 40,
    focus_on_open = false,
    position = "right",
  },
})

vim.api.nvim_set_keymap("n", "<leader>tr", ":Neotree toggle right<CR>", { noremap = true, silent = true, desc = "Toggle Neo-tree" })
