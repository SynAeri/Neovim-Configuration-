# config/default.nix
{ pkgs }:
let
  # Recursively find all .lua files
  findLuaFiles = dir:
    let
      entries = builtins.readDir dir;
      
      # Get regular .lua files in current directory
      luaFiles = builtins.filter (name: 
        entries.${name} == "regular" && pkgs.lib.hasSuffix ".lua" name
      ) (builtins.attrNames entries);
      
      # Get subdirectories
      subdirs = builtins.filter (name: 
        entries.${name} == "directory"
      ) (builtins.attrNames entries);
      
      # Recursively get files from subdirectories
      subFiles = builtins.concatLists (builtins.map (subdir:
        let
          subPath = dir + "/${subdir}";
          subEntries = builtins.readDir subPath;
          subLuaFiles = builtins.filter (name:
            subEntries.${name} == "regular" && pkgs.lib.hasSuffix ".lua" name
          ) (builtins.attrNames subEntries);
        in builtins.map (file: "${subdir}/${file}") subLuaFiles
      ) subdirs);
      
    in luaFiles ++ subFiles;

  scripts2ConfigFiles = dir:
    let
      configDir = pkgs.stdenv.mkDerivation {
        name = "nvim-${dir}-configs";
        src = ./${dir};
        installPhase = ''
          mkdir -p $out/
          cp -r . $out/
        '';
      };
      
      allFiles = findLuaFiles ./${dir};
      
    in builtins.map (file: "${configDir}/${file}") allFiles;

  sourceConfigFiles = files:
    builtins.concatStringsSep "\n" (builtins.map (file:
      "luafile ${file}") files);

  # Get the lua config directory for package path
  luaConfigDir = pkgs.stdenv.mkDerivation {
    name = "nvim-lua-configs";
    src = ./lua;
    installPhase = ''
      mkdir -p $out/
      cp -r . $out/
    '';
  };

  lua = scripts2ConfigFiles "lua";

in ''
  lua package.path = "${luaConfigDir}/?.lua;" .. "${luaConfigDir}/?/init.lua;" .. package.path
  ${sourceConfigFiles lua}
''
