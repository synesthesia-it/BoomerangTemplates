#!/bin/sh
#
#
REPONAME="BoomerangTemplates"
BOOMERANGDIRNAME="Boomerang"
TEMPLATEDIRECTORY="$HOME/Library/Developer/Xcode/Templates/File Templates/"
TEMPLATEDIRCREATE = "$HOME/Library/Developer/Xcode/Templates/Filei\ Templates/"

function installTemplates {
	rm -rf "$TEMPLATEDIRECTORY$BOOMERANGDIRNAME"

	mkdir -p "$TEMPLATEDIRCREATE"
	cd $REPONAME
	cp -r "$BOOMERANGDIRNAME" "$TEMPLATEDIRECTORY"
	cd ..
	rm -rf $REPONAME
	echo "Boomerang templates installed"
}

cd /tmp/
rm -rf BoomerangTemplates
git clone https://github.com/synesthesia-it/BoomerangTemplates.git && installTemplates
