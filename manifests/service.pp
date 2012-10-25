# Manage the rtorrent service
# This will ensure that the rtorrent service is running and is enabled on
# startup.
class rtorrent::service {

  service {'rtorrent':
    ensure      => running,
    hasstatus   => true,
    hasrestart  => true,
    enable      => true,
    require     => Class['rtorrent::config']
  }

}
