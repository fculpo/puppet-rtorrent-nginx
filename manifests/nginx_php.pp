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
	$www_dir,
	$vhost
) {	
	# install php5-fpm and configure nginx to use it
	include php
	class { ['php::fpm', 'php::cli']: }
	nginx::resource::location { "quacknas-remote_php":
		ensure          => present,
		vhost           => $vhost,
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