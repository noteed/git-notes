# Git notes

This is a collection of short notes about Git. When some commands are
demonstrated, they are run using Nix to capture the results, which are then
embedded into Markdown files. Those files can be further processed to build
HTML files, e.g. with Pandoc.


## List of notes

Each note starts with the command to build its associated Nix derivation. The
available notes are:

- [`git init`](generated/init.md)


## Building

Each repository and associated documentation can be built separately. For
instance, to build a repository demonstrating the [`git
init`](generated/init.md) command, one can run:

```
$ nix-build -A init
```

To build the Markdown file corresponding to that same command:

```
$ nix-build site/ -A md.init
```

To build all the notes, these two commands are equivalent:

```
$ nix-build site/ -A all
$ nix-build -A site
```

The generated Markdown files can be seen in the `generated/` directory.
