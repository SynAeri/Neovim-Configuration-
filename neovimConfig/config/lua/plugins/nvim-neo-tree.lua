-- config/lua/plugins/nvim-neo-tree.lua

neoTree = require("neo-tree")

neoTree.setup({
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

vim.keymap.set("n", "<leader>tr", ":Neotree toggle right<CR>", { desc = "Toggle Neo-tree" })
