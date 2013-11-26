
class xhprof {
  
  package { [ "php5-dev" ]:
    ensure => installed,
    require => [
      Exec['apt-update-php'],
    ]
  }
  
  package { [ "graphviz" ]:
    ensure => installed
  }
  
  file { "/etc/apache2/conf.d/xhprof.conf":
    owner => "root",
    group => "root", 
    source => "/tmp/vagrant-puppet/manifests/files/xhprof/xhprof.conf",
    notify => Service["apache2"],
  }
  
  file {'/etc/php5/apache2/conf.d/xhprof.ini':
    ensure => present,
    owner => root, group => root, mode => 444,
    content => "[xhprof]\nextension=xhprof.so\nxhprof.output_dir=/var/tmp/xhprof\n",
    require => Package["libapache2-mod-php5"]
  }
  
  file { "/var/tmp/xhprof":
    ensure => "directory",
    owner  => "vagrant",
    group  => "vagrant",
  }
  
  exec { "download-unzip":
    cwd => '/usr/src',
    command => "/usr/bin/wget https://github.com/facebook/xhprof/archive/master.zip && /usr/bin/unzip master",
    creates => "/usr/src/xhprof-master",
    require => Package['unzip']
  }
  
  exec { "install-xhprof":
    cwd => '/usr/src/xhprof-master/extension',
    command => "/usr/bin/phpize && ./configure && make && make install",
    require => [ Package['unzip'], Package['php5-dev'], Exec['download-unzip'] ],
    notify => Service["apache2"],
  }
}