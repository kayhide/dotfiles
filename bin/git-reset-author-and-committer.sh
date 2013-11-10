#!/bin/bash

git filter-branch --commit-filter '
    GIT_AUTHOR_NAME="$(git config user.name)"
    GIT_AUTHOR_EMAIL="$(git config user.email)"
    GIT_COMMITTER_NAME="$(git config user.name)"
    GIT_COMMITTER_EMAIL="$(git config user.email)"
    git commit-tree "$@"
' HEAD

DIR=`echo $0 | sed -e "s#\(.*\)/.*#\1#"`
ruby $DIR/git-move-tags.rb
