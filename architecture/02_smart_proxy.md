!SLIDE smbullets small
# Smart Proxy

* Autonomous web-based component
 * Restful API to connect to various systems from Foreman
 * Decentralisation of some Foreman features (templates) for isolated networks
* Supported Plattforms: RHEL/Fedora, Debian/Ubuntu, (Linux, Windows)
* Supported Subsystems:
 * DHCP - ISC DHCP, MS DHCP Servers, Libvirt
 * DNS - Bind, PowerDNS, Route53, MS DNS Server, Libvirt
 * BMC - IPMI
 * Puppet & Puppet CA / Salt / Chef
 * Realm - FreeIPA
 * TFTP 

~~~SECTION:notes~~~

* Support for the realm subsystem to join an active directory is in development
* Additional subsystems are added by plugins

~~~ENDSECTION~~~

~~~SECTION:handouts~~~

****

The smart proxy is an autonomous web-based component providing a restful API to connect to varios
systems from higher ochestration tools such as Foreman. 

The Project provides packages for installation on RHEL/Fedora and Debian/Ubuntu. Installing from
source allows to support other Linux distributions and also Windows which is required for some 
implementations of subsystems.

~~~PAGEBREAK~~~

There are different implementations of various subsystems included in the smart proxy by default
and it easily allows to add additional subsystems and implementations as plugins. For configuration
management the solutions differ to much to be covered by one subsystem. For joining a realm support
for active directory is in development but for now only FreeIPA (an Open Source aquivalent to Active
Directory focused on Linux) is supported.

~~~ENDSECTION~~~

!SLIDE smbullets small
# Smart Proxy - DHCP

* Adds and removes host reservations
* Requires subnets to be configured
* Supports: ISC DHCP, MS DHCP, Libvirt

* ISC DHCP:
 * uses OMAPI 

* MS DHCP:
 * uses netsh on a windows server
 * needs administrative privileges

* Libvirt:
 * not for productive use
 * uses virsh to manage dnsmasq for libvirt

~~~SECTION:notes~~~

* Libvirt is recommended for local test environments (desktop running kvm and libvirt)

~~~ENDSECTION~~~

~~~SECTION:handouts~~~

****

The Smart Proxy DHCP is used to add and remove host reservations to preconfigured subnets and allows to
import them to foreman.

~~~PAGEBREAK~~~

On Linux typically a ISC compatible implementation is used to manage DHCP which allows to send commands
via OMAPI. For Microsoft DHCP installation of the Smart Proxy on Windows Server system is required which
needs netsh command installed and the user running the service needs administrative privileges, but the
server does not need to be the DHCP server. For testing enviroments also an implementation for Libvirt
using virsh to manage the dnsmasq underneath is available, a productive use is not recommended.

~~~ENDSECTION~~~

!SLIDE smbullets small
# Smart Proxy - DNS

* Adds and removes dns records of type A and PTR
* Requires zone to be configured as dynamic zones
* Supports: Bind, PowerDNS, Route53, MS DNS, Libvirt

* Bind:
 * uses nsupdate with preshared key or Kerberos principal

* MS DNS:
 * uses nsupdate with Kerberos principal
 * alternativly: uses dnscmd on a windows server

* PowerDNS:
 * directly connects to the database backend

* Route53 (DNS in AWS cloud):
 * requires Amazon Web Service account
 * access and secret key of IAM account with access to Route53

* Libvirt:
 * not for productive use
 * uses virsh to manage dnsmasq for libvirt

~~~SECTION:notes~~~

* Foreman does not support IPv6 at the moment, so no AAAA records
* Also no support for additional records like CNAME 

~~~ENDSECTION~~~

~~~SECTION:handouts~~~

****

The Smart Proxy DNS is used to add and remove dns records of type A and PTR, at the moment there is no
support for IPv6 and additional records. For doing such updates it requires the zone to be a dynamic zone.

Commonly used on Linux is Bind which takes updates via nsupdate with preshared keys or if used in FreeIPA
with Kerberos principal. The same mechanism could be used for sending updates to Microsofts DNS. Another
possibilty is to install the Smart Proxy on a Windows server and give it the privileges to run dnscmd.
Other implementations like PowerDNS and Route53 are also supported. Libvirt is again only supported as a
testing environment.

~~~ENDSECTION~~~


!SLIDE smbullets small
# Smart Proxy - TFTP

* Used to provide boot-images for PXE boot
* Downloads the required files with wget
* Creates and deletes PXE configuration based on MAC address
* Automatically configured during installation

~~~SECTION:handouts~~~

****

The Smart Proxy TFTP provides boot-images for PXE boot, these files are simply downloaded using wget the
first time needed. PXE configuration is created during provisioning based on MAC address. For this subsystem
in the most cases no manual configuration is required because it is completly included in the basic setup.

~~~ENDSECTION~~~


!SLIDE smbullets small
# Smart Proxy - Puppet / Puppet CA

* Puppet:
 * connects to Puppets API
 * allows to import puppet environments and classes
 * optionally triggers immediate Puppet runs
 * accepts facts and reports
 * uses Foreman as ENC

* Puppet CA:
 * requires access to ssl directory, autosign configuration and puppet cert command
 * allows certificate management using the Web GUI
 * creates autosign entry for hosts during provisioning

~~~SECTION:handouts~~~

****

The Smart Proxy Puppet connects to the API of Puppet to query puppet environments and classes for import. It
optionally triggers immediate Puppet runs using the deprecated puppet kick command, mcollective, executing puppet
agent command via ssh on the remote system, salt or any custom script. 

~~~PAGEBREAK~~~

Also it automatically allows a Puppet master known to Foreman as Smart Proxy to upload facts and reports. In addition
the Puppet master can access Foreman as an External Node Classifier to build its catalog.

The Smart Proxy Puppet CA is independent from the one for Puppet. It requires access to Puppet's ssl directory, the 
autosign configuration and puppet cert command via sudo. The Web GUI utilizes the Smart Proxy for certificate management
and creates autosign entry for hosts during provisioning for accessing puppet without manual intervention.

~~~ENDSECTION~~~
