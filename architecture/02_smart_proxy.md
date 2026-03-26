!SLIDE smbullets small
# Smart Proxy

* Autonomous web-based component
 * Restful API to connect to various systems from Foreman
 * Decentralization of some Foreman features (templates) for isolated networks
* Supported Platforms: RHEL/CentOS, Debian/Ubuntu, (Linux, Windows)
* Supported Subsystems:
 * DHCP - ISC DHCP, MS DHCP Servers, Libvirt, ...
 * DNS - Bind, PowerDNS, Route53, MS DNS Server, Libvirt, ...
 * BMC - IPMI
 * Puppet & Puppet CA / Salt / Chef / Ansible
 * Realm - FreeIPA, Active Directory
 * TFTP
 * and many more via plugins

~~~SECTION:notes~~~

* Support for the realm subsystem to join an active directory is an additional provider
* Additional subsystems are added by plugins

~~~ENDSECTION~~~

~~~SECTION:handouts~~~

****

The Smart Proxy is an autonomous web-based component providing a restful API to connect to various
systems from higher ochestration tools such as Foreman.

The Project provides packages for installation on RHEL/CentOS and Debian/Ubuntu. Installing from
source enables supporting other Linux distributions and also Windows which is required for some
implementations of subsystems.

~~~PAGEBREAK~~~

There are different implementations of various subsystems included in the Smart Proxy by default
and it easily allows to add additional subsystems and implementations as plugins. For configuration
management the solutions differ too much to be covered by one subsystem. For joining a realm, support
for FreeIPA (an Open Source aquivalent to Active Directory focused on Linux) is part of the Smart Proxy.
Active directory is implemented as an additional provider in a separate package.

~~~ENDSECTION~~~

!SLIDE smbullets small
# Smart Proxy - DHCP

* Adds and removes host reservations
* Requires subnets to be configured
* Supports: ISC DHCP, MS DHCP, Libvirt
* Additional providers: Infoblox, Dnsmasq, Bluecat, Device42
* ISC DHCP:
 * uses OMAPI
* MS DHCP:
 * uses netsh on a windows server
 * needs administrative privileges
* Libvirt:
 * not for productive use
 * uses libvirt API to manage dnsmasq for libvirt

~~~SECTION:notes~~~

* Libvirt is recommended for local test environments (desktop running kvm and libvirt)
* A community plugin for KEA exists, still needs review, packaging and installer support: https://gitlab.surrey.ac.uk/sm0049/smart-proxy-dhcp-kea-api

~~~ENDSECTION~~~

~~~SECTION:handouts~~~

****

The Smart Proxy DHCP is used to add and remove host reservations to preconfigured subnets and allows to
import them to Foreman.

~~~PAGEBREAK~~~

On Linux typically an ISC compatible implementation is used to manage DHCP which allows to send commands
via OMAPI. For Microsoft DHCP, the Smart Proxy must be installed on a Windows Server system which has
the netsh command installed. The user running the service needs administrative privileges, but the
server does not need to be the DHCP server. For testing environments an implementation for Libvirt
using libvirt API to manage the dnsmasq underneath is available as well, a productive use is not recommended.

Additional providers like Infoblox, Dnsmasq, Bluecat, and Device42 are available as plugins.

Support for KEA to replace ISC DHCP is unfortunately not ready yet.

~~~ENDSECTION~~~

!SLIDE small smbullets
# Smart Proxy - DNS

* Adds and removes DNS records of type A, AAAA and PTR
* Requires zone to be configured as dynamic zone
* Supports: Bind, MS DNS, Libvirt
* Additional providers: Infoblox, Route53, PowerDNS, Dnsmasq
* Bind:
 * uses nsupdate with preshared key or Kerberos principal
* MS DNS:
 * uses nsupdate with Kerberos principal
 * alternatively: uses dnscmd on a Windows server
* Libvirt:
 * not for productive use
 * uses libvirt API to manage dnsmasq for libvirt

~~~SECTION:notes~~~

* Foreman does support IPv6 from 1.12 onwards
* No support for additional records like CNAME (Support in Smart Proxy exists)

~~~ENDSECTION~~~

~~~SECTION:handouts~~~

****

The Smart Proxy DNS is used to add and remove DNS records of type A and PTR. Foreman 1.12 introduced
full support for IPv6, but the support for CNAME in the Smart Proxy is not yet utilized in Foreman.
For doing such updates the zone is required to be a dynamic zone.

~~~PAGEBREAK~~~

On Linux, Bind is commonly used which takes updates via nsupdate with preshared keys or if used in FreeIPA
with Kerberos principal. The same mechanism could be used for sending updates to Microsofts DNS. Another
possibilty is to install the Smart Proxy on a Windows server and give it the privileges to run dnscmd.
Other implementations like Infoblox, PowerDNS, Dnsmasq and Route53 are also supported via plugins.
Libvirt is again only supported as a testing environment.

~~~ENDSECTION~~~


!SLIDE smbullets small
# Smart Proxy - TFTP

* Used to provide boot-images for PXE boot
* Downloads the required files with wget
* Creates and deletes PXE configuration based on MAC address
* Automatically configured during installation
* Supports multiple bootloaders in multiple configurations

~~~SECTION:handouts~~~

****

The Smart Proxy TFTP provides boot-images for PXE boot, these files are simply downloaded using wget the
first time they are needed. PXE configuration is created during provisioning based on MAC address.
The support for different bootloaders has grown over the years from classic PXELinux over iPXE to using Grub2
to work on systems with BIOS, UEFI and even UEFI with enabled SecureBoot.

For this subsystem no additional configuration is required in most cases because it is completely included
in the basic setup when activated via one parameter.

~~~ENDSECTION~~~


!SLIDE smbullets small
# Smart Proxy - Puppet / Puppet CA

* Puppet:
 * connects to Puppet's API
 * allows to import Puppet environments and classes
 * accepts facts and reports
 * uses Foreman as ENC

* Puppet CA:
 * requires access to ssl directory, autosign configuration and puppet cert command
 * allows certificate management using the Web GUI
 * creates autosign entry for hosts during provisioning
 * alternatively a tokenbased autosigning can be used

* Puppet integration requires also the Foreman plugin for full feature set

~~~SECTION:notes~~~

~~~ENDSECTION~~~

~~~SECTION:handouts~~~

****

The Smart Proxy Puppet connects to the API of Puppet to query Puppet environments and classes for import.

Also it automatically allows a Puppet master known to Foreman as Smart Proxy to upload facts and reports. In addition
the Puppet master can access Foreman as an External Node Classifier to build its catalog.

~~~PAGEBREAK~~~

The Smart Proxy Puppet CA is independent from the one for Puppet. It requires access to Puppet's ssl directory, the
autosign configuration and puppet cert command via sudo. The Web GUI utilizes the Smart Proxy for certificate management
and creates autosign entries for hosts during provisioning for accessing Puppet without manual intervention.

An alternative implementation using tokenbased autosigning exists, trading off the capability to manually create autosign entries
for increased security and better debugging.

To get the full feature set the Foreman plugin also needs to be installed as Puppet support was moved from core to a plugin with 3.0.

~~~ENDSECTION~~~
