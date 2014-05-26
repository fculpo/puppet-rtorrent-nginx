class rtorrent::rtorrent_config {
  user {'rtorrent':
    ensure     => present,
    comment    => 'rtorrent process user',
    managehome => true,
    password   => '$1$xyz$Tuseeau/G8mLG8Vnqm8Kb/'
  }

  file { '/etc/init.d/rtorrent':
    ensure  => present,
    owner   => 'rtorrent',
    group   => 'rtorrent',
    mode    => '0555',
    source  => 'puppet:///modules/rtorrent/rtorrent',
    require => User['rtorrent']
  }

  file { '/var/run/rtorrent':
    ensure => directory,
    owner  => 'rtorrent',
    group  => 'rtorrent',
    mode   => '0544'
  }

  file { '/home/rtorrent/.rtorrent.rc':
    ensure  => present,
    owner   => 'rtorrent',
    group   => 'rtorrent',
    mode    => '0440',
    content => template('rtorrent/rtorrent.rc'),
    require => [ User['rtorrent'], File['/var/run/rtorrent'] ],
    notify  => Class['rtorrent::service']
  }
  
  service {'rtorrent':
    ensure      => running,
    hasstatus   => true,
    hasrestart  => true,
    enable      => true,
    require     => [Class['rtorrent::install'], Class['rtorrent::config']]
  }
}