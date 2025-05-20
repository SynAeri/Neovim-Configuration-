{ config, pkgs, lib, ... }:

let
  fromGitHub = ref: repo: pkgs.vimUtils.buildVimPlugin {
    pname = "${lib.strings.sanitizeDerivationName repo}";
    version = ref;
    src = builtins.fetchGit {
      url = "https://github.com/${repo}.git";
      ref = ref;
    };
  };
in
{
  # Home Manager config here
  home.username = "jordanm";
  home.homeDirectory = "/home/jordanm";
  
  # Let Home Manager manage itself
  programs.home-manager.enable = true;
  
  # Neovim configuration
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    
    plugins = with pkgs.vimPlugins; [
      # LSP
      nvim-lspconfig
      
      # Treesitter with specific languages
      (nvim-treesitter.withPlugins (plugins: with plugins; [
        bash
        c
        lua
        nix
        python
        javascript
        typescript
        html
        css
        json
      ]))
      
      # Completion
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      
      # Snippets
      luasnip
      cmp-luasnip
      
      # Utilities
      plenary-nvim
      telescope-nvim
      
      # Theme
      tokyonight-nvim
      
      # Status line
      lualine-nvim
      
      # Example of using the fromGitHub function for a plugin not in nixpkgs
      (fromGitHub "HEAD" "folke/which-key.nvim")
    ];
    
    # Your Neovim configuration
    extraConfig = ''
      " Basic settings
      set number
      set relativenumber
      set expandtab
      set tabstop=2
      set shiftwidth=2
      set autoindent
      set termguicolors
      
      " Set the leader key
      let mapleader = " "
      
      " Theme
      colorscheme tokyonight
    '';
    
    # Lua configuration (for plugins that need it)
    extraLuaConfig = ''
      -- LSP Configuration
      local lspconfig = require('lspconfig')
      
      -- Setup language servers
      lspconfig.pyright.setup{}
      lspconfig.tsserver.setup{}
      lspconfig.nil_ls.setup{}  -- Nix LSP
      
      -- Status line
      require('lualine').setup{
        options = {
          theme = 'tokyonight',
          component_separators = { left = '|', right = '|'},
          section_separators = { left = '', right = ''},
        }
      }
      
      -- Telescope keymaps
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
      vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
      
      -- Setup which-key
      require("which-key").setup{}
      
      -- Setup nvim-cmp
      local cmp = require('cmp')
      local luasnip = require('luasnip')
      
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        }, {
          { name = 'buffer' },
        })
      })
    '';
  };
  
  # Add other Home Manager configurations here
  
  # This value determines the Home Manager release
  home.stateVersion = "24.05"; # Match your NixOS version
}
