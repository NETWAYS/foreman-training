!SLIDE smbullets small
# Foreman Installer

* Separate project named kafo
* Recommended way of installation
* Utilizes Puppet modules to install and configure
 * Foreman web UI
 * Smart Proxy
 * Passenger (for Puppet master and Foreman)
 * TFTP
 * DNS
 * DHCP
* Runs parameterized or interactive

~~~SECTION:handouts~~~

****

The Foreman installer is a separate project named kafo (Katello/Foreman Installer) which could also
be used by other projects. It utilizes existing Puppet modules to install and configure all required
components. Module parameter are provided as commandline arguments to the installer or by running 
the installer in interactive mode.

~~~PAGEBREAK~~~

In a default installation this would be:

* Apache HTTP with SSL (using a certificate signed by Puppet CA)
* Foreman running under mod_passenger
* Puppet master running under mod_passenger
* TFTP server (on RHEL and derivates under xinetd)
* Smart Proxy using SSL configured for Puppet and TFTP

Depending on provided parameters other modules are enabled:

* ISC DHCP server
* Bind DNS server

~~~ENDSECTION~~~

