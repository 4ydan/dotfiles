#!/bin/sh
set -e

# add aliases for dotfiles
for file in $(find "$PWD" -name ".*" -not -name ".gitignore" -not -name ".git" -not -name ".config" -not -name ".github" -not -name ".*.swp" -not -name ".gnupg"); do
    f=$(basename "$file")
    ln -sfn "$file" "$HOME/$f"
done
