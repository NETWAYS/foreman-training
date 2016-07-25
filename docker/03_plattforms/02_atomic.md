!SLIDE smbullets small
# AtomicProject

* Another flavour of Red Hat Enterprise Linux / CentOS / Fedora
* Atomic package management with *rpm-ostree*
* Container support via *Docker*
* Clustering with *etcd*
* Security via *SELinux* using *sVirt* for isolation

~~~SECTION:handouts~~~

****

The AtomicProject's goal is to provide a minimalistic version of Red Hat Enterprise Linux / CentOS 
/ Fedora for container deployment.

The atomic versions use *rpm-ostree* to do updates in an atomic fashion using patches like git.
for container support it uses *Docker* and for clustering *etcd*. For increasing isolation of
Docker containers it uses *SELinux* which assigns every container its only category via *sVirt*.

For more details: http://www.projectatomic.io/

~~~ENDSECTION~~~


!SLIDE smbullets small
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Atomic

* Objective:
 * Deploy a Fedora Atomic host as Docker Compute Resource
* Steps:
 * Add Fedora Atomic as Operating System
 * Provision a Fedora Atomic host on your libvirt Compute Resource
 * Register the Fedora Atomic host as Docker Compute Resource



!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Atomic

## Objective:

****

* Deploy a Fedora Atomic host as Docker Compute Resource

## Steps:

****

* Add Fedora Atomic as Operating System
 * Create the Operating System
 * Associate the Provisioning Templates
 * Set the Provisioning Templates as default
 * Set the parameter atomic-upstream
* Provision a Fedora Atomic host on your libvirt Compute Resource
* Register the Fedora Atomic host as Docker Compute Resource

#### Expected result:

A Docker Compute Resource running on Fedora Atomic is available to deploy Docker container


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Atomic

****

## Deploy a Fedora Atomic host as Docker Compute Resource

****

### Add Fedora Atomic as Operating System

First step is to prepare Fedora Atomic as Operating System to be deployed using Foreman.

#### Create the Operating System

Navigate to "Hosts > Operating System" and select "New Operating system". Name it "Fedora Atomic",
insert the latest version of Fedora for "Major version", e.g. 24., select "Red Hat" as "Family".
Select "x86_64" as architecture and press "Submit".

#### Associate the Provisioning Templates

Navigate to "Hosts > Provisioning Templates" and associate the templates "Atomic Kickstart Default"
and "Community Kickstart default PXELinux" with the operating system "Fedora Atomic" you created. 

#### Set the Provisioning Templates as default

Switch back to "Hosts > Operating System" and select your operating system "Fedora Atomic" afterwards
select "Kickstart default" as "Partition Template", the "Fedora Atomic mirror" as "Installation media"
and your Provisioning Templates as default. 

#### Set the parameter atomic-upstream

On the "Parameter" tab set "atomic-upstream" to "true", afterwards press "Submit" to save your configuration.

### Provision a Project Atomic host on your libvirt Compute Resource

Go to "Hosts > New Host" and deploy a new host on your Compute Resource using the Operating system "Fedora Atomic".
Use at least 2 GB Memory.  After the provisioning is finished you will be able to connect to the system using SSH
as user "root".

### Register the Project Atomic host as Docker Compute Resource

Docker is installed in the same fashion like it would be on the full-blown operating system, so you have to make
Docker listen on a TCP port.

     # vi /etc/sysconfig/docker
     OPTIONS='... -H tcp://0.0.0.0:2375 -H unix:///var/run/docker.sock'
     # systemctl restart docker.service
     # firewall-cmd --add-port 2375/tcp
     # firewall-cmd --permanent --add-port 2375/tcp

Afterwards navigate to "Infrastructure > Compute Resource" and use the "New Compute Resource" wizard to register the
system as Docker Compute Resource.
