!SLIDE smbullets small
# Requirements - Operating System

* Red Hat Enterprise Linux 7 & 8
 * EPEL repository
 * Optional and RHSCL Channel (for 7)
 * Module Streams (for 8)
* CentOS, Scientific Linux, Oracle Linux 7
 * EPEL repository
 * SCLorg SIG repository (for 7)
 * Module Streams (for 8)
* Debian 10 (Buster)
* Ubuntu 18.04 (Bionic)
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

* All-in-one and FHS packaging model are both supported for Puppet 5 and 6
 * Puppet 3 is no longer supported with Foreman 1.17 and higher
 * Puppet 4 is no longer supported with Foreman 1.24 and higher
 * Puppet Enterprise is not supported
* Puppet Master and Puppet Server are both supported
* Structured Facts are supported with Foreman >= 1.12

~~~SECTION:handouts~~~

****

Puppet 5.x and 6.x is supported with current versions for All-in-one and Filesystem-Hierarchy-Standard packaging standard.
Puppet 3.x support was dropped with Foreman 1.17, Puppet 4.x was dropped with 1.24.
Puppet Enterprise is not supported, but can work with manual tweaking of the setup.

~~~PAGEBREAK~~~

Both versions of the central server in a Puppet environment are supported. If the All-in-one package of Puppet
is found it will use the Puppet Server, in all other cases it will setup Puppet Master using Apache and Passenger.

Support for structured facts provided by Facter 2.x was added with Foreman 1.12.

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
