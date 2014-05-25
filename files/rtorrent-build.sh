#!/bin/bash

#Stop on first error
set -e

BUILD_FOLDER="/tmp/rtorrent-build/"

#Make a new rtorrent-build directory since we don't know the state of the old one
rm -rf $BUILD_FOLDER
mkdir $BUILD_FOLDER
cd $BUILD_FOLDER

#Build libtorrent
git clone https://github.com/rakshasa/libtorrent.git
cd libtorrent
./autogen.sh
./configure
make
make install
cd $BUILD_FOLDER

#Build rtorrent
git clone https://github.com/rakshasa/rtorrent
cd rtorrent
./autogen.sh
./configure --with-xmlrpc-c=/usr/bin/xmlrpc-c-config
make
make install
cd $BUILD_FOLDER

#Download rutorrent
svn co http://rutorrent.googlecode.com/svn/trunk/ rutorrent
mv rutorrent /var/www/

#Cleanup
cd /
rm -rf $BUILD_FOLDER
