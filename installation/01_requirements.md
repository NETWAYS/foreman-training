!SLIDE smbullets small
# Requirements - Operating System

* Red Hat Enterprise Linux 8
 * No EPEL repository
 * Module Streams
* CentOS Stream, AlmaLinux, Rocky Linux, Oracle Linux 8
 * No EPEL repository
 * Module Streams
* Debian 11 (Bullseye)
* Ubuntu 20.04 (Focal)
* All need the Puppetlabs Repository

~~~SECTION:handouts~~~

****

~~~PAGEBREAK~~~

On the mentioned operating systems packages are provided by the project, a installation from source
is not recommended. On all platforms all updates should be applied before installation. Using the
Puppetlabs Repository providing an up-to-date version of Puppet is required which of the supported
versions to use is based on user requirements.

Some plugins especially Katello will limit the available plattform.

~~~ENDSECTION~~~

!SLIDE smbullets small
# Requirements - Puppet & Facter

* Only All-in-one packaging model from Puppet is supported for Puppet 7
 * Puppet 6 is technically still supported, but EOL
 * Older Puppet versions are not supported
 * Puppet Enterprise is not supported
* Puppetserver gets telemetry disabled by default
* Structured Facts are used by default

~~~SECTION:handouts~~~

****

Puppet 7 is supported with current versions for All-in-one packaging standard by Puppet.
Support for Puppet 6 was not dropped yet, but this version has reached end of life, older versions are no longer supported.
Puppet Enterprise is not supported, but can work with manual tweaking of the setup.

~~~PAGEBREAK~~~

Puppetserver gets installed as central component and since the Foreman project wants to respect user’s privacy,
it disables the telemetry introduced by Puppetserver by default. You can opt-in if you want.

Structured facts are used by default, so no need for legacy facts anymore.

~~~ENDSECTION~~~

!SLIDE small
# Requirements - Communication
Port matrix (depending on installation)

Port        | Protocol  | Required For
------------|-----------|------------------------------------------------------------------
53          | TCP & UDP | DNS Server
67, 68      | UDP       | DHCP Server
69          | UDP       | TFTP Server
80, 443     | TCP       | HTTP & HTTPS access to Foreman web UI - using Apache + Passenger
3000        | TCP       | HTTP access to Foreman web UI - using standalone WEBrick service
5910 - 5930 | TCP       | Server VNC Consoles
5432        | TCP       | Separate PostgreSQL database
8140        | TCP       | Puppet Master
8443        | TCP       | Smart Proxy, open only to Foreman

~~~SECTION:handouts~~~

****

Depending on your installation the ports above or some additional ones are required to be accessable on the Foreman server,
by Foreman or the managed systems.

~~~ENDSECTION~~~
