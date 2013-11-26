class composer {
  $target_dir      = '/usr/local/bin'
  $composer_file   = 'composer'
  $download_method = 'curl'
  $logoutput       = false
  $php_package     = 'php5-cli'
  $tmp_path        = '/home/vagrant'

  exec { 'download_composer':
    command     => '/usr/bin/curl -s http://getcomposer.org/installer | php',
    cwd         => $tmp_path,
    require     => Package['curl', $php_package],
    creates     => "$tmp_path/composer.phar",
    logoutput   => $logoutput,
  }

  # check if directory exists
  file { $target_dir:
    ensure      => directory,
  }

  # move file to target_dir
  file { "$target_dir/$composer_file":
    ensure      => present,
    source      => "$tmp_path/composer.phar",
    require     => [ Exec['download_composer'], File[$target_dir]],
    group       => 'vagrant',
    mode        => '0755',
    
  }

  # run composer self-update
  exec { 'update_composer':
    command     => "$target_dir/$composer_file self-update",
    require     => File["$target_dir/$composer_file"],
  }
}
