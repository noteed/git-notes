# This is a set of derivations constructing particular Git repositories.
#
# Example build instruction:
#   nix-build -A init

let
  pkgs = import <nixpkgs> {};
in
rec {
  init = pkgs.stdenv.mkDerivation {
    name = "init";
    builder = scripts/init.sh;
    buildInputs = with pkgs; [ git tree ];
  };

  site = (import site/default.nix {}).all;
}
