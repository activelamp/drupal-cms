
class ruby {

  package { 'ruby1.9.3':
    ensure   => 'installed',
  }

  file { '/etc/alternatives/ruby':
    ensure => 'link',
    target => '/usr/bin/ruby1.9.3',
    require => Package["ruby1.9.3"],
  }

#  file { '/var/lib/gems':
#    ensure => 'directory',
#    owner => 'root',
#    group => 'vagrant',
#    mode => 775,
#    recurse => true,
#  }

  package { 'bundler':
    ensure   => 'installed',
    provider => 'gem',
    require => File["/etc/alternatives/gem"],
  }

  file { '/etc/alternatives/gem':
    ensure => 'link',
    target => '/usr/bin/gem1.9.3',
  }

}
