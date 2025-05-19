{ config, pkgs, lib, ... }:

{
  # Enable Neovim with Nix
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    
    # We'll start with a minimal package list and keep using your existing config
    configure = {
      # Just list a few core plugins to start with
      packages.myVimPackage = with pkgs.vimPlugins; {
        start = [
          # Add a few essential plugins you're using
          # For example:
          nvim-lspconfig
          nvim-cmp
          telescope-nvim
          plenary-nvim
          
          # List more plugins from your current setup here
        ];
      };
      
      # This is where we'll gradually migrate your config
      customRC = ''
        " Import your existing config
      '';
    };
    
    # Any system-level packages needed by your plugins
  };
}
