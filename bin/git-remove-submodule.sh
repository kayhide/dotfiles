#!/bin/bash

if [ -z "$1" ]; then
    echo "Error: Specify a path to the submodule directory" 1>&2
    exit 1
fi

if [ ! "$(pwd)" = "$(git rev-parse --show-toplevel)" ]; then
    echo 'Error: Run again after: cd "$(git rev-parse --show-toplevel)"' 1>&2
    exit 1
fi

git config --remove-section submodule."$1" || exit 1
git config --file .gitmodules --remove-section submodule."$1" || exit 1
git add .gitmodules || exit 1
git rm --cached "$1" || exit 1
rm -rf "$1" || exit 1
rm -rf .git/modules/$1 || exit 1
