!SLIDE smbullets small
# Requirements - Operating System

* Red Hat Enterprise Linux 9
 * No EPEL repository
* CentOS Stream, AlmaLinux, Rocky Linux, Oracle Linux 9
 * No EPEL repository
* Debian 12 (Bookworm)
* Ubuntu 22.04 (Jammy)
* All need the OpenVox Repository

~~~SECTION:handouts~~~

****

On the mentioned operating systems packages are provided by the project, a installation from source
is not recommended. On all platforms all updates should be applied before installation. 
Using the OpenVox Repository providing an up-to-date version of OpenVox is required, as testing with Puppet Core is not possible and Puppet Open Source is no longer updated.
Choosing the supported versions to use is based on user requirements.

Some plugins especially Katello will limit the choices of available plattform.

On Enterprise Linux distributions, EPEL is not only not required, but in fact must be disabled!

~~~ENDSECTION~~~

!SLIDE smbullets small
# Requirements - Puppet & Facter

* Only OpenVox 8 is supported
 * Older Puppet versions are not supported
 * Puppet Enterprise is not supported
* Puppet server has its telemetry disabled by default
* Structured Facts are used by default

~~~SECTION:handouts~~~

****

Only OpenVox 8 is supported.
While Puppet Core should be working it cannot be tested and Puppet Open Source is no longer maintained by Puppet.
Puppet Enterprise is not supported, but can work with manual tweaking of the setup.

OpenVox server / Puppet server is installed as a central component and since the Foreman project wants to respect user’s privacy,
it disables the telemetry introduced by Puppet server by default. You can opt-in if you want.

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
80, 443     | TCP       | HTTP & HTTPS access to Foreman web UI - using Apache + Puma
3000        | TCP       | HTTP access to Foreman web UI - using standalone WEBrick service
5910 - 5930 | TCP       | Server VNC Consoles
5432        | TCP       | Separate PostgreSQL database
8140        | TCP       | OpenVox server / Puppet server
8443        | TCP       | Smart Proxy, open only to Foreman

~~~SECTION:handouts~~~

****

Depending on your installation the ports above or some additional ones are required to be accessible on the Foreman server,
by Foreman or the managed systems.

~~~ENDSECTION~~~
