# Setup

## Virtual machine foreman.localdomain

To setup a new version of the virtual machine install CentOS Stream 9 from ISO, only configuration required is
setting the network interface to manual, IP address 10.0.0.2, netmask 255.255.0.0, gateway 10.0.0.1,
DNS 10.0.0.1. In addition you might want to allow SSH access for root.

Afterwards, run the Ansible playbook provided in the '_files' directory to setup host entries and OpenLDAP.

## Virtual machine monitoring.localdomain

To setup a new version of the virtual machine install Ubuntu 24.04 Server from ISO, only configuration required is
setting the network interface to manual, IP address 10.0.0.3, netmask 255.255.0.0, gateway 10.0.0.1,
DNS 10.0.0.1 and creating a user training with the default password.

Afterwards run the Ansible playbook provided in the '_files' directory to setup host including Icinga 2, Icinga Web 2 and Director with preparations for the exercise.

## Local mirror

To provide a local mirror use a Katello instance like needed for the Katello Demo.
In addition to RPM and DEB repositories you will need some files like the Ubuntu ISOs and Discovery image which you can drop in the /pub directory.
As most repositories stopped providing rsync, this is the best solution. Some limitations like Katello not supporting the Debian installer and the need to publish unprotected do apply of course.
You can also use on-demand downloading to save space, just run all the exercises once against the mirror.

## Katello Demo

To setup the Katello demo follow this guide (it requires vagrant and ansible to be installed):

    # git clone https://github.com/Katello/forklift.git
    # cd forklift
    # vagrant up centos9-stream-katello-4.15

This will setup your Katello server, login with the provided credentials and add the following content:

* GPG Key "RPM-GPG-KEY-centosofficial" by uploading the key from a CentOS Stream system
* Product "CentOS" with the key assigned
* Repository "CentOS-Stream-9-Base-x86_64" of type "yum" and URL "https://mirror.stream.centos.org/9-stream/BaseOS/x86_64/os/"
* Repository "CentOS-Stream-9-Appstream-x86_64" of type "yum" and URL "https://mirror.stream.centos.org/9-stream/Appstream/x86_64/os/"
* Sync this repository - it will consume about 10GB (or choose "On Demand" to save some storage)
* Life Cycle Environment "Test" and "Production"
* Content View "CentOS"
 * Add the Repositories "CentOS-Stream-9-Base-x86_64" and "CentOS-Stream-9-Appstream-x86_64"
 * Publish new version
 * Promote "Version 1.0" to Life Cycle Environment "Test"
* Activation Key "CentOS Stream 9 - Test"
 * Assigned to Life Cycle Environment "Test" and Content View "CentOS"
 * Enable the Repositories

Register the system to itself (typically not recommended) or use another system (depending on your setup) using the command provided by the UI.

If you own a Red Hat Developer Subscription, it is also possible to create a Manifest and show the Red Hat specific parts.

If you own a SUSE Subscription, you can install "tfm-rubygem-foreman_scc_manager" to show the SLES specific parts.
