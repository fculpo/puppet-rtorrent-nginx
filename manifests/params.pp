class rtorrent::params {

  $libtorrent_version     = '0.13.6'
  $rtorrent_version       = '0.9.6'
  $rtorrent_download_rate = 1500
  $rtorrent_upload_rate   = 20
  $rtorrent_max_uploads   = 8
  $rtorrent_session       = '/quackdrive/torrents/rtsession'
  $rtorrent_directory     = '/quackdrive/torrents'
  $www_dir                = '/var/www'
  $rutorrent_wwwdir       = 'rutorrent'
  $rtorrent_command       = '/usr/local/bin/rtorrent -D'
  $install_nginx          = false

}