#
# ==== Class: rtorrent::rutorrent
#
# Downloads rtorrent 
#
# ==== Parameters:
#
# [*rutorrent_dir*]
#    The directory that rutorrent will be installed, see init::rutorrent_dir
#
class rtorrent::rutorrent(
	$rutorrent_dir
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
		command => "/home/rtorrent/rutorrent-build.sh $rutorrent_dir",
		creates => $rutorrent_dir,
		timeout => 0,
		require => [File['/home/rtorrent/rtorrent-build.sh'], Package['subversion']]
	} 
}