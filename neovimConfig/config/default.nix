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
          cp -r . $out/  # Use -r to preserve directory structure
        '';
      };
    in builtins.map (file: "${configDir}/${file}")
    (builtins.attrNames (builtins.readDir configDir));

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
