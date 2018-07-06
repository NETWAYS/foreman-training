!SLIDE smbullets small
# Requirements - Operating System

* Red Hat Enterprise Linux 7
 * EPEL repository
 * Optional and RHSCL Channel
 * optionally: Puppetlabs Repository
* CentOS, Scientific Linux, Oracle Linux 7
 * EPEL repository
 * SCLorg SIG repository
 * optionally: Puppetlabs Repository
* Debian 8 & 9
 * optionally: Puppetlabs Repository
* Ubuntu 16.04
 * optionally: Puppetlabs Repository

~~~SECTION:handouts~~~

****

~~~PAGEBREAK~~~

On the mentioned operating systems packages are provided by the project, a installation from source
is not recommended. On all platforms all updates should be applied before installation. Using the
Puppetlabs Repository providing an up-to-date version of Puppet is preferred which of the supported
versions touse is based on user requirements.

~~~ENDSECTION~~~

!SLIDE smbullets small
# Requirements - Puppet & Facter

* All-in-one and FHS packaging model are both supported for Puppet 4 and 5
 * Puppet 3 is no longer supported with Foreman 1.17 and higher
 * Puppet Enterprise is not supported
* Puppet Master and Puppet Server are both supported
* Structured Facts are supported with Foreman >= 1.12

~~~SECTION:handouts~~~

****

Puppet 4.x and 5.x is supported with current versions for All-in-one and Filesystem-Hierarchy-Standard packaging standard.
Puppet 3.x support was dropped with Foreman 1.17.
Puppet Enterprise is not supported, but can work with manual tweaking of the setup.

Both versions of the central server in a Puppet environment are supported. If the All-in-on package of Puppet 4 or 5
is found it will use the Puppet Server, in all other cases it will setup Puppet Master using Apache and Passenger.

Support for structured facts provided by Facter 2.x was added with Foreman 1.12.

~~~ENDSECTION~~~

!SLIDE smbullets small
# Requirements - Communication

* Port matrix (depending on installation)

Port        | Protocol  | Required For
------------|-----------|------------------------------------------------------------------
53          | TCP & UDP | DNS Server
67, 68      | UDP       | DHCP Server
69          | UDP       | TFTP Server
80, 443     | TCP       | HTTP & HTTPS access to Foreman web UI - using Apache + Passenger
3000        | TCP       | HTTP access to Foreman web UI - using standalone WEBrick service
3306        | TCP       | Separate MySQL database
5910 - 5930 | TCP       | Server VNC Consoles
5432        | TCP       | Separate PostgreSQL database
8140        | TCP       | Puppet Master
8443        | TCP       | Smart Proxy, open only to Foreman

~~~SECTION:handouts~~~

****

~~~PAGEBREAK~~~

Depending on your installation the ports above are required to be accessable on the Foreman server,
by Foreman and the managed systems.

~~~ENDSECTION~~~
