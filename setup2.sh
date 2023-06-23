#!/bin/bash
# shellcheck disable=SC2016
set -e -o pipefail

(( BASH_VERSINFO[0] < 4 )) && echo "Bash 4+ required." && exit 1

: "${PAGER:=more}"
: "${EDITOR:=vi}"
: "${HELP_BROWSER:=}"
: "${EXE:="${0##*/}"}"

export NEEDRESTART_SUSPEND=yes
export HOMEBIN="$HOME/.local/bin"

mkdir -p "$HOMEBIN"

declare -A HELP
declare -A CONF

declare black="\e[30m"
declare red="\e[31m"
declare green="\e[32m"
declare yellow="\e[33m"
declare blue="\e[34m"
declare magenta="\e[35m"
declare cyan="\e[36m"
declare white="\e[37m"
declare reset="\e[0m"

HELP[update]='Runs apt-get update and upgrade'

x.update () {
  set -x
  sudo apt-get -y update
  sudo apt-get -y upgrade
  set +x
}

x.base () {
  sudo apt-get -y install \
    vim w3m git pandoc nmap jq figlet cmatrix entr make
}

x.lynx () {
  sudo apt-get -y install lynx
  lynxconfd="$HOME/.config/lynx"
  mkdir -p "$lynxconfd"
  curl -fsSL https://raw.githubusercontent.com/rwxrob/dot/main/lynx/lynx.cfg \
	  -o "$lynxconfd/lynx.cfg"
  curl -fsSL https://raw.githubusercontent.com/rwxrob/dot/main/lynx/lynx.lss \
	  -o "$lynxconfd/lynx.lss"
  for i in lynx duck google bing urlencode; do 
    curl -fsSL "https://raw.githubusercontent.com/rwxrob/dot/main/scripts/$i" \
	  -o "$HOMEBIN/$i"
    chmod +x "$HOMEBIN/$i"
  done
}

x.go () {
  sudo apt-get -y install golang gopls
}

x.python () {
  sudo apt-get -y install python-is-python3
}

x.fishies () {
  sudo apt-get -y install libcurses-perl
  sudo cpan -I Term::Animation
  curl -fsSL https://raw.githubusercontent.com/rwxrob/dot/main/scripts/fishies -o "$HOMEBIN"/fishies
  chmod +x "$HOMEBIN/fishies"
}

x.gh () {
  curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | \
    sudo dd of=/etc/apt/trusted.gpg.d/githubcli-archive-keyring.gpg

  echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/trusted.gpg.d/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | \
    sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null

  sudo apt update
  sudo apt install gh
}

x.bash () {
  curl -fsSL https://raw.githubusercontent.com/rwxrob/dot/main/.bashrc -o "$HOME/.bashrc"
}

x.vim () {
  curl -fsSL https://raw.githubusercontent.com/rwxrob/dot/main/vim/.vimrc -o "$HOME/.vimrc"
  curl -fsSL https://raw.githubusercontent.com/rwxrob/dot/main/scripts/vic -o "$HOMEBIN/vic"
  chmod +x "$HOMEBIN/vic"
}

x.tmux () {
  curl -fsSL https://raw.githubusercontent.com/rwxrob/dot/main/tmux/.tmux.conf -o "$HOME/.tmux.conf"
}

x.scripts () {
  curl -fsSL https://raw.githubusercontent.com/rwxrob/dot/main/scripts/blankpane \
	  -o "$HOMEBIN/blankpane"
  chmod +x "$HOMEBIN/blankpane"
}
