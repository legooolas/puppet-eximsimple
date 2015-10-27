# == Class: eximsimple::params
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
# [root_aliases]
#   Additional usernames to make as root aliases
#   e.g. [ 'someuser', 'otheruser' ]
#

class eximsimple::params {
    $smarthost = 'smtp.example.com/mx'
    $domain = 'example.com'
    $local_interfaces = '127.0.0.1'
    $root = 'root@example.com'
    $root_aliases = []

    case $::osfamily {
      'RedHat': {
        $package_name = 'exim'
        $service_name = 'exim'
      }
      'Debian': {
        $package_name = 'exim4-daemon-light'
        $service_name = 'exim4'
      }
      default: {
        fail('Unknown $osfamily. This module only supports RedHat and Debian based systems.')
      }
    }
}
