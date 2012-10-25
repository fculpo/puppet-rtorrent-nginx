# Manage the configuration required for rtorrent
# This will ensure that the necessary files are in place to allow rtorrent to
# run
# The rtorrent user password defaults to 'rtorrent'
class rtorrent::config {

  @user {'rtorrent':
    ensure     => present,
    comment    => 'rtorrent process user',
    managehome => true,
    password   => '$6$4j7HN4x1$oa13Le9EZErSukSxqhIU1Pnu6fOI0k7FbjW0NaCvRnLU7H9K1RrkoNfcmwQtS973FSIrfLFIjMbpp7VvB00ux.'
  }

  file { '/etc/init.d/rtorrent':
    ensure  => present,
    owner   => 'rtorrent',
    group   => 'rtorrent',
    mode    => 0555,
    source  => 'puppet:///rtorrent/rtorrent',
    require => User['rtorrent']
  }

  file { '/home/rtorrent/.rtorrent.rc':
    ensure  => present,
    owner   => 'rtorrent',
    group   => 'rtorrent',
    mode    => 0440,
    content => template("rtorrent/rtorrent.rc"),
    require => User['rtorrent'],
    notify  => Class['rtorrent::service']
  }

}
