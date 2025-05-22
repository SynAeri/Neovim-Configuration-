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
  # Generate luanix configs (including nvconfig.lua)
  luanix = nixFiles2ConfigFiles "luanix";
in ''
  ${builtins.concatStringsSep "\n" (builtins.map (file: "luafile ${file}") luanix)}
  luafile ${configs}/nvim-0-init.lua
  luafile ${configs}/nvim-setters.lua
  luafile ${configs}/plugins/nvim-chadui.lua
  luafile ${configs}/plugins/nvim-telescope.lua
  luafile ${configs}/plugins/nvim-treesitter.lua
''
