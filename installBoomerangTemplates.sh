#!/bin/sh
#
#
REPONAME="BoomerangTemplates"
BOOMERANGDIRNAME="Boomerang"
TEMPLATEDIRECTORY="$HOME/Library/Developer/Xcode/Templates/File Templates/"

function installTemplates {
	rm -rf "$TEMPLATEDIRECTORY$BOOMERANGDIRNAME"

	mkdir -p $TEMPLATEDIRECTORY
	cd $REPONAME
	cp -r "$BOOMERANGDIRNAME" "$TEMPLATEDIRECTORY"
	cd ..
	rm -rf $REPONAME
	echo "Boomerang templates installed"
}

cd /tmp/
rm -rf BoomerangTemplates
git clone https://github.com/synesthesia-it/BoomerangTemplates.git && installTemplates
