# == Class: eximsmarthost
#
# A module to configuring exim as a simple MTA to deliver all mail via a smarthost.
# USeful for any system that needs to deliver mail.
#
# === Parameters
#
# [smarthost]
#   The host to send all mail via. Can be any valid format that Exim accepts.
#   e.g. smtp.example.com/MX
#
# [domain]
#   The domain to add to the shortname.
#   e.g example.com
#
# [local_interfaces]
#   The interface to listen on.
#   e.g. 127.0.0.1
#
# [root]
#   The address to send mails for to root to.
#   e.g. root-mailbox@example.com
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
  $smarthost = $exim::params::smarthost,
  $domain = $exim::params::domain,
  $local_interfaces = $exim::params::local_interfaces,
  $root = $exim::params::root,
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

