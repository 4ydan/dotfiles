#!/bin/sh
set -e

# Install starship prompt
curl -sS https://starship.rs/install.sh | sh

# add aliases for dotfiles (excluding .git)
for file in $(find "$PWD" -name ".*" -not -name ".git"); do
    f=$(basename "$file")
    ln -sfn "$file" "$HOME/$f"
done

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
