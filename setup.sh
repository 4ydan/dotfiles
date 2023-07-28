#!/bin/sh
set -e

# add aliases for dotfiles
for file in $(find "$PWD" -name ".*"); do
    f=$(basename "$file")
    ln -sfn "$file" "$HOME/$f"
done
ln -sfn "$PWD/gitignore" "$HOME/.gitignore"

apt-get update

for file in $(find "$PWD/installs" -name "*.sh"); do
  # Check if any shell scripts are found
  if [ -f "$file" ]; then
    echo "Setting permissions to 755 for $file"
    chmod 755 "$file"
    echo "Executing $file"
    "$file"
  fi
done
