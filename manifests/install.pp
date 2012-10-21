class rtorrent::install {

  package { $rtorrent::params::prerequisites:
    ensure => installed
  }

}
