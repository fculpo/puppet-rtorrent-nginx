#!/bin/bash

#Stop on first error
set -e

BUILD_FOLDER="/tmp/rutorrent-build/"
DEST_FOLDER=$1

#Make a new rtorrent-build directory since we don't know the state of the old one
rm -rf $BUILD_FOLDER
mkdir $BUILD_FOLDER
cd $BUILD_FOLDER

#Download rutorrent
svn co http://rutorrent.googlecode.com/svn/trunk/ rutorrent
mv rutorrent $DEST_FOLDER

#Set the scgi params in rutorrent config to local socket
cd $DEST_FOLDER/conf
cp config.php config.php.bak
sed -i "s/^[[:space:]]*\$scgi_port \= .*/\$scgi_port \= 0;/i" config.php
sed -i "s/^[[:space:]]*\$scgi_host \= .*/\$scgi_host \= 'unix\:\/\/\/home\/rutorrent\/\.rutorrent.socket\'\;/i" config.php

#Cleanup
cd /
rm -rf $BUILD_FOLDER