!SLIDE smbullets small
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Prepare Installation

* Objective:
 * Prepare the installation of Foreman
* Steps:
 * Make Puppet vendor repository for Puppet 5 available
 * Make EPEL repository available
 * Make Foreman repository available
 * Install foreman-installer


!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Prepare Installation

## Objective:

****

* In this lab you prepare the installation of Foreman.

## Steps:

****

* Make Puppet vendor repository available

Install the release package provided by the Puppet vendor repository to make it available for package
installation of open source version of Puppet. We will use Puppet 5.

URL: http://yum.puppet.com/puppet5

* Make EPEL repository available

Install the release package provided by the EPEL repository to make it available for package
installation required as dependency.

URL: http://fedoraproject.org/wiki/EPEL

Command: yum install epel-release

* Make Foreman repository available

Install the release package provided by the Foreman repository to make it available for package
installation of Foreman and its components.

URL: http://yum.theforeman.org

* Install foreman-installer

Install the package "foreman-installer" from the now available repositories.

#### Notes:

The host firewall allows traffic between virtual machines in the same network and forwards traffic
from the virtual machine network to the host so no configuration is required.

#### Expected result:

The Foreman installer is installed and "foreman-installer --help" could be run from command line.


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Prepare Installation

****

## Prepare the installation of Foreman

****

### Make Puppet vendor repository available

Install the release package provided by the Puppet vendor repository to make it available for package
installation of open source version of Puppet.

    # yum install https://yum.puppet.com/puppet5/puppet5-release-el-7.noarch.rpm -y

### Make EPEL repository available

Install the release package provided by the CentOS to make it available for package
installation required as dependency.

    # yum install epel-release -y

### Make Foreman repository available

Install the release package provided by the Foreman repository to make it available for package
installation of Foreman and its components.

    # yum install http://yum.theforeman.org/releases/latest/el7/x86_64/foreman-release.rpm -y

### Install foreman-installer

Install the package "foreman-installer" from the now available repositories.

    # yum install foreman-installer -y


!SLIDE smbullets small
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Install an All-in-one setup

* Objective:
 * Install an All-in-one setup of Foreman with DNS and DHCP
* Steps:
 * Run foreman-installer with additional parameters
* Notes:
 * DNS (interface=eth0, zone=localdomain, reverse=0.0.10.in-addr.arpa, forwarders=8.8.8.8,8.8.4.4)
 * DHCP (interface=eth0, gateway=10.0.0.1, range=10.0.0.100-10.0.0.200, nameserver=10.0.0.2)

~~~SECTION:notes~~~

* Show the students the interactive mode in advance - we will not use it to prevent typos
* Show the students the answer file - it provides information for further runs of the installer

~~~ENDSECTION~~~


!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Install an All-in-one setup

## Objective:

****

* In this lab we will install an All-in-one setup of Foreman with DNS and DHCP

## Steps:

****

* Run foreman-installer with additional parameters

#### Notes:

DNS should be enabled and configured with the following parameters:

 * interface=eth0
 * zone=localdomain
 * reverse=0.0.10.in-addr.arpa
 * forwarders=8.8.8.8,8.8.4.4

DHCP should be enabled and configured with the following parameters:

 * interface=eth0
 * gateway=10.0.0.1
 * range=10.0.0.100-10.0.0.200
 * nameserver=10.0.0.2

#### Expected result:

The Foreman installer runs successfully and provides login credentials to login to 'https://foreman.localdomain'.

You can find your provided parameters in the answer file created in '/etc/foreman/foreman-installer-answers.yaml'.


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Install an All-in-one setup

****

## Install an All-in-one setup of Foreman with DNS and DHCP

****

### Run foreman-installer with additional parameters

To install run the following command:

    # foreman-installer \
    --foreman-proxy-dns=true \
    --foreman-proxy-dns-interface=eth0 \
    --foreman-proxy-dns-zone=localdomain \
    --foreman-proxy-dns-reverse=0.0.10.in-addr.arpa \
    --foreman-proxy-dns-forwarders=8.8.8.8 \
    --foreman-proxy-dns-forwarders=8.8.4.4 \
    --foreman-proxy-dhcp=true \
    --foreman-proxy-dhcp-interface=eth0 \
    --foreman-proxy-dhcp-gateway=10.0.0.1 \
    --foreman-proxy-dhcp-range="10.0.0.100 10.0.0.200" \
    --foreman-proxy-dhcp-nameservers="10.0.0.2"

