# This is a set of derivations to create Markdown files to document Git.
#
# Example build instruction:
#  nix-build site/ -A md.init

{ nixpkgs ? <nixpkgs>
}:

let
  pkgs = import nixpkgs {};
  artefacts = import ../default.nix;

  design-system = pkgs.fetchFromGitHub {
    owner = "hypered";
    repo = "design";
    rev = "00ec56920f1c86baa5ea0fdf96e5be79ce253fc6";
    sha256 = "04i1hbfvsd068zgrlxgppia9ryxv2l33h00aaj9l0grkcldlkr8c";
  };
  inherit (import design-system {}) to-html;

in rec
{
  md.index = ./index.md;
  md.init = pkgs.substituteAll {
    src = ./init.md;
    result = artefacts.init;
    initoutput = builtins.readFile (artefacts.init + "/output.txt");
    inittree = builtins.readFile (artefacts.init + "/tree.txt");
    script = builtins.readFile ../scripts/init.sh;
  };
  md.all = pkgs.runCommand "all" {} ''
    mkdir $out
    cp ${md.index} $out/index.md
    cp ${md.init} $out/init.md
  '';

  html.index = to-html md.index;
  html.init = to-html md.init;
  html.all = pkgs.runCommand "all" {} ''
    mkdir $out
    cp ${html.index} $out/index.html
    cp ${html.init} $out/init.html
  '';
}
