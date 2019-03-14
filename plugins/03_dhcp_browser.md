!SLIDE smbullets small
# DHCP Browser

* Adds the DHCP management interface
 * Browse DHCP reservations
 * Create DHCP reservations for hosts not managed by Foreman

* _Use case:_ More transparency for the DHCP management

~~~SECTION:handouts~~~

****

The Foreman Plugin DHCP Browser adds a DHCP management interface to the Foreman WebGUI next to the
subnets which allows to browse DHCP reservations and it is also quite useful for managing reservations
for hosts not managed by the Foreman.

More details on: https://github.com/theforeman/foreman_dhcp_browser

~~~ENDSECTION~~~

!SLIDE smbullets small
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: DHCP Browser

* Objective:
 * Inspect DHCP reservations
* Steps:
 * Install the Foreman Plugin DHCP Browser
 * Inspect DHCP reservations via the Plugin

!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: DHCP Browser

## Objective:

****

* Inspect DHCP reservations

## Steps:

****

* Install the Foreman Plugin DHCP Browser using the foreman-installer
* Inspect DHCP reservations of the subnet "foreman"

#### Expected result:

You will find one reservation for every host created earlier.

!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: DHCP Browser

****

## Inspect DHCP reservations

****

### Install the Foreman Plugin DHCP Browser using the foreman-installer

    # foreman-installer --enable-foreman-plugin-dhcp-browser

### Inspect DHCP reservations of the subnet "foreman"

Navigate to "Infrastructure > Subnets" and press the "DHCP" button next to the subnet "foreman".
In the following DHCP Browser you will find one reservation for every host created earlier and
the option to create "New DHCP Records".
