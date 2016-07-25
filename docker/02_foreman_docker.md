!SLIDE smbullets small
# Foreman-Docker

* A plugin to integrate Docker
 * Register Docker hosts
 * Deploy and manage containers
 * Integrate private registries
* Default in Katello
* _Use case:_ Manage small scale docker deployments

~~~SECTION:handouts~~~

****

Foreman-Docker is a plugin for Foreman to integrate the management of Docker containers into
Foreman's WebGUI. It adds a new Compute Resource Provider "Docker" to register Docker hosts,
a search engine for the official Docker Hub registry to easily deploy and manage containers and
can also integrate private registries.

The plugin is part of Katello since version 2.2.

The plugins capabilities are not enough for a complex docker deployment but quite neat for small
scale docker deployments as you will see on the next pages.

More details on: https://theforeman.org/plugins/foreman_docker

~~~ENDSECTION~~~


!SLIDE smbullets small
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Foreman-Docker Preparation

* Objective:
 * Prepare Foreman-Docker to deploy a Docker container
* Steps:
 * Install the Foreman Plugin Docker
 * Prepare a Docker host
 * Add the Docker host as a Compute Resource


!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Foreman-Docker Preparation

## Objective:

****

* Prepare Foreman-Docker to deploy a Docker container

## Steps:

****

* Install the Foreman Plugin Docker using the foreman-installer
* Prepare one of the already installed hosts as a Docker host
 * Install docker
 * Make it listening to a network port
* Add the Docker host as a Compute Resource

#### Expected result:

A new Compute Resource of type "Docker" is ready for container deployment


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Foreman-Docker Preparation

****

## Prepare Foreman-Docker to deploy a Docker container

****

### Install the Foreman Plugin Docker using the foreman-installer

    # foreman-installer --enable-foreman-plugin-docker

### Prepare one of the already installed hosts as a Docker host

Use for this one of the already deployed hosts, you can only need to install
docker and make it listening to a network port. Port 2375 is assigned to unencrypted,
port 2376 to encrypted communication, but you can choose the port you prefer.

If using a CentOS host run the following commands:

     # yum install docker
     # vi /etc/sysconfig/docker
     OPTIONS='... -H tcp://0.0.0.0:2375 -H unix:///var/run/docker.sock'
     # systemctl start docker.service
     # systemctl enable docker.service
     # firewall-cmd --add-port 2375/tcp
     # firewall-cmd --permanent --add-port 2375/tcp

If using a Debian host run the following commands:

     # curl -sSL https://get.docker.com/ | sh
     # vi /etc/defaults/docker
     OPTIONS='... -H tcp://0.0.0.0:2375 -H unix:///var/run/docker.sock'
     # systemctl restart docker.service
     # systemctl enable docker.service

### Add the Docker host as a Compute Resource

In the Webinterface navigate to "Infrastructure > Compute Resource" and click on
"New Compute Resource". Insert the details of your Docker host, the Provider "Docker"
and the URL "http://10.0.0.X:2375" (X is the placeholder for your system). Press
"Test Connection" and if it succeeds press "Submit" to save it.



!SLIDE smbullets small
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Foreman-Docker Deployment

* Objective:
 * Deploy a Docker container on the Compute Resource
* Steps:
 * Deploy a Docker container
 * Inspect its provisioning
 * Inspect the Docker container



!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Foreman-Docker Deployment

## Objective:

****

* Deploy a Docker container on the Compute Resource

## Steps:

****

* Deploy a Docker container using the "New Container" wizard
* Inspect its provisioning
* Inspect the Docker container

#### Expected result:

A Docker container is provisioned and accessable



!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Foreman-Docker Deployment

****

## Deploy a Docker container on the Compute Resource

****

### Deploy a Docker container using the "New Container" wizard

Navigate to "Containers > New Container". On the first tab you select your Compute Resource, for now
only the one created earlier will be available. On the second tab you can search a registry, we will
use "Docker Hub" as we made no additional External registry available. Search for something you want
to deploy, e.g. icinga2. Select the Container image and its tag. On the Configuration tab name the
container and add the command you find in the Docker file, e.g. /opt/icinga2/initdocker, it will also
allow you to restrict its resource usage. On last tab you can add Environment variables, Exposed ports
you want additionally exposed and a DNS server. You can also configure the Shell if you want to connect
to the containers shell. And last but not least check "Run?" to automatically start the container after
deployment. With pressing "Submit" the Compute resource will connect to the registry and download the
image, if "Run?" was selected it will directly deploy the container, if not the detail view of the
container will tell you to "Power On" it.

### Inspect its provisioning

After the container is started it will execute the provided command which should initialize its provisioning.
You can inspect the running processes and the logs in the detail view of the container.

### Inspect the Docker container

When you see all expected process running or log output that indicates that the container's provisioning is
finished, you can connect to its exposed ports. Because we did not create any routing or proxy for this, the
easiest way will be a SSH tunnel, e.g. to provide a local port 8080 mapped to the HTTP-Port of the container
172.17.0.3 on hist 192.168.142.7 use:

     ssh -L 8080:172.17.0.3:80 root@192.168.142.7 -N



!SLIDE smbullets small
# Registry

* Make your own registry available for deployment
* Authentication supported
* Only version 1 format supported
 
~~~SECTION:handouts~~~

****

Foreman allows you to make your own registry available for deployment as external registry. It supports
authentication with one general account but not individual accounts like mapping the currently logged in
user. For now it also only supports version 1 of the registry api.

~~~ENDSECTION~~~
