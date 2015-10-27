# == Class: eximsimple
#
# A module to configuring exim as a simple MTA to deliver all mail via a smarthost.
# USeful for any system that needs to deliver mail.
#
# === Examples
#
#  class { 'eximsimple':
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
class eximsimple (
  $smarthost = $eximsimple::params::smarthost,
  $domain = $eximsimple::params::domain,
  $local_interfaces = $eximsimple::params::local_interfaces,
  $root = $eximsimple::params::root,
  $root_aliases = $eximsimple::params::root_aliases,
  $package_name = $eximsimple::params::package_name,
  $service_name = $eximsimple::params::service_name,
) inherits ::eximsimple::params {

  package { 'postfix':
    ensure => absent
  }

  package { $package_name:
    ensure => present
  }

  service { $service_name:
    ensure  => running,
    require => Package[$package_name]
  }


  case $::osfamily {
    'RedHat': {
      file { '/etc/exim/exim.conf':
        ensure  => 'present',
        content => template('eximsimple/exim.conf.erb'),
        notify  => Service[$service_name],
        require => Package[$package_name],
      }
    }
    'Debian': {
      file { '/etc/exim4/update-exim4.conf.conf':
        ensure  => 'present',
        content => template('eximsimple/update-exim4.conf.conf'),
      }

      exec { '/usr/sbin/update-exim4.conf':
        subscribe   => File['/etc/exim4/update-exim4.conf.conf'],
        refreshonly => true,
        require     => Package[$package_name],
      }
    }
    default: {
      fail('Unknown $osfamily. This module only supports RedHat and Debian based systems.')
    }

  }


  file { '/etc/aliases':
    content => template('eximsimple/aliases.erb')
  }
}

