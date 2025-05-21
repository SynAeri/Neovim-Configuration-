# packages/myNeovim.nix
{ pkgs }:
let
  customRC = import ../config { inherit pkgs; };
in  pkgs.wrapNeovim pkgs.neovim {
      configure = {
        inherit customRC;
         # here will come your custom configuration
      };
    }
