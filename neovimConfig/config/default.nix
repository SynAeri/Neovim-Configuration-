# config/default.nix
{ pkgs }:
let
  # Create configs preserving the nested structure
  configs = pkgs.stdenv.mkDerivation {
    name = "nvim-configs";
    src = ./lua;
    installPhase = ''
      mkdir -p $out
      # Copy everything preserving the directory structure
      cp -r . $out/
    '';
  };

in ''
  -- Add the configs directory to Lua's package path so require() can find modules
  lua package.path = "${configs}/?.lua;" .. "${configs}/?/init.lua;" .. package.path
  
  -- Load the configuration files in order
  luafile ${configs}/nvim-0-init.lua
  luafile ${configs}/nvim-setters.lua
  luafile ${configs}/plugins/nvim-chadui.lua
  luafile ${configs}/plugins/nvim-telescope.lua
  luafile ${configs}/plugins/nvim-treesitter.lua
''
