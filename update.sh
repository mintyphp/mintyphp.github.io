#!/bin/bash
VERSION=$(curl -s https://github.com/mintyphp/mintyphp/releases | grep -iA 20 'latest' | grep -o 'v[0-9]\+\.[0-9]\+\.[0-9]\+')
VERSION="${VERSION//v}" # strip v character
OLDVER=$(cat version.txt)
echo $VERSION > version.txt
sed -i "s/$OLDVER/$VERSION/g" 01-installation.md
git commit -am "update latest" && git push
