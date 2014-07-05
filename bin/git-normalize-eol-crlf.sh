#!/bin/bash

git config core.eol crlf
echo '* text=auto' > .gitattributes
git add .gitattributes
git commit -m 'added .gitattributes.'

git rm --cached -r .
git reset --hard
git add .
git commit -m 'normalized line endings.'



