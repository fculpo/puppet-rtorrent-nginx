#
# ==== Class: rtorrent::rutorrent
#
# Downloads rtorrent 
#
# ==== Parameters:
#
# [*rutorrent_wwwdir*]
#    The full directory path that rutorrent will be installed, see init::rutorrent_dir
#
class rtorrent::rutorrent(
	$rutorrent_installdir,
	$rutorrent_fullwwwdir,
) {
	# rutorrent uses svn, make sure its installed
	package { 'subversion':
		ensure => installed
	}
	
	# Execute rutorrent build
	file { '/home/rtorrent/rutorrent-build.sh':
		ensure  => present,
		owner   => 'rtorrent',
		group   => 'rtorrent',
		mode    => '0555',
		source  => 'puppet:///modules/rtorrent/rutorrent-build.sh',
		require => User['rtorrent']
	}
	exec { "build-rutorrent":
		command => "/home/rtorrent/rutorrent-build.sh $rutorrent_installdir $rutorrent_fullwwwdir",
		creates => $rutorrent_fullwwwdir,
		timeout => 0,
		require => [File['/home/rtorrent/rtorrent-build.sh'], Package['subversion']]
	}
	file { "$rutorrent_fullwwwdir":
		ensure => link,
		target => "$rutorrent_installdir/rutorrent",
		owner => "www-data",
		group => "www-data",
		mode => 0644,
		require => Exec['build-rutorrent'],
   	}
	file { "$rutorrent_fullwwwdir/plugins/rpc":
		ensure => link,
		target => "$rutorrent_installdir/plugins/rpc",
		require => File["$rutorrent_fullwwwdir"],
   	}
}
