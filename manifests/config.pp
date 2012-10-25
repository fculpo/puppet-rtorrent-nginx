class rtorrent::config {

  file { "/etc/init.d/rtorrent":
    ensure => present,
    owner => rtorrent,
    group => rtorrent,
    mode => 0555,
    source => "puppet:///rtorrent/rtorrent",
    require => User["rtorrent"]
  }

}
