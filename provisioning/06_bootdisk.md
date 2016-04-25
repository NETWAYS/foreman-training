!SLIDE smbullets small
# Provisioning using Bootdisk plugin

* Foreman Plugin Bootdisk provides 4 kinds of boot images
 * Host images
 * Full host image
 * Generic image
 * Subnet image
* Based on iPXE for environments without control over network

~~~SECTION:handouts~~~

****

For the installation in an environment you do not have total control over the network infrastructure the
Foreman Plugin Bootdisk provides 4 kinds of boot images based on iPXE.

The host image contains a static network configuration, loads the installer from the media configured in Foreman
and the Provisioning configuration from Foreman itself. So it requires no DHCP and TFTP in the network.

~~~PAGEBREAK~~~

The full host image contains the operating system specific installer so it requires no downloading of it, but is
configured to boot from DHCP instead of having a static network configuration. To get its Provisioning configuration
from Foreman it identifies itself with a token only valid for one deployment.

The generic image boots from a dynamic IP address of the DHCP pool and is identified by the MAC address for Foreman
providing the correct installer via TFTP and Provisioning configuration to load.

The subnet image is basicly the same as the generic image but uses another TFTP server specified for the subnet.

~~~ENDSECTION~~~


!SLIDE smbullets small
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Install and configure the Bootdisk plugin

* Objective:
 * Install and configure the Bootdisk plugin
* Steps:
 * Run the Foreman installer to install the Bootdisk plugin
 * Associate iPXE template for operating systems

!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Install and configure the Bootdisk plugin

## Objective:

****

* Install and configure the Bootdisk plugin

## Steps:

****

* Run the Foreman installer to install the Bootdisk plugin
* Associate iPXE template for operating systems


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Install and configure the Bootdisk plugin

****

## Install and configure the Bootdisk plugin

****

### Run the Foreman installer to install the Bootdisk plugin

Add the parameters to enable the Bootdisk plugin

    # foreman-installer --enable-foreman-plugin-bootdisk

### Associate iPXE template for operating systems

Navigate to "Hosts > Provisioning Templates" and search for the iPXE templates.
Associate "Kickstart default iPXE" to CentOS and "Preseed default iPXE" to Debian.

Navigate to "Hosts > Operating systems" and select the iPXE templates associated.


!SLIDE smbullets small
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Reinstall the virtual machine "pxe"

* Objective:
 * Reinstall the virtual machine "pxe" from a host image
* Steps:
 * Set the Host in "Build" mode and download image
 * Configure virtual machine to boot from image
 * Boot and reinstall the virtual machine

!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Reinstall the virtual machine "pxe"

## Objective:

****

* Reinstall the virtual machine "pxe" from a host image

## Steps:

****

* Set the Host "pxe" in "Build" mode and download the host image
* Configure virtual machine to boot from image by adding a "CDROM" device and selecting it as boot media
* Boot and reinstall the virtual machine


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Reinstall the virtual machine "pxe"

****

## Reinstall the virtual machine "pxe" from a host image

****

### Set the Host "pxe" in "Build" mode and download the host image

Navigate to the Host view of your virtual machine "pxe" and press "Build", accept the dialog telling you
it will delete reports and then download the host image.

### Configure virtual machine to boot from image by adding a "CDROM" device and selecting it as boot media

Open the Details view of the virtual machine "pxe" in the Virtual Machine Manager. Add a new "CDROM" device,
go to the newly added device and connect the downloaded host image. Go to the boot option, select the "CDROM"
device and move it onto the first place of the boot order.

### Boot and reinstall the virtual machine

When you boot from the image you will recognize it starts with a static network configuration and gets its
installer via http from the configured installation media.
