#
# ==== Class: rtorrent::rtorrent_config
#
# Configures rtorrent enviornment. Creates a dedicated rtorrent user (password rtorrent), 
# rtorrent init.d service, run directory, .rtorrent.rc config, and starts the rtorrent service
#
# ==== Parameters:
#
# TODO
#
class rtorrent::rtorrent_config {
  # Create rtorrent user
  user {'rtorrent':
    ensure     => present,
    comment    => 'rtorrent process user',
    managehome => true,
    password   => '$1$xyz$Tuseeau/G8mLG8Vnqm8Kb/'
  }

  # Create temporary directory for rtorrent work
  file { '/var/run/rtorrent':
    ensure => directory,
    owner  => 'rtorrent',
    group  => 'rtorrent',
    mode   => '0544'
  }
  
  # Create .rtorrent.rc
  file { '/home/rtorrent/.rtorrent.rc':
    ensure  => present,
    owner   => 'rtorrent',
    group   => 'rtorrent',
    mode    => '0440',
    content => template('rtorrent/rtorrent.rc'),
    require => [ User['rtorrent'], File['/var/run/rtorrent'] ],
    notify  => Service['rtorrent']
  }
  
  # Configure and start rtorrent service
  file { '/etc/init.d/rtorrent':
    ensure  => present,
    owner   => 'rtorrent',
    group   => 'rtorrent',
    mode    => '0555',
    source  => 'puppet:///modules/rtorrent/rtorrent',
    require => User['rtorrent']
  }
  service {'rtorrent':
    ensure      => running,
    hasstatus   => true,
    hasrestart  => true,
    enable      => true,
    require     => [Class['rtorrent::rtorrent_build']]
  }
}