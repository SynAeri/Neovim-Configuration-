{ pkgs }:
with pkgs.vimPlugins; [
  telescope-nvim
  plenary-nvim
  nvchad-ui
  base46
  nvim-web-devicons
  lazy-nvim
  nvim-treesitter.withAllGrammars
  
  # Tree-sitter related plugins
  nvim-treesitter-textobjects  # Enhanced text objects
  nvim-treesitter-context      # Show current function/class context

]
