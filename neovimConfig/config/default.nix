# config/default.nix
{ pkgs }:
let
  # Create configs that preserve the module structure
  configs = pkgs.stdenv.mkDerivation {
    name = "nvim-configs";
    src = ./lua;
    installPhase = ''
      mkdir -p $out
      cp -r . $out/
      
      # Ensure chadrc.lua is available as a proper module
      # Copy it to the root of the lua modules path
      if [ -f chadrc.lua ]; then
        cp chadrc.lua $out/chadrc.lua
      fi
    '';
  };

in ''
  -- Set up the Lua module path to include our configs
  lua package.path = "${configs}/?.lua;" .. "${configs}/?/init.lua;" .. package.path
  
  luafile ${configs}/nvim-0-init.lua
  luafile ${configs}/nvim-setters.lua
  luafile ${configs}/plugins/nvim-chadui.lua
  luafile ${configs}/plugins/nvim-telescope.lua
  luafile ${configs}/plugins/nvim-treesitter.lua
''
