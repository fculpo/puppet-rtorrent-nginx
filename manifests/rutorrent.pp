#
# ==== Class: rtorrent::rutorrent
#
# Downloads rtorrent 
#
# ==== Parameters:
#
# [*rutorrent_fulldir*]
#    The full directory path that rutorrent will be installed, see init::rutorrent_dir
#
class rtorrent::rutorrent(
	$rutorrent_fulldir
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
		command => "/home/rtorrent/rutorrent-build.sh $rutorrent_fulldir",
		creates => $rutorrent_fulldir,
		timeout => 0,
		require => [File['/home/rtorrent/rtorrent-build.sh'], Package['subversion']]
	}
	file { "$rutorrent_fulldir":
		ensure => directory,
		recurse => true,
		owner => "www-data",
		group => "www-data",
		mode => 0644,
		require => Exec['build-rutorrent'],
   	}
}
