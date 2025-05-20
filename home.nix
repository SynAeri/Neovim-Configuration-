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
      nvim-treesitter.withAllGrammars

      # Completion
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      
      # Snippets
      luasnip
      
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
  };
  
  # Add other Home Manager configurations here
  
  # This value determines the Home Manager release
  home.stateVersion = "24.05"; # Match your NixOS version
}
