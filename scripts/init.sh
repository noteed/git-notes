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
