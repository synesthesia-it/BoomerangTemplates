#!/bin/sh
#
#
REPONAME="BoomerangTemplates"
BOOMERANGDIRNAME="Boomerang"
TEMPLATEDIRECTORY="$HOME/Library/Developer/Xcode/Templates/File Templates/"

function install {
	rm -rf "$TEMPLATEDIRECTORY$BOOMERANGDIRNAME"

	cd $REPONAME
	cp -r "$BOOMERANGDIRNAME" "$TEMPLATEDIRECTORY"
	cd ..
	rm -rf $REPONAME
	echo "Boomerang templates installed"
}

git clone https://github.com/synesthesia-it/BoomerangTemplates.git && install
