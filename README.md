puppet-rtorrent
===============

A puppet module to install libtorrent and rtorrent from source, with the xmlrpc-c extension, as well as the rutorrent frontend.

## Steps
1. Create rtorrent user
2. Install prereqs: git-core, libsigc++, libcurl3, build-essential, automake, libtool, libssl-dev, libncurses5-dev, libcurl4-openssl-dev, libxmlrpc-c++4-dev, apache2, libapache2-mod-scgi, php5, php5-cli
3. Clone rtorrent
4. Clone libtorrent
5. Clone rutorrent
6. configure / make / install libtorrent
 * run aclocal
 * configure
 * make
 * install
7. configure / make / install rtorrent
 * aclocal
 * configure --with-xmlrpc-c
 * make
 * install
8. untar rutorrent to /var/www/rutorrent
9. change permissions to www-data on !$
10. a2enmod scgi
11.   SCGIMount /RPC2 127.0.0.1:5000
      servername  <% fqdn %>
      serveralias <% hostname %>
11. restart apache
