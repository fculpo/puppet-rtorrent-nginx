class rtorrent::rtorrent_build {
	# install rtorrent
	$rtorrentpackages = [
			# Build deps
			'git',
			'subversion',
			'g++',
			'automake',
			'make',
			# libraries for libtorrent
			'libxmlrpc-c++8-dev', 
			'libtool',
			'libcppunit-dev',
			'zlib1g-dev',
			'libssl-dev',
			#'libsigc++-2.0-dev', #doesn't stop ./configure, guess it's nt needed?
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