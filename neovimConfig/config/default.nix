# config/default.nix
{ pkgs }:
let
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
      
      # Get all entries in the directory
      entries = builtins.readDir configDir;
      
      # Filter to only include regular files (not directories)
      fileNames = builtins.filter (name: 
        entries.${name} == "regular"  # This excludes the "plugins" directory
      ) (builtins.attrNames entries);
      
    in builtins.map (file: "${configDir}/${file}") fileNames;

  sourceConfigFiles = files:
    builtins.concatStringsSep "\n" (builtins.map (file:
      (if pkgs.lib.strings.hasSuffix "lua" file then "luafile" else "source")
      + " ${file}") files);

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
