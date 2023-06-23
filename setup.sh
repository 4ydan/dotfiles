#!/bin/sh
set -e

ln -sf "$PWD/.bashrc" "$HOME/.bashrc"
ln -sf "$PWD/.dircolors" "$HOME/.dircolors"
ln -sf "$PWD/.inputrc" "$HOME/.inputrc"
ln -sf "$PWD/.profile" "$HOME/.profile"
ln -sf "$PWD/.profile" "$HOME/.bash_profile"
ln -sf "$PWD/.gitconfig" "$HOME/.gitconfig"

for i in vim lynx gh git tmux docker podman iam; do
  cd $i && ./setup
  cd -
done
