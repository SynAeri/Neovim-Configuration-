{ config, pkgs, lib, ... }:
{
  # Enable Neovim with Nix
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    
    configure = {
      packages.myVimPackage = with pkgs.vimPlugins; {
        start = [
          # Core plugins
          nvim-lspconfig
          nvim-cmp
          telescope-nvim
          plenary-nvim
          
          # Theme and UI
          tokyonight-nvim
          lualine-nvim
        ];
      };
      
      customRC = ''
        " Set color scheme and UI options
        set termguicolors
        colorscheme tokyonight
        
        " Set some distinctive visual options
        set number
        set relativenumber
        set cursorline
        
        " Configure status line
        lua << EOF
        require('lualine').setup {
          options = {
            theme = 'tokyonight',
            icons_enabled = true,
            component_separators = { left = '|', right = '|'},
            section_separators = { left = '', right = ''},
          }
        }
        EOF
      '';
    };
  };
}
