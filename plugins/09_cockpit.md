!SLIDE smbullets small
# Cockpit

* WebGUI to manage your server
* Available on RHEL, CentOS, Fedora, Arch Linux and Ubuntu
* Available as native package or docker container for atomic

* _Use case:_ 
 * Manage atomic installations
 * Manage servers via WebGUI instead of direct console access

~~~SECTION:notes~~~

* Cockpit runs on Port 9090 and encryption depends on the protocol used to connect
* If not all URLs work have a look if a pull request is pending:  https://github.com/theforeman/foreman_cockpit/pull/3

~~~ENDSECTION~~~

~~~SECTION:handouts~~~

****

The Cockpit project provides a WebGUI to manage Linux servers. It is available as native package or
priviledged docker container for atomic on RHEL, CentOS, Fedora, Arch Linux and Ubuntu.

The Foreman plugin searches for an existing installation and integrates it into the Foreman WebGUI.

More details on: https://github.com/theforeman/foreman_cockpit

~~~ENDSECTION~~~

!SLIDE smbullets small
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Cockpit

* Objective:
 * Inspect your system using Cockpit integrated in the Foreman
* Steps:
 * Install and enable Cockpit
 * Install the Foreman Plugin Cockpit

!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Cockpit

## Objective:

****

* Inspect your system using Cockpit integrated in the Foreman

## Steps:

****

* Install Cockpit and enable the Cockpit websocket
* Install the Foreman Plugin Cockpit using the package "tfm-rubygem-foreman_cockpit"

#### Expected result:

Cockpit action menu shows up in the Host detail view and allows to inspect the system.


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Cockpit

****

## Inspect your system using Cockpit integrated in Foreman

****

### Install Cockpit and enable the Cockpit websocket

    # yum install cockpit
    # systemctl enable cockpit.socket
    # systemctl start cockpit.socket

### Install the Foreman Plugin Cockpit using the package "tfm-rubygem-foreman_cockpit"

    # yum install tfm-rubygem-foreman_cockpit -y
    # service httpd restart

