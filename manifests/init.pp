class rtorrent(
	$rtorrent_download_rate = 1500,
	$rtorrent_upload_rate = 20,
	$rtorrent_max_uploads = 8,
	$rtorrent_session = '/quackdrive/torrents/rtsession',
	$rtorrent_directory = '/quackdrive/torrents'
) {
	
	include rtorrent::config
	include rtorrent::service
	include rtorrent::install
}
