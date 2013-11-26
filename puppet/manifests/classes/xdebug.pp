
class xdebug {
  
  package { [ "php5-xdebug" ]:
    ensure => installed,
    require => [
      Exec['apt-update-php'],
    ]
  }
}