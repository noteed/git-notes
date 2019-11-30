---
title: Git notes
---

## git init

```
$ nix-build -A init
/nix/store/sr8k6bqzxs06lf56zlrlqqp4i0midjpl-init
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
$ git init /nix/store/sr8k6bqzxs06lf56zlrlqqp4i0midjpl-init/repo
Initialized empty Git repository in /nix/store/sr8k6bqzxs06lf56zlrlqqp4i0midjpl-init/repo/.git/

```

```
$ tree -anF /nix/store/sr8k6bqzxs06lf56zlrlqqp4i0midjpl-init/repo
/nix/store/sr8k6bqzxs06lf56zlrlqqp4i0midjpl-init/repo
`-- .git/
    |-- HEAD
    |-- branches/
    |-- config
    |-- description
    |-- hooks/
    |   |-- applypatch-msg.sample*
    |   |-- commit-msg.sample*
    |   |-- fsmonitor-watchman.sample*
    |   |-- post-update.sample*
    |   |-- pre-applypatch.sample*
    |   |-- pre-commit.sample*
    |   |-- pre-push.sample*
    |   |-- pre-rebase.sample*
    |   |-- pre-receive.sample*
    |   |-- prepare-commit-msg.sample*
    |   `-- update.sample*
    |-- info/
    |   `-- exclude
    |-- objects/
    |   |-- info/
    |   `-- pack/
    `-- refs/
        |-- heads/
        `-- tags/

10 directories, 15 files

```

The complete script run in this derivation:

```
# Demonstrate git init.

# This line is a Nix thing to let us use basic things such as `mkdir`.
source $stdenv/setup

# Set a few Git environment variables to always create exactly the same
# repository.
export GIT_AUTHOR_NAME="Alice"
export GIT_AUTHOR_EMAIL="alice@example.com"
export GIT_AUTHOR_DATE="1970-01-01T00:00:00"
export GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
export GIT_COMMITTER_DATE="$GIT_AUTHOR_DATE"
export GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"
export TZ="UTC"

mkdir $out

# Create a new repository in $out/repo, capturing the output.
git init $out/repo > $out/output.txt

# Capture the structure of the newly created repository.
#   -a shows hidden files (in particular our .git/ directory).
#   -n disables colors.
#   -F adds a slash in directory names.
tree -anF $out/repo > $out/tree.txt

```
