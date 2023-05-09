!SLIDE smbullets small
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Prepare Installation

* Objective:
 * Prepare the installation of Foreman
* Steps:
 * Start the virtual machine "foreman.localdomain" and connect via SSH
 * Make Puppet vendor repository for Puppet available
 * Make Powertools repository available
 * Make Foreman and Katello repository available
 * Enable the modules for katello and pulpcore
 * Install foreman-installer-katello


!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Prepare Installation

## Objective:

****

* In this lab you prepare the installation of Foreman.

## Steps:

****

* Start the virtual machine "foreman.localdomain" and connect via SSH

You can start the virtual machine "foreman.localdomain" with Virt-Manager from the Systemtools and connect
via SSH as 'root' so you can copy and paste to the console.

* Make Puppet vendor repository available

Install the release package provided by the Puppet vendor repository to make it available for package
installation of open source version of Puppet. We will use Puppet 7.

URL: http://yum.puppet.com/puppet7

* Make Powertools repository available

The repository is already configured as disabled, so it only needs enabling.

Command: dnf config-manager --set-enabled powertools

* Make Foreman and Katello repository available

Install the release packages provided by the Foreman and Katello repository to make it available for package
installation of Foreman and its components. We use Foreman 3.5 and Katello 4.7.

URL: http://yum.theforeman.org

* Enable the modules for katello and pulpcore

The modules provided by the Foreman project will enable all module dependencies to get the correct software versions.

* Install foreman-installer-katello

Install the package "foreman-installer-katello" from the now available repositories. This is the installer with the
scenario Katello included.

#### Notes:

The host firewall allows traffic between virtual machines in the same network and forwards traffic
from the virtual machine network to the host so no configuration is required.

#### Expected result:

The Foreman installer is installed and "foreman-installer --scenario katello --help" could be run from command line.


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Prepare Installation

****

## Prepare the installation of Foreman

****

### Start the virtual machine "foreman.localdomain" and connect via SSH

You can start the virtual machine "foreman.localdomain" with "Virtual Machine Manager" application
from the Gnome Application menu and connect via SSH as 'root' with password 'netways' so you can copy
and paste to the console.

    # ssh root@foreman.localdomain

### Make Puppet vendor repository available

Install the release package provided by the Puppet vendor repository to make it available for package
installation of open source version of Puppet.

    # dnf install http://yum.puppet.com/puppet7/el/8/x86_64/puppet7-release-7.0.0-11.el8.noarch.rpm -y

### Make Powertools repository available

You can simply use the dnf config-manager, but editing the configuration directly will also work.

    # dnf config-manager --set-enabled powertools

### Make Foreman repository available

Install the release packages provided by the Foreman and Katello repository to make it available for package
installation of Foreman, Katello and its components. Taking the matching combination is required, for example
Foreman 3.5 and Katello 4.7 form one release.

    # dnf install http://yum.theforeman.org/releases/3.5/el8/x86_64/foreman-release.rpm \
         http://yum.theforeman.org/katello/4.7/katello/el8/x86_64/katello-repos-latest.rpm -y

### Enable the modules for katello and pulpcore

Enabling the modules will enable module dependencies. If you see errors about conflicts with the default modules,
you can ignore them as this will be solved after module activation.

    # dnf module enable katello:el8 pulpcore:el8

### Install foreman-installer-katello

Install the package "foreman-installer-katello" from the now available repositories.

    # dnf install foreman-installer-katello -y


!SLIDE smbullets small
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Install Katello

* Objective:
 * Install Katello with TFTP, DNS and DHCP
* Steps:
 * Run foreman-installer with additional parameters
* Notes:
 * TFTP (default configuration)
 * DNS (interface=enp1s0, zone=localdomain, reverse=0.10.in-addr.arpa, forwarders=8.8.8.8,8.8.4.4)
 * DHCP (interface=enp1s0, gateway=10.0.0.1, range=10.0.0.100-10.0.0.200, nameserver=10.0.0.2)
 * Tuning "development" is needed because of sizing of the VM
 * Optionally provide initial credentials, organization and location name

~~~SECTION:notes~~~

* Show the students the interactive mode in advance - we will not use it to prevent typos
* Explain array handling (same parameter multiple times) and dhcp range (whitespace-separated string like in the config)
* Show the students the answer file - it provides information for further runs of the installer

~~~ENDSECTION~~~


!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Install Katello

## Objective:

****

* In this lab we will install Katello with TFTP, DNS and DHCP

## Steps:

****

* Run foreman-installer with additional parameters

#### Notes:

TFTP can use its default configuration.

