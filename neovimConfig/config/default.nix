# config/default.nix
{ pkgs }:
let
  # Process files in the main lua directory with explicit ordering
  mainLuaFiles = let
    configDir = pkgs.stdenv.mkDerivation {
      name = "nvim-lua-configs";
      src = ./lua;
      installPhase = ''
        mkdir -p $out/
        # Copy chadrc.lua first if it exists
        if [ -f chadrc.lua ]; then
          cp chadrc.lua $out/
        fi
        # Then copy other .lua files
        for file in *.lua; do
          if [ "$file" != "chadrc.lua" ] && [ -f "$file" ]; then
            cp "$file" $out/
          fi
        done
      '';
    };
    
    # Get files and sort them to ensure chadrc.lua comes first
    files = builtins.attrNames (builtins.readDir configDir);
    sortedFiles = builtins.sort (a: b: 
      if a == "chadrc.lua" then true
      else if b == "chadrc.lua" then false
      else a < b
    ) files;
  in builtins.map (file: "${configDir}/${file}") sortedFiles;

  # Process files in the plugins subdirectory (unchanged)
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

  # Combine all lua files, main files first (which now has chadrc.lua first)
  allLuaFiles = mainLuaFiles ++ pluginsLuaFiles;
in sourceConfigFiles allLuaFiles
