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
  programs.git.enable = true;
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
      nvim-treesitter.withAllGrammars
      plenary-nvim
      gruvbox-material
      mini-nvim
      (fromGitHub "HEAD" "elihunter173/dirbuf.nvim")
    ];
    # Use the Nix package search engine to find
    # even more plugins : https://search.nixos.org/packages
  };
  
  # Add other Home Manager configurations here
  
  # This value determines the Home Manager release
  home.stateVersion = "24.05"; # Match your NixOS version
}
