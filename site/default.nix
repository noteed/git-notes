# This is a set of derivations to create Markdown files to document Git.
#
# Example build instruction:
#  nix-build site/ -A md.init

let
  sources = import ../nix/26.05/nix/sources.nix;
  pkgs = import sources.nixpkgs {};
  artefacts = import ../default.nix;

  inherit (import sources.hypered-design) to-html;
in rec
{
  md.index = ./index.md;
  md.init = pkgs.replaceVars ./init.md {
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
