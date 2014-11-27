# == Class: eximsmarthost
#
# A module to configuring exim as a simple MTA to deliver all mail via a smarthost.
# USeful for any system that needs to deliver mail.
#
# === Examples
#
#  class { 'eximsmarthost':
#    domain => 'example.com',
#    root => 'root@example.com',
#    smarthost => 'smtp.example.com/mx',
#  }
#
# === Authors
#
# Dan Foster <dan@zem.org.uk>
#
# === Copyright
#
# Copyright 2014 Dan Foster, unless otherwise noted.
#
class eximsmarthost (
  $smarthost = $eximsmarthost::params::smarthost,
  $domain = $eximsmarthost::params::domain,
  $local_interfaces = $eximsmarthost::params::local_interfaces,
  $root = $eximsmarthost::params::root,
) inherits ::eximsmarthost::params {

  package { 'postfix':
    ensure => absent
  }

  package { 'exim':
    ensure => present
  }

  service { 'exim':
    ensure => running
  }

  file { '/etc/exim/exim.conf':
    ensure  => 'present',
    content => template('eximsmarthost/exim.conf.erb'),
    notify  => Service[exim],
    require => Package['exim'],
  }


  file { '/etc/aliases':
    content => template('eximsmarthost/aliases.erb')
  }
}

