
class apc {

  package { [ "php-apc" ]:
    ensure => installed,
    require => [
      Exec['apt-update-php'],
    ]
  }

}