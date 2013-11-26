class apache {
  package { "apache2-mpm-prefork":
    ensure => installed,
  } 
  service { "apache2":
    enable => true,
    ensure => running,
    require => Package["apache2-mpm-prefork"],
  }
  file { '/etc/apache2/envvars':
    source => "/vagrant/puppet/manifests/files/apache/envvars",
    require => Package["apache2-mpm-prefork"]
  }
  file { '/var/lock/apache2':
    owner => "vagrant",
    group => "vagrant",
    require => Package["apache2-mpm-prefork"]
  }
  file { "/etc/apache2/logs":
    ensure => directory,
    require => Package["apache2-mpm-prefork"],
  } 
  file { "/etc/apache2/conf.d/name-based-vhosts.conf":
    content => "NameVirtualHost *:8080",
    require => Package["apache2-mpm-prefork"],
    notify => Service["apache2"], 
  }
  exec { "enable-mod-rewrite":
    command => '/usr/sbin/a2enmod rewrite',
    require => Package["apache2-mpm-prefork"],
    notify => Service["apache2"],
  }
  
  define site( $sitedomain = "", $documentroot = "", $aliases = [] ) { 
    include apache if $sitedomain == "" { 
      $vhost_domain = $name
    } 
    else { 
      $vhost_domain = $sitedomain 
    } 
    if $documentroot == "" {
      $vhost_root = "/var/www/${name}/public_html"
    } 
    else { 
      $vhost_root = $documentroot
    } 
    file { "/etc/apache2/sites-available/${vhost_domain}.conf": 
      content => template("apache/vhost.erb"), 
      require => File["/etc/apache2/conf.d/name-based-vhosts.conf"], 
      notify => Exec["enable-${vhost_domain}-vhost"], 
    } 
    exec { "enable-${vhost_domain}-vhost": 
      command => "/usr/sbin/a2ensite ${vhost_domain}.conf",
      require => [ 
        File["/etc/apache2/sites-available/${vhost_domain}.conf"],
        Package["apache2-mpm-prefork"]
      ], 
      refreshonly => true, 
      notify => Service["apache2"], 
    }
  }
  
}

