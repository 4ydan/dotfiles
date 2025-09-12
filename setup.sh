#!/bin/sh
set -e

# Install starship prompt only if not already installed
if ! command -v starship > /dev/null 2>&1; then
    echo "Installing starship..."
    curl -sS https://starship.rs/install.sh | sh
else
    echo "Starship already installed, skipping..."
fi

# add aliases for dotfiles (excluding .git)
for file in $(find "$PWD" -name ".*" -not -name ".git"); do
    f=$(basename "$file")
    echo "Linking $file -> $HOME/$f"
    ln -sfn "$file" "$HOME/$f"
done

sudo apt-get update

for file in $(find "$PWD/installs" -name "*.sh"); do
  # Check if any shell scripts are found
  if [ -f "$file" ]; then
    echo "Setting permissions to 755 for $file"
    chmod 755 "$file"
    echo "Executing $file"
    "$file"
  fi
done
