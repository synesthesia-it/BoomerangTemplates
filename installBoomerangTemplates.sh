#!/bin/sh
#
#
REPONAME="BoomerangTemplates"
BOOMERANGDIRNAME="Boomerang"
TEMPLATEDIRECTORY="$HOME/Library/Developer/Xcode/Templates/File Templates/"

rm -rf "$TEMPLATEDIRECTORY$BOOMERANGDIRNAME"

cd $REPONAME
cp -r "$BOOMERANGDIRNAME" "$TEMPLATEDIRECTORY"
cd ..
rm -rf $REPONAME
echo "Boomerang templates installed"
