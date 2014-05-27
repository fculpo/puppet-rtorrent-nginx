#!/bin/bash

#Stop on first error
set -e

#Allow glob to match dotfiles
shopt -s dotglob

BUILD_FOLDER="/tmp/rutorrent-build/"
INSTALL_FOLDER=$1

#Verify we have arguments
if [[ "$INSTALL_FOLDER" -eq 0 ]] ; then
    echo 'Install folder argument missing'
    exit 1
fi

#Make a new rtorrent-build directory since we don't know the state of the old one
mkdir -p $INSTALL_FOLDER
rm -rf $BUILD_FOLDER
mkdir $BUILD_FOLDER
cd $BUILD_FOLDER

#Download rutorrent
svn co http://rutorrent.googlecode.com/svn/trunk/ .
echo "Finished SVN"
cd /
echo "Now in:"
pwd
echo "Moving $BUILD_FOLDER to $INSTALL_FOLDER"
mv $BUILD_FOLDER/* $INSTALL_FOLDER

#Set the scgi params in rutorrent config to local socket
cd $INSTALL_FOLDER/rutorrent/conf
cp config.php config.php.bak
sed -i "s/^[[:space:]]*\$scgi_port \= .*/\$scgi_port \= 0;/i" config.php
sed -i "s/^[[:space:]]*\$scgi_host \= .*/\$scgi_host \= 'unix\:\/\/\/home\/rutorrent\/\.rutorrent.socket\'\;/i" config.php

#Cleanup
cd /
rm -rf $BUILD_FOLDER