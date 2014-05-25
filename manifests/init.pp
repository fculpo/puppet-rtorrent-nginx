class rtorrent(
	$rtorrent_download_rate = 1500,
	$rtorrent_upload_rate = 20,
	$rtorrent_max_uploads = 8,
	$rtorrent_session = '/media/rtorrent/session',
	$rtorrent_directory = '/media/rtorrent/download'
) {
  include rtorrent::config, rtorrent::service, rtorrent::install
}
