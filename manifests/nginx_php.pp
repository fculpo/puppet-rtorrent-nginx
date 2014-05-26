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
class rtorrent::nginx_php(
	$www_dir
) {
	# install and configure nginx with basic vhost
	class { 'nginx': 
		package_source => 'nginx',
		confd_purge => true
	}
	nginx::resource::vhost { "quacknas-remote":
		ensure                => present,
		listen_port           => 80,
		#www_root             => $www_dir, #broken, incorectly puts root in location /{} block
		vhost_cfg_prepend	  => {root =>$www_dir},
		proxy                 => undef,
		location_cfg_append   => undef,
		index_files           => ['index.php', 'index.html', 'index.htm'],
		use_default_location   => false
	}
	file { "$www_dir":
		ensure => directory,
		owner   => 'www-data',
		group   => 'www-data',
	}
	
	# install php5-fpm and configure nginx to use it
	include php
	class { ['php::fpm', 'php::cli']: }
	nginx::resource::location { "quacknas-remote_php":
		ensure          => present,
		vhost           => "quacknas-remote",
		location        => '~ \.php$',
		proxy           => undef,
		fastcgi         => 'unix:/var/run/php5-fpm.sock',
		fastcgi_script  => '$document_root$fastcgi_script_name',  #fix fastcgi 404 errors
		location_cfg_append => {
			fastcgi_connect_timeout => '3m',
			fastcgi_read_timeout    => '3m',
			fastcgi_send_timeout    => '3m'
		}
    }
}