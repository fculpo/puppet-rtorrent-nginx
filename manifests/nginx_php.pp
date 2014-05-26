class rtorrent::nginx_php {
	# install and configure nginx with basic webserver
	class { 'nginx': 
		package_source => 'nginx',
		confd_purge => true
	}
	nginx::resource::vhost { "quacknas-remote":
		ensure                => present,
		listen_port           => 80,
		#www_root             => "/var/www", #broken, incorectly puts root in location /{} block
		vhost_cfg_prepend	  => {root =>"/var/www"},
		proxy                 => undef,
		location_cfg_append   => undef,
		index_files           => [ 'index.php', 'index.html' ],
		use_default_location   => false
	}
	
	# install php5
	include php
	class { ['php::fpm', 'php::cli']:
	}
	nginx::resource::location { "quacknas-remote_php":
		ensure          => present,
		vhost           => "quacknas-remote",
		location        => '~ \.php$',
		index_files     => ['index.php', 'index.html', 'index.htm'],
		proxy           => undef,
		fastcgi         => 'unix:/var/run/php5-fpm.sock',
		fastcgi_script  => '$document_root$fastcgi_script_name',  
		location_cfg_append => {
			fastcgi_connect_timeout => '3m',
			fastcgi_read_timeout    => '3m',
			fastcgi_send_timeout    => '3m'
		}
    }
}