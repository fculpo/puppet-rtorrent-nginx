class rtorrent::params {

  $rutorrent_src = 'http://rutorrent.googlecode.com/files/rutorrent-3.4.tar.gz'

  $rtorrent_download_rate = 1500
  $rtorrent_upload_rate = 20
  $rtorrent_max_uploads = 8
  $rtorrent_session = '/media/rtorrent/session'
  $rtorrent_directory = '/media/rtorrent/download'

  $prerequisites = [ 'git-core', 'libsigc++', 'libcurl3', 'build-essential', 'automake', 'libtool', 'libssl-dev', 'libncurses5-dev', 'libcurl4-openssl-dev', 'libxmlrpc-c++4-dev', 'apache2', 'libapache2-mod-scgi', 'php5', 'php5-cli' ]

}
