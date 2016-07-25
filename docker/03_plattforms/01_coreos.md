!SLIDE smbullets small
# CoreOS

* Open Source based on the Linux kernel
* No local software installation via packages, only containers
* Container support via *Docker* and *Rocket*
* System updates with *FastPatch* and *locksmith*
* Clustering with *etcd* und *fleetd*

~~~SECTION:handouts~~~

****

CoreOS is an open source operating system based on the Linux kernel which does not provide
a local software installation via packages and only acts as platform for containers. It
supports *Docker* and *Rocket* as container engine.

For system updates CoreOS uses *Fastbatch* which uses a dual-partition scheme for updates and
*locksmith* to orchestrate cluster-wide updates. A Cluster is build using *etcd* as a cluster-wide
dynamic configuration registry and *fleetd* as a cluster manager controling systemd on the systems.

For more details: https://coreos.com/

~~~ENDSECTION~~~


!SLIDE smbullets small
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: CoreOS

* Objective:
 * Deploy a CoreOS host as Docker Compute Resource
* Steps:
 * Add CoreOS as Operating System
 * Provision a CoreOS host on your libvirt Compute Resource
 * Register the CoreOS host as Docker Compute Resource



!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: CoreOS

## Objective:

****

* Deploy a CoreOS host as Docker Compute Resource

## Steps:

****

* Add CoreOS as Operating System
 * Create the Operating System
 * Associate the Provisioning Templates
 * Set the Provisioning Templates as default
 * Set the parameter install-disk and ssh_authorized_keys
* Provision a CoreOS host on your libvirt Compute Resource
* Register the CoreOS host as Docker Compute Resource

CoreOS uses socket-based activation for Docker, so no local service configuration is required

#### Expected result:

A Docker Compute Resource running on CoreOS is available to deploy Docker container


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: CoreOS

****

## Deploy a CoreOS host as Docker Compute Resource

****

### Add CoreOS as Operating System

First step is to prepare CoreOS as Operating System to be deployed using Foreman.

#### Create the Operating System

Navigate to "Hosts > Operating System" and select "New Operating system". Name it "CoreOS",
insert the latest version from https://stable.release.core-os.net/amd64-usr/ for "Major version"
and "Minor Version", select "CoreOS" as "Family" and use "stable" as "Release name". Select "x86_64"
as architecture and press "Submit".

#### Associate the Provisioning Templates

Navigate to "Hosts > Provisioning Templates" and search for "coreos". Associate all templates with
the operating system "CoreOS" you created. The cloudconfig snippet would be your way to configure
clustering and additional resources.

#### Set the Provisioning Templates as default

Switch back to "Hosts > Operating System" and select your operating system "CoreOS" afterwards select
"CoreOS default fake" as "Partition Template", the "CoreOS mirror" as "Installation media" and your
Provisioning Templates as default. 

#### Set the parameter install-disk and ssh_authorized_keys

On the "Parameter" tab set "install-disk" to "/dev/sda" and add your public SSH key as ssh_authorized_keys.
Afterwards press "Submit" to save your configuration.

### Provision a CoreOS host on your libvirt Compute Resource

Go to "Hosts > New Host" and deploy a new host on your Compute Resource using the Operating system "CoreOS".
After the provisioning is finished you will be able to connect to the system using your ssh key for user "core".

### Register the CoreOS host as Docker Compute Resource

CoreOS uses socket-based activation on Port 2375 for Docker, so no local service configuration is required. Simply
navigate to "Infrastructure > Compute resources" and press "New Compute Resource" to create a new resource of type
Docker.
