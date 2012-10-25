class rtorrent::service {

  service {"rtorrent":
    hasstatus => true,
    hasrestart => true,
    enable => true,
    require => Class["rtorrent::config"]
  }

}
