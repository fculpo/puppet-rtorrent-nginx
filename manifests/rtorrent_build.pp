#
# ==== Class: rtorrent::rtorrent_build
#
# Builds rtorrent from source due to most distros do not compile rtorrent
# with xmlrpc-c. rtorrent is also out of date in some distros.
#
# Process: All required development packages and compilers are installed first.
# The libtorrent repo is cloned from github and compiled. Then the rtorrent repo
# is cloned from github and compiled. See files/rtorrent-build.sh (after this class
# is executed it is in /home/rtorrent/rtorrent-build.sh) for details
#
# ==== Parameters:
#
# There are no parameters for this class
#
class rtorrent::rtorrent_build {

  # install rtorrent packages required for build (as of Ubuntu 14.04)
  $rtorrentpackages = [
      # Build deps
      'git',
      #'g++',
      'gcc-c++',
      'automake',
      'make',
      #'pkg-config', #stops ./configure from finding openssl if missing
      'pkgconfig',
      # libraries for libtorrent
      #'libxmlrpc-c++8-dev', 
      'xmlrpc-c-devel',
      'libtool',
      #'libcppunit-dev',
      'cppunit-devel',
      #'zlib1g-dev',
      'zlib-devel',
      #'libssl-dev',
      'openssl-devel',
      # libraries for rtorrent
      #'libncurses5-dev',
      'ncurses-devel',
      #'libcurl4-openssl-dev',
      'libcurl-devel',
      'unzip'
      ]
  package { $rtorrentpackages:
    ensure => installed
  }
  file { '/tmp/rtorrent-build.sh':
    ensure  => file,
    owner   => 'rtorrent',
    group   => 'rtorrent',
    mode    => '0555',
    content => template('rtorrent/rtorrent-build.sh.erb'),
    require => User['rtorrent']
  }
  exec { "build-rtorrent":
    command => "/tmp/rtorrent-build.sh",
    creates => "/usr/local/bin/rtorrent",
    timeout => 0,
    require => [File['/tmp/rtorrent-build.sh'], Package[$rtorrentpackages]]
  } 
}