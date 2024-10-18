#!/bin/bash

ALIASES="source ~/.aliases"
MY_LS_COLORS='export LS_COLORS="$LS_COLORS:di=1;34:ln=0;93:ex=1;31:"'

for FILE in $(ls); do
    if [[ ($FILE != "setup.sh") && (! -L "$HOME/.$FILE") && (! -f "$HOME/.$FILE") ]]; then
        ln -s $(realpath $FILE) "$HOME/.$FILE"
    fi
done

READ_COMMAND_FILES=('.zshrc' '.bashrc')
for READ_COMMAND in ${READ_COMMAND_FILES[@]}; do
    path="$HOME/"$READ_COMMAND
    grep -qxF "$ALIASES" "$path" || echo "$ALIASES" >> "$path"
    grep -qxF "$MY_LS_COLORS" "$path" || echo "$MY_LS_COLORS" >> "$path"
done