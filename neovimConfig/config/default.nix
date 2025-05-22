# config/default.nix
{ pkgs }:
let
  # Create lua config derivation that preserves directory structure
  luaConfigs = pkgs.stdenv.mkDerivation {
    name = "nvim-lua-configs";
    src = ./lua;
    installPhase = ''
      mkdir -p $out
      # Copy everything preserving structure
      cp -r . $out/
    '';
  };

  # Manually specify the loading order
  configFiles = [
    "chadrc.lua"                    # Load chadrc first
    "nvim-0-init.lua"              # Then basic configs
    "nvim-setters.lua"
    "debug-chadrc.lua"
    "debug-path.lua"
    "plugins/nvim-chadui.lua"      # Then plugins
    "plugins/nvim-telescope.lua"
    "plugins/nvim-treesitter.lua"
  ];

  # Generate luafile commands
  luaCommands = builtins.map (file: "luafile ${luaConfigs}/${file}") configFiles;

in builtins.concatStringsSep "\n" luaCommands
