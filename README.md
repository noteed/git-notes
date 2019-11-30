# Git notes

This is a collection of short notes about Git. When some commands are
demonstrated, they are run using Nix to capture the results, which are then
embedded into Markdown files.

For instance to build a repository demonstrating the `git init` command, one
can run:

```
$ nix-build -A init
```

To build the Markdown file corresponding to that same command:

```
$ nix-build site/ -A md.init
```

To build all the notes:

```
$ nix-build site/ -A all
```
