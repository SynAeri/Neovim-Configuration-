# config/default.nix
{ pkgs }:
let
  # Handle .nix files that generate lua (from the document)
  nixFiles2ConfigFiles = dir:
    builtins.map (file:
      pkgs.writeTextFile {
        name = pkgs.lib.strings.removeSuffix ".nix" file;
        text = import ./${dir}/${file} { inherit pkgs; };
      }) (builtins.attrNames (builtins.readDir ./${dir}));
  # Your existing function for regular files
  configs = pkgs.stdenv.mkDerivation {
    name = "nvim-configs";
    src = ./lua;
    installPhase = ''
      mkdir -p $out
      cp -r . $out/
    '';
  };
