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
			'g++',
			'automake',
			'make',
			# libraries for libtorrent
			'libxmlrpc-c++8-dev', 
			'libtool',
			'libcppunit-dev',
			'zlib1g-dev',
			'libssl-dev',
			#'libsigc++-2.0-dev', #doesn't stop ./configure, guess it's not needed?
			# libraries for rtorrent
			'libncurses5-dev',
			'libcurl4-openssl-dev'
			]
	package { $rtorrentpackages:
		ensure => installed
	}
	file { '/home/rtorrent/rtorrent-build.sh':
		ensure  => present,
		owner   => 'rtorrent',
		group   => 'rtorrent',
		mode    => '0555',
		source  => 'puppet:///modules/rtorrent/rtorrent-build.sh',
		require => User['rtorrent']
	}
	exec { "build-rtorrent":
		command => "/home/rtorrent/rtorrent-build.sh",
		creates => "/usr/local/bin/rtorrent",
		timeout => 0,
		require => [File['/home/rtorrent/rtorrent-build.sh'], Package[$rtorrentpackages]]
	} 
}