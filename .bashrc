#!/bin/bash

# Source the bash prompt configuration
if [[ -f "${HOME}/.bash_prompt" ]]; then
    source "${HOME}/.bash_prompt"
fi

# Load other dotfiles if they exist
for file in ~/.{aliases,functions,path,dockerfunc,extra,exports}; do
    if [[ -r "$file" ]] && [[ -f "$file" ]]; then
        source "$file"
    fi
done
unset file