DNS should be enabled and configured with the following parameters:

 * interface=enp1s0
 * zone=localdomain
 * reverse=0.10.in-addr.arpa
 * forwarders=8.8.8.8,8.8.4.4

DHCP should be enabled and configured with the following parameters:

 * interface=enp1s0
 * gateway=10.0.0.1
 * range=10.0.0.100-10.0.0.200
 * nameserver=10.0.0.2

Tuning allows to configure for system size, in our case we need "development" for our under-sized VM.

#### Expected result:

The Foreman installer runs successfully and provides login credentials to login to 'https://foreman.localdomain'.

You can find your provided parameters in the answer file created in '/etc/foreman-installer/scenarios.d/foreman-answers.yaml'.


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Install Katello

****

## Install Katello with TFTP, DNS and DHCP

****

### Run foreman-installer with additional parameters

To install run the following command:

    # foreman-installer \
    --scenario katello \
    --foreman-proxy-tftp=true \
    --foreman-proxy-dns=true \
    --foreman-proxy-dns-interface=enp1s0 \
    --foreman-proxy-dns-zone=localdomain \
    --foreman-proxy-dns-reverse=0.10.in-addr.arpa \
    --foreman-proxy-dns-forwarders=8.8.8.8 \
    --foreman-proxy-dns-forwarders=8.8.4.4 \
    --foreman-proxy-dhcp=true \
    --foreman-proxy-dhcp-interface=enp1s0 \
    --foreman-proxy-dhcp-gateway=10.0.0.1 \
    --foreman-proxy-dhcp-range="10.0.0.100 10.0.0.200" \
    --foreman-proxy-dhcp-nameservers="10.0.0.2" \
    --tuning development

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
 * Verify the domain 'localdomain' was created and associate Smart proxy
* Steps:
 * Login to Foreman
 * Navigate to 'Infrastructure > Domains'
 * Verify the domain 'localdomain' was created and associate Smart Proxy 'foreman.localdomain'

~~~SECTION:notes~~~

* The Foreman server itself will automatically be registered and all required objects will be created

~~~ENDSECTION~~~


!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Add DNS configuration to Foreman

## Objective:

****

* Verify the domain 'localdomain' was created and associate Smart proxy

## Steps:

****

* Login to Foreman
* Navigate to 'Infrastructure > Domains'
* Verify the domain 'localdomain' was created and associate Smart Proxy 'foreman.localdomain'

#### Notes:

The Foreman server itself will automatically be registered and all required objects will be created.
This is the reason we will see the domain already created but not associated to a Smart Proxy.


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Add DNS configuration to Foreman

****

## Verify the domain 'localdomain' was created and associate Smart proxy

****

### Login to Foreman

With the provided credentials login to 'https://foreman.localdomain' using your browser.

### Navigate to 'Infrastructure > Domains'

### Add the domain 'localdomain' and associate Smart proxy 'foreman.localdomain'

As the domain 'localdomain' will already be created click on the domain name and change the
DNS Proxy to 'foreman.localdomain'.

Press 'Submit' to store the configuration.


!SLIDE smbullets small
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Add DHCP configuration to Foreman

* Objective:
 * Create the subnet 'foreman' and associate Smart proxies
* Steps:
 * Navigate to 'Infrastructure > Smart proxies'
 * Add the subnet 'foreman' by importing from the Smart Proxy 
 * Adjust additional settings via 'Infrastructure > Subnets'

~~~SECTION:notes~~~

* Subnets are not automatically created like domains. Importing from a Smart Proxy is easier than manual creation.

~~~ENDSECTION~~~


!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Add DHCP configuration to Foreman

## Objective:

****

* Create the subnet 'foreman' and associate Smart proxies

## Steps:

****

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

### Navigate to 'Infrastructure > Smart Proxies'

### Add the subnet 'foreman' by importing from the Smart Proxy

Select 'Import IPv4 subnets' from the drop down menu next to the Smart Proxy 'foreman.localdomain' and in the dialog insert:

* Name: 'foreman'
* Description: *keep empty*
* Protocol: IPv4
* Network address: '10.0.0.0' 
* Network prefix: '16' 
* Network mask: '255.255.0.0' 
* Gateway address: '10.0.0.1' 
* Primary DNS server: '10.0.0.2' 
* Secondary DNS server: *keep empty*
* IPAM: 'DHCP'
* VLAN ID: *keep empty*
* MTU: *keep default*
* Link Delay: *keep default*
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
 * Reverse DNS Proxy: 'foreman.localdomain'

No parameters, "Default Organization" and "Default location" should be the default.

Press 'Submit' to store the configuration with this change.
