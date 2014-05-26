class rtorrent(
	$rtorrent_download_rate = 1500,
	$rtorrent_upload_rate = 20,
	$rtorrent_max_uploads = 8,
	$rtorrent_session = '/quackdrive/torrents/rtsession',
	$rtorrent_directory = '/quackdrive/torrents',
	$www_dir = '/var/www',
	$rutorrent_dir = 'rutorrent'
) {
	class { 'rtorrent::nginx_php': 
		www_dir => $www_dir,
	}
	class { 'rtorrent::rtorrent_build': }
	class { 'rtorrent::rtorrent_config': }
	class { 'rtorrent::rutorrent': 
		rutorrent_fulldir => "$www_dir/$rutorrent_dir"
	}
}
