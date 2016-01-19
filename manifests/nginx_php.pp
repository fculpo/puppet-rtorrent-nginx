#
# ==== Class: rtorrent::nginx_php
#
# Downloads nginx and php5-fpm from repository and does nessesary configuration
#
# ==== Parameters:
#
# [*www_dir*]
#    The web root directory, see init::www_dir
#
class rtorrent::nginx_php { 

  $www_dir          = $rtorrent::www_dir
  $vhost            = $rtorrent::vhost
  $rutorrent_wwwdir = $rtorrent::rutorrent_wwwdir

  class { 'nginx': 
    package_source => 'nginx',
    confd_purge => true
  }

  nginx::resource::vhost { $vhost:
    listen_port           => 80,
    www_root              => "$www_dir/$rutorrent_wwwdir", #broken, incorectly puts root in location /{} block
    #vhost_cfg_prepend     => {root =>"/var/www"},
    index_files           => ['index.php', 'index.html', 'index.htm'],
    use_default_location  => false
  }

  # install php5-fpm and configure nginx to use it
  include ::php

  nginx::resource::location { "$vhost-php":
    vhost           => $vhost,
    location        => '~ \.php$',
    fastcgi         => 'unix:/var/run/php5-fpm.sock',
    #fastcgi_script  => '$document_root$fastcgi_script_name',  #fix fastcgi 404 errors
    location_cfg_append => {
      fastcgi_connect_timeout => '3m',
      fastcgi_read_timeout    => '3m',
      fastcgi_send_timeout    => '3m'
    }
  }

}