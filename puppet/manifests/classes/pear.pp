class pear {

  $pear_program = '/usr/bin/pear'

  package { 'php-pear':
    ensure => present,
    tag    => 'pear';
  }
  
  exec { "pear-auto-discover":
    command => "/usr/bin/pear config-set auto_discover 1",
    require => Package["php-pear"]
  }
  
  # create pear temp directory for channel-add
  file { ["/tmp/pear/", "/tmp/pear/temp"]:
    require => Exec["pear-auto-discover"],
    ensure => "directory",
    mode => 777
  }
  
  # discover drush channel
  exec { "pear-channel-discover":
    command => "/usr/bin/pear channel-discover pear.drush.org",
    creates => "/usr/share/php/.registry/.channel.pear.drush.org",
    require => [
      Package['php-pear'],
      File["/tmp/pear/temp"],
      Exec["pear-auto-discover"]
    ]
  }
  
  # install Console_Table
  exec { 'install-console-table':
    command => "/usr/bin/pear install -a -f Console_Table",
    require => Exec["pear-channel-discover"]
  }
  
  # install drush
  exec { 'install-drush':
    command => "/usr/bin/pear install -a -f drush/drush-5.9.0",
    require => [
      Exec["pear-channel-discover"],
      Exec["install-console-table"]
    ]
  }
}