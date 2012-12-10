#!/bin/zsh

ln -sf $(pwd)/.* ~/
rm ~/.git(@)
rm ~/.gitignore(@)
emacs --batch -Q -l .emacs.d/init.el -L .emacs.d/auto-install/ -f batch-byte-compile .emacs.d/**/*.el
