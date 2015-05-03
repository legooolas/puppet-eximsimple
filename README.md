# eximsimple

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with eximsimple](#setup)
    * [What eximsimple affects](#what-eximsimple-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with eximsimple](#beginning-with-eximsimple)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

A module to configuring exim as a simple MTA to deliver all mail via a smarthost.
It should be useful for any satellite system that needs to deliver mail via a central relay.

## Module Description

This module will install Exim from EPEL and remove Postfix if it is installed (as installed by default on RHEL based distros).
It will configure Exim to route all mail via the `smarthost` you define and qualify any unqualified mail names with the defined `domain`.
Any mail destined for `root` will be sent to address defined in `root` parameter.

## Setup

### What eximsimple affects

* Exim package
* Postfix package (removes)
* Exim config (/etc/exim.conf)
* Aliases (/etc/aliases)
* Exim Service


## Usage

The default parameters are unlikely to be suitable for your environment, make sure you overwrite them to suitable values:

```
class { '::eximsimple':
  smarthost => 'smtp.mydomain.com',
  root      => 'myteam@mydomain.com',
  domain    => 'mydomain.com',
} 
```

## Reference

### Classes

#### Public Classes

* eximsimple: Main class, includes all other classes.

#### Private Classes

* eximsimple::private: Handles default parameters.

### Parameters

The following parameters are available in the eximsimple module:

####`domain`

The domain to add to any unqualified mail addresses.

####`root`

The address to send mails for root to.

####`smarthost`

The host to send all mail via. Can be any valid format that Exim accepts. e.g. `smtp.example.com/MX`.

####`local_interfaces`

The interface to listen on. Defaults to `127.0.0.1`.

## Limitations

This module has only been tested on the following Operating Systems:
* RHEL 6
* CentOS 6
* Debian 7 (Wheezy)

## Development

Feel free to submit pull requests.

