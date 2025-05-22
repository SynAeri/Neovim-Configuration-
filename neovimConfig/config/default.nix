# config/default.nix
{ pkgs }:
let
  # Your existing function for regular files (keep this exactly as it was)
  configs = pkgs.stdenv.mkDerivation {
    name = "nvim-configs";
    src = ./lua;
    installPhase = ''
      mkdir -p $out
      cp -r . $out/
    '';
  };

in ''
  lua package.path = "${configs}/?.lua;" .. "${configs}/?/init.lua;" .. package.path
  luafile ${configs}/nvim-0-init.lua
  luafile ${configs}/nvim-setters.lua
  luafile ${configs}/plugins/nvim-chadui.lua
  luafile ${configs}/plugins/nvim-telescope.lua
  luafile ${configs}/plugins/nvim-treesitter.lua
''
