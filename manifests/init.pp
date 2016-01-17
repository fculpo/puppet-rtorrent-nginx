class rtorrent(
  $libtorrent_version     = $rtorrent::params::libtorrent_version,
  $rtorrent_version       = $rtorrent::params::rtorrent_version,
  $rtorrent_download_rate = $rtorrent::params::rtorrent_download_rate,
  $rtorrent_upload_rate   = $rtorrent::params::rtorrent_upload_rate,
  $rtorrent_max_uploads   = $rtorrent::params::rtorrent_max_uploads,
  $rtorrent_session       = $rtorrent::params::rtorrent_session,
  $rtorrent_directory     = $rtorrent::params::rtorrent_directory,
  $www_dir                = $rtorrent::params::www_dir,
  $rutorrent_wwwdir       = $rtorrent::params::rutorrent_wwwdir,
  $rtorrent_command       = $rtorrent::params::rtorrent_command,
  $vhost                  = $rtorrent::params::vhost,
  $install_nginx          = $rtorrent::params::install_nginx,
) inherits rtorrent::params {

  include rtorrent::rtorrent_build
  include rtorrent::rtorrent_config
  include rtorrent::rutorrent

  if ($install_nginx) {
    include rtorrent::nginx_php
  }

}
