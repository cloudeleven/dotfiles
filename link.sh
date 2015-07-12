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