This will output on success something similar:

    Success!
    * Foreman is running at https://foreman.localdomain
        Initial credentials are admin / PASSWORD
    * Foreman Proxy is running at https://foreman.localdomain:8443
    * Puppetmaster is running at port 8140
    * The full log is at /var/log/foreman-installer/foreman-installer.log

With the provided credentials login to 'https://foreman.localdomain' using your browser.

**Hint:** You can change password and language settings on the "My Account" page when clicking on the username in the upper right corner.


!SLIDE smbullets small
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Add DNS configuration to Foreman

* Objective:
 * Create the domain 'localdomain' and associate Smart proxy
* Steps:
 * Login to Foreman
 * Navigate to 'Infrastructure > Domains'
 * Add the domain 'localdomain' and associate Smart Proxy 'foreman.localdomain'

~~~SECTION:notes~~~

* If the Puppet agent on the Foreman server has already run the domain will already be created
but not associated.

~~~ENDSECTION~~~


!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Add DNS configuration to Foreman

## Objective:

****

* Foreman will be configured to know about the DNS domain 'localdomain'

## Steps:

****

* Login to Foreman
* Navigate to 'Infrastructure > Domains'
* Add the domain 'localdomain' and associate Smart proxy 'foreman.localdomain'

#### Notes:

If the Puppet agent on the Foreman server has already run the domain will already be created
but not associated.


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Add DNS configuration to Foreman

****

## Create the domain 'localdomain' and associate Smart proxy

****

### Login to Foreman

With the provided credentials login to 'https://foreman.localdomain' using your browser.

### Navigate to 'Infrastructure > Domains'

### Add the domain 'localdomain' and associate Smart proxy 'foreman.localdomain'

Click on 'New Domain' and in the dialog insert:

* DNS domain: 'localdomain'
* DNS Proxy: 'foreman.localdomain' 

If the domain 'localdomain' was already created click on the domain name and change the
DNS Proxy to 'foreman.localdomain'.

Press 'Submit' to store the configuration.


!SLIDE smbullets small
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Add DHCP configuration to Foreman

* Objective:
 * Create the subnet 'foreman' and associate Smart proxies
* Steps:
 * Login to Foreman
 * Navigate to 'Infrastructure > Smart proxies'
 * Add the subnet 'foreman' by importing from the Smart Proxy 
 * Adjust additional settings via 'Infrastructure > Subnets'

~~~SECTION:notes~~~

* Subnets are not automatically created like domains.

~~~ENDSECTION~~~


!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Add DHCP configuration to Foreman

## Objective:

****

* Foreman will be configured to know about the DHCP subnet

## Steps:

****

* Login to Foreman
* Navigate to 'Infrastructure > Smart proxies'
* Add the subnet 'foreman' by importing from the Smart Proxy
* Adjust additional settings via 'Infrastructure > Subnets'

#### Notes:

We will use the complete DHCP range the DHCP server provides.


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Add DHCP configuration to Foreman

****

## Create the subnet 'foreman' and associate Smart proxies

****

### Login to Foreman

With the provided credentials login to 'https://foreman.localdomain' using your browser.

### Navigate to 'Infrastructure > Smart Proxies'

### Add the subnet 'foreman' by importing from the Smart Proxy

Select 'Import IPv4 subnets' from the drop down menu next to the Smart Proxy 'foreman.localdomain' and in the dialog insert:

* Name: 'foreman'
* Protocol: IPv4
* Network address: '10.0.0.0' 
* Network mask: '255.255.0.0' 
* Network prefix: '16' 
* Gateway address: '10.0.0.1' 
* Primary DNS server: '10.0.0.2' 
* Secondary DNS server: keep empty
* IPAM: 'DHCP'
* VLAN ID: keep empty
* Boot mode: 'DHCP'

Press 'Submit' to store the configuration.

### Adjust additional settings via 'Infrastructure > Subnets'

Afterwards we have to return to the configuration via 'Infrastructure > Subnets' to add the IP range:

* Subnet tab:
 * Start of IP range: '10.0.0.100'
 * End of IP range: '10.0.0.200'

* Domain tab:
 * Select 'localdomain'

* Proxies tab:
 * DHCP Proxy: 'foreman.localdomain'
 * TFTP Proxy: 'foreman.localdomain'
 * DNS Proxy: 'foreman.localdomain'

Press 'Submit' to store the configuration with this change.
