# Setup

## Virtual machine

To setup a new version of the virtual machine install CentOS from ISO, only configuration required is
setting the network interface to manual, ip address 10.0.0.2, netmask 255.255.0.0, gateway 10.0.0.1,
dns 10.0.0.1.

Afterwards run the finish.sh provided in the _files directory to setup host entries and openldap.

## Local mirror

A Vagrant file is provided in the directory to setup a local mirror of CentOS 7 x86_64, EPEL 7 x86_64
Puppetlabs EPEL 7 x86_64, Foreman EPEL 7 x86_64 and the Discovery Image. This machine will require about
25GB.

## Katello Demo

To setup the Katello demo follow this guide:

    # git clone https://github.com/Katello/forklift.git
    # cd forklift
    # vagrant up centos7-katello-3.0

This will setup your Katello server, login with the provided credentials and add the following content:

* GPG Key "RPM-GPG-KEY-CentOS-7" by uploading the key from a CentOS 7 system
* Product "CentOS7" with the key assigned
* Repository "CentOS7-Base-x86_64" of type "yum" and URL "http://mirror.centos.org/centos/7/os/x86_64/"
* Sync this repository - it will consume about 7GB (or choose "On Demand to save some storage)
* Life Cycle Environment "Test" and "Production"
* Content View "CentOS7"
 * Add the Repository "CentOS7-Base-x86_64"
 * Publish new version
 * Promote "Version 1.0" to Life Cycle Environment "Test"
* Activation Key "CentOS7-Test"
 * Assigned to Life Cycle Environment "Test" and Content View "CentOS7"
 * Subscription to Repository "CentOS7-Base-x86_64"

Use this information to deploy some docker containers as Content Hosts:

    # cd docker/clients/
    # cp docker-compose.yml.example docker-compose.yml
    # vi docker-compose.yml
    # docker-compose scale el7=5

