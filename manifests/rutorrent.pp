class rtorrent::rutorrent {
	package { 'subversion':
		ensure => installed
	}
	file { '/home/rtorrent/rutorrent-build.sh':
		ensure  => present,
		owner   => 'rtorrent',
		group   => 'rtorrent',
		mode    => '0555',
		source  => 'puppet:///modules/rtorrent/rutorrent-build.sh',
		require => User['rtorrent']
	}
	exec { "build-rutorrent":
		command => "/home/rtorrent/rutorrent-build.sh",
		creates => "/var/www/rutorrent/",
		timeout => 0,
		require => [File['/home/rtorrent/rtorrent-build.sh'], Package[$rtorrentpackages]]
	} 
}