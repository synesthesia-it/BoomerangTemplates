#!/bin/sh
#
#
REPONAME="BoomerangTemplates"
BOOMERANGDIRNAME="Boomerang"
TEMPLATEDIRECTORY="$HOME/Library/Developer/Xcode/Templates/Project Templates/"

function installTemplates {
	rm -rf "$TEMPLATEDIRECTORY$BOOMERANGDIRNAME"

	cd $REPONAME
	cp -r "ProjectTemplate/*" "$TEMPLATEDIRECTORY"
	cd ..
	rm -rf $REPONAME
	echo "Boomerang templates installed"
}

mkdir -p $HOME/Library/Developer/Xcode/Templates/Project\ Templates
cd /tmp/
rm -rf BoomerangTemplates
git clone https://github.com/synesthesia-it/BoomerangTemplates.git && installTemplates
