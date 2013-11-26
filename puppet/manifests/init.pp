import "classes/*.pp"
$mysite_domain = "mysite.local"
$mysql_password = "root"

group { "puppet":
  ensure => "present",
}


exec { "apt-update":
    command => "/usr/bin/apt-get update"
}
Exec["apt-update"] -> Package <| |>

File { owner => 0, group => 0, mode => 0644 }

file { '/etc/motd':
  source => "/vagrant/puppet/manifests/files/motd.txt"
}
file { '/home/vagrant/.bash_profile':
  source => "/vagrant/puppet/manifests/files/bash_profile.txt"
}
exec { "hosts-file":
  command => "/bin/echo '127.0.0.1 $mysite_domain' >> /etc/hosts"
}

package { 'vim': ensure => present }
package { 'git-core': ensure => present }
package { 'rubygems': ensure => present }
package { "unzip": ensure => present }
package { "curl": ensure => present }

include apache
include mysql::server
include drupal
include pear
include postfix
include ruby
include xhprof
include xdebug
include composer
include apc

# Install the esports site.
apache::site { $mysite_domain:
  # documentroot => "drupal"
}

file { '/var/www/${mysite_domain}':
  owner => 'vagrant',
  group => 'vagrant',
  mode => 0777,
  recurse => true,
}

# mysql::server::db { "tomstest": user => "tom", password => "tomstest", }
# drupal::site { "mytest.local": password => "crunch", }
