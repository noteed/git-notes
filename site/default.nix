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
    repo = "design-system";
    rev = "a35d3a3fc099456bbe3696171c9d05fedf097b68";
    sha256 = "0r4cmnx8h8qac1m8hxvrf14ihnnc4kykz7zhn02d6s2gfvkgibhb";
  };

  template = (import design-system {}).template;
  lua-filter = (import design-system {}).lua-filter;

  to-html = src: pkgs.runCommand "init" {} ''
    ${pkgs.pandoc}/bin/pandoc \
      --from markdown \
      --to html \
      --standalone \
      --template ${template} \
      --lua-filter ${lua-filter} \
      --output $out \
      ${src}
  '';
in rec
{
  md.init = pkgs.substituteAll {
    src = ./init.md;
    result = artefacts.init;
    initoutput = builtins.readFile (artefacts.init + "/output.txt");
    inittree = builtins.readFile (artefacts.init + "/tree.txt");
    script = builtins.readFile ../scripts/init.sh;
  };

  md.all = pkgs.runCommand "all" {} ''
    mkdir $out
    cp ${md.init} $out/init.md
  '';

  html.index = to-html ./index.md;
  html.init = to-html md.init;

  html.all = pkgs.runCommand "all" {} ''
    mkdir $out
    cp ${html.index} $out/index.html
    cp ${html.init} $out/init.html
  '';
}
