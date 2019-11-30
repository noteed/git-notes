---
title: Git notes
---

## git init

```
$ nix-build -A init
@result@
```

In this derivation, we use `git init` to create a new repository. We run that
command passing a non-existing directory as argument (i.e. `git init
$out/repo`), which will be created and turned into a repository.

Without an argument, it turns the _current_ directory into a repository, which
is what is often used in pratice.

In addition of the repository itself, this derivation also have two files, one
with the command output, and one showing the content of the repository (using
the `tree` command).

If the command was run interactively, it would look like:

```
$ git init @result@/repo
@initoutput@
```

```
$ tree -anF @result@/repo
@inittree@
```

The complete script run in this derivation:

```
@script@
```
