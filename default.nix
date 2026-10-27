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

  first-commit = pkgs.runCommand "first-commit" {} ''
    export GIT_AUTHOR_NAME="Alice"
    export GIT_AUTHOR_EMAIL="alice@example.com"
    export GIT_AUTHOR_DATE="1970-01-01T00:00:00"
    export GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
    export GIT_COMMITTER_DATE="$GIT_AUTHOR_DATE"
    export GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"
    export TZ="UTC"

    ${pkgs.git}/bin/git init $out
    cd $out/

    ${pkgs.git}/bin/git commit --allow-empty -m'Initial commit.'
  '';

  first-commit-tree = pkgs.runCommand "first-commit-tree" {} ''
    ${pkgs.tree}/bin/tree -a ${first-commit} > $out
  '';

  site = (import site/default.nix {}).html.all;
}
