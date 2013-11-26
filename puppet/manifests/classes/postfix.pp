
class postfix {
  package { 'postfix':
    ensure => installed,
  }

  package { 'mailutils':
    ensure => installed,
  }

  service { 'postfix':
    ensure    => running,
    enable    => true,
    hasstatus => true,
    restart   => '/etc/init.d/postfix reload',
    require   => Package['postfix'],
  }
}