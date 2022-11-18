#!/bin/bash

for f in .??*
do
    case "$f" in
    ".git" | \
    ".gitmodules" | \
    ".DS_Store" | \
    *.swp \
    ) continue;;
    esac
	
#    echo "${HOME}/dotfiles/$f" "${HOME}/${f}"
    ln -sfnv "${HOME}/dotfiles/$f" "${HOME}/${f}"
done

ln -sfnv "${HOME}/dotfiles/private-settings/my.rule" "${HOME}/Library/Application Support/AquaSKK/"

# color-scheme: https://reasonable-code.com/solarized/

