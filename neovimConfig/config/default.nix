# config/default.nix
{ pkgs }:
let
  # Process files in the main lua directory
  mainLuaFiles = let
    configDir = pkgs.stdenv.mkDerivation {
      name = "nvim-lua-configs";
      src = ./lua;
      installPhase = ''
        mkdir -p $out/
        cp ./*.lua $out/ || true
      '';
    };
  in builtins.map (file: "${configDir}/${file}")
    (builtins.attrNames (builtins.readDir configDir));

  # Process files in the plugins subdirectory
  pluginsLuaFiles = let
    configDir = pkgs.stdenv.mkDerivation {
      name = "nvim-lua-plugins-configs";
      src = ./lua/plugins;
      installPhase = ''
        mkdir -p $out/
        cp ./*.lua $out/ || true
      '';
    };
  in builtins.map (file: "${configDir}/${file}")
    (builtins.attrNames (builtins.readDir configDir));

  # Create luafile commands for a list of files
  sourceConfigFiles = files:
    builtins.concatStringsSep "\n" (builtins.map (file:
      "luafile ${file}") files);

  # Combine all lua files, main files first
  allLuaFiles = mainLuaFiles ++ pluginsLuaFiles;
in sourceConfigFiles allLuaFiles
