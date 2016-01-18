class rtorrent::params {

  $libtorrent_version     = '0.13.6'
  $rtorrent_version       = '0.9.6'
  $rtorrent_download_rate = 1500
  $rtorrent_upload_rate   = 20
  $rtorrent_max_uploads   = 8
  $rtorrent_session       = '/quackdrive/torrents/rtsession'
  $rtorrent_directory     = '/quackdrive/torrents'
  $www_dir                = '/var/www'
  $rutorrent_wwwdir       = 'rutorrent'
  $rtorrent_command       = '/usr/local/bin/rtorrent -D'
  $install_nginx          = false

  case $::osfamily {
    'Debian': {
      $rtorrent_deps = [
      # Build deps
      'git',
      'g++',
      'automake',
      'make',
      'pkg-config', #stops ./configure from finding openssl if missing
      # libraries for libtorrent
      'libxmlrpc-c++8-dev', 
      'libtool',
      'libcppunit-dev',
      'zlib1g-dev',
      'libssl-dev',
      # libraries for rtorrent
      'libncurses5-dev',
      'libcurl4-openssl-dev',
      'unzip'
      ]
    }

    'RedHat': {
      $rtorrent_deps = [
      # Build deps
      'git',
      'gcc-c++',
      'automake',
      'make',
      'pkgconfig',
      # libraries for libtorrent
      'xmlrpc-c-devel',
      'libtool',
      'cppunit-devel',
      'zlib-devel',
      'openssl-devel',
      # libraries for rtorrent
      'ncurses-devel',
      'libcurl-devel',
      'unzip'
      ]
    }
  }
}