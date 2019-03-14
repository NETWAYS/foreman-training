# Setup

## Virtual machine foreman.localdomain

To setup a new version of the virtual machine install CentOS from ISO, only configuration required is
setting the network interface to manual, ip address 10.0.0.2, netmask 255.255.0.0, gateway 10.0.0.1,
dns 10.0.0.1.

Afterwards run the finish.sh provided in the _files directory to setup host entries and openldap.

## Virtual machine monitoring.localdomain

To setup a new version of the virtual machine install CentOS from ISO, only configuration required is
setting the network interface to manual, ip address 10.0.0.3, netmask 255.255.0.0, gateway 10.0.0.1,
dns 10.0.0.1.

Afterwards copy the files from _files/monitoring into /root/ and run the finish.sh to setup host including
Icinga 2, Icinga Web 2 and Director with preparations for the exercise.

## Local mirror

A Vagrant file is provided in the directory to setup a local mirror of CentOS 7 x86_64, EPEL 7 x86_64
Puppet EPEL 7 x86_64, Foreman EPEL 7 x86_64 and the Discovery Image. This machine will require about
25GB.

## Katello Demo

To setup the Katello demo follow this guide (it requires vagrant and ansible to be installed):

    # git clone https://github.com/Katello/forklift.git
    # cd forklift
    # vagrant up centos7-katello-3.10

This will setup your Katello server, login with the provided credentials and add the following content:

* GPG Key "RPM-GPG-KEY-CentOS-7" by uploading the key from a CentOS 7 system
* Product "CentOS7" with the key assigned
* Repository "CentOS7-Base-x86_64" of type "yum" and URL "http://mirror.centos.org/centos/7/os/x86_64/"
* Sync this repository - it will consume about 7GB (or choose "On Demand" to save some storage)
* Life Cycle Environment "Test" and "Production"
* Content View "CentOS7"
 * Add the Repository "CentOS7-Base-x86_64"
 * Publish new version
 * Promote "Version 1.0" to Life Cycle Environment "Test"
* Activation Key "CentOS7-Test"
 * Assigned to Life Cycle Environment "Test" and Content View "CentOS7"
 * Subscription to Repository "CentOS7-Base-x86_64"

Register the system to itself:

    # vagrant ssh centos7-katello-3.10
    # yum -y install katello-agent http://$(hostname -f)/pub/katello-ca-consumer-latest.noarch.rpm
    # subscription-manager register --org Default_Organization --activationkey="CentOS7-Test"

If you own a Red Hat Developer Subscription, it is also possible to create a Manifest and show the Red Hat
specific parts.

If you own a SUSE Subscription, you can install "tfm-rubygem-foreman_scc_manager" to show the SLES specific
parts. At the moment it requires you to install the nightly package because 3.10 does not include plugin
version 1.6.0 or higher.
