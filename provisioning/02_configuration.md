!SLIDE smbullets small
# Configuration in Foreman

* Operating system version must be associated to:
 * Architecture
 * Installation media
 * Partition tables
 * Provisioning templates

~~~SECTION:handouts~~~

****

In Foreman the provisioning is centered on the operating system which has to be associated with
the hardware architectures like i386 or x86_64, the installation media being the URL where
to find the boot media and software packages, partition tables and provisioning templates.

~~~ENDSECTION~~~

!SLIDE smbullets small
# Provisioning templates

* ERB-Templates allow scripting and inclusion of snippets
* Types:
 * PXELinux / PXEGrub / PXEGrub2 / iPXE
 * Provision
 * Finish
 * user_data / cloud_init
 * Script
* Selected on best match:
 * Host group and Environment
 * Host group
 * Environment
 * Operating system

~~~SECTION:notes~~~

* Partition templates are similar but assigned per host

~~~ENDSECTION~~~

~~~SECTION:handouts~~~

****

The templates are using ERB (embedded Ruby) which allows to use parameters in the files, basic scripting
like conditionals and inclusion of snippets. Snippets can be everything from scripts to configuration files
you want to maintain independently because it is the same configuration for inclusion in other files
or because it would bloat up one file and render it unmaintainable.

~~~PAGEBREAK~~~

Depending on different provisioning mechanisms and methods other kinds of templates are required.

* PXELinux - Deployed to the TFTP server to ensure the host boots the correct installer with the correct kernel options for BIOS boot
* PXEGrub / PXEGrub2 - Used in PXE environments in place of PXELinux for EFI boot
* iPXE - Used in {g,i}PXE environments in place of PXELinux
* Provision - The main unattended installation file, e.g. Kickstart or Preseed
* Finish - A post-install script used to make custom actions after the main provisioning is complete
* user_data - Similar to a Finish script, this can be assigned to hosts built on user_data-capable images (e.g. Openstack, EC2, etc)
* cloud_init - Uses the same format like user_data, but instead of sending it to the Compute Resource (e.g. VMware), it is queried by the system itself
* Script - An arbitrary script, not used by default, useful for certain custom tasks

Templates can be associated with operating systems, host groups, environments or combinations of host group and environment.
It will then select the templates to use on best match.
Partition tables are handled separately to allow the usage of the same host template with different disk layouts.
Depending on the Installer's capabilities Foreman also allows dynamic partitioning.

~~~ENDSECTION~~~


!SLIDE smbullets small
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Prepare PXE installation of CentOS Stream 9

* Objective:
 * Prepare the installation of CentOS using PXE
* Steps:
 * Change the Installation media "CentOS Stream 9 mirror" to the local repo (if provided)
 * Associate the installation media "CentOS Stream 9 mirror", verify the selected templates and set boolean parameter "enable-openvox8" to "true"

~~~SECTION:notes~~~

* Currently enable-openvox# works only for the registration template, for provisioning it needs to set up the repositoriy: https://github.com/theforeman/foreman/pull/10816/

~~~ENDSECTION~~~


!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Prepare PXE installation of CentOS Stream 9

## Objective:

****

* Prepare the installation of CentOS Stream 9 using PXE

## Steps:

****

* Change the Installation media "CentOS Stream 9 mirror" to the local repo (if provided)
* Associate the installation media "CentOS Stream 9 mirror", verify the selected templates and set boolean parameter "enable-openvox8" to "true"

#### Notes:

This was simplified with Foreman 3.5 as it automatically associates templates with the operating system and selects defaults when autocreated.

!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Prepare PXE installation of CentOS Stream 9

****

## Prepare the installation of CentOS Stream 9 using PXE

****

### Change the Installation media "CentOS Stream 9 mirror" to the local repo (if provided)

Navigate to "Hosts > Provisioning Setup > Installation media", select the entry "CentOS Stream 9 mirror", change the "Path" to the
URL the trainer provided.

### Associate the installation media "CentOS Stream 9 mirror", verify the selected templates and set boolean parameter "enable-openvox8" to "true"

Navigate to "Hosts > Provisioning Setup > Operating systems" and search the entry "CentOS Stream 9".
Click it and in the dialog on the "Partition table" tab you can verify that "Kickstart default" is selected. On the tab "Installation media"
select "CentOS Stream 9 mirror" (which is the one for CentOS Stream 9 onwards). On the "Templates" tab you can verify that "Kickstart default" is selected as
Provisioning template and "Kickstart default PXELinux" is the PXELinux template. These will be used in the next exercise, but there are more
selected for other ways of provisioning. And on the "Parameters" tab add the parameter "enable-openvox8" as "boolean" with value "true".
Click on "Submit".


!SLIDE smbullets small
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Prepare PXE installation of Debian

* Objective:
 * Prepare the installation of Debian using PXE
* Steps:
 * Change the Installation media "Debian mirror" to the local repo (if provided)
 * Create the Operating system "Debian" with Major version "12", Description "Debian bookworm", Family "Debian", Release name "bookworm"
 * Associate the Provision template "Preseed default" with Debian
 * Associate the operating system with the Templates and set Architecture "x86_64", Partition table "Preseed default LVM" and "Preseed default", Installation media "Debian mirror" and set boolean parameter "enable-official-puppet8-repo" to "true"

~~~SECTION:notes~~~

* Tell the students to skip Debian if only providing a local CentOS-Mirror.

~~~ENDSECTION~~~

!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Prepare PXE installation of Debian

## Objective:

****

* Prepare the installation of Debian using PXE

## Steps:

****

* Change the Installation media "Debian mirror" to the local repo (if provided)
* Create the Operating system "Debian" with Major version "12", Description "Debian bookworm", Family "Debian", Release name "bookworm"
* Associate the Provision template "Preseed default" with Debian
* Associate the operating system with the Templates and set Architecture "x86_64", Partition table "Preseed default LVM" and "Preseed default", Installation media "Debian mirror" and set boolean parameter "enable-openvox8" to "true"

#### Notes:

This was also simplified for other operating systems like it was for EL from Foreman 3.5 onwards, but not to the same extent.


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Prepare PXE installation of Debian

****

## Prepare the installation of Debian using PXE

****

### Change the Installation media "Debian mirror" to the local repo (if provided)

Navigate to "Hosts > Provisioning Setup > Installation media", select the entry "Debian mirror", change the "Path" to the
URL the trainer provided.

### Create the Operating system "Debian" with Major version "12", Description "Debian bookworm", Family "Debian", Release name "bookworm"

Navigate to "Hosts > Provisioning Setup > Operating systems" and click on "Create Operating System".
In the dialog on the "Operating System" tab set the "Name" to "Debian", "Major version" to "12",
"Description" to "Debian bookworm", "Family" to "Debian", "Release name" to "bookworm".
Click on "Submit".

### Associate the Provision template "Preseed default" with Debian

Navigate to "Hosts > Templates > Provisioning templates" and search "Preseed default".
Click it and in the dialog on the "Association" tab move the entry for Debian to the "Selected Items".
Click on "Submit".

### Associate the operating system with the Templates and set Architecture "x86_64", Partition table "Preseed default LVM" and "Preseed default", Installation media "Debian mirror" and set parameter "enable-openvox8" to "true"

Navigate to "Hosts > Provisioning Setup > Operating systems" and search the Debian entry.
Click it and in the dialog on the "Operating System" tab select the "Architecture" to "x86_64", on the "Partition table"
tab select "Preseed default LVM" and "Preseed default", on the tab "Installation media" select "Debian mirror", on the
"Templates" tab verify templates associated for Finish template and PXELinux template and select the Provisioning template associated earlier,
 and add the parameter "enable-openvox8" as "boolean" with value "true".
Click on "Submit".



!SLIDE smbullets small
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Prepare PXE installation of Ubuntu

* Objective:
 * Prepare the installation of Ubuntu using PXE
* Steps:
 * Provide the LiveCD as ISO and in extraced form
 * Create the Installation media "Ubuntu Autoinstall"
 * Create the Operating system "Ubuntu" with Major version "24.04", Minor version "4", Description "Ubuntu Noble Numbat", Family "Debian", Release name "noble"
 * Associate the PXELinux template "Preseed default PXELinux Autoinstall" with Ubuntu
 * Associate the User data template "Preseed Autoinstall cloud-init user data" with Ubuntu
 * Associate the operating system with the Templates and set Architecture "x86_64", Partition table "Preseed default autoinstall", Installation media "Ubuntu Autoinstall" and set boolean parameter "enable-official-puppet8-repo" to "true"

~~~SECTION:notes~~~

* Tell the students to skip Ubuntu if only providing a local CentOS-Mirror.

~~~ENDSECTION~~~

!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Prepare PXE installation of Ubuntu

## Objective:

****

* Prepare the installation of Ubuntu using PXE

## Steps:

****

* Provide the LiveCD as ISO and in extraced form
* Create the Installation media "Ubuntu Autoinstall"
* Create the Operating system "Ubuntu" with Major version "24.04", Minor version "4", Description "Ubuntu Noble Numbat", Family "Debian", Release name "noble"
* Associate the PXELinux template "Preseed default PXELinux Autoinstall" with Ubuntu
* Associate the User data template "Preseed Autoinstall cloud-init user data" with Ubuntu
* Associate the operating system with the Templates and set Architecture "x86_64", Partition table "Preseed default autoinstall", Installation media "Ubuntu Autoinstall" and set boolean parameter "enable-official-puppet8-repo" to "true"

#### Notes:

This was also simplified for other operating systems like it was for EL from Foreman 3.5 onwards, but not to the same extent.


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Prepare PXE installation of Ubuntu

****

## Prepare the installation of Ubuntu using Debian

****

### Provide the LiveCD as ISO and in extraced form

You need to download the Server ISO from the official download website (or a mirror provided by the trainer).
Create a subdirectory "ubuntu" underneath "/var/www/html/pub/" and place the ISO there named "24.04.4-amd64.iso".
To provide the contents of the ISO directly add a subdirectory "24.04.4-amd64" and bind mount the ISO.
In the training setup you can do this manually, in production use an fstab entry.

    # mkdir /var/www/html/pub/ubuntu
    # wget -O /var/www/html/pub/ubuntu/24.04.4-amd64.iso https://releases.ubuntu.com/24.04.4/ubuntu-24.04.4-live-server-amd64.iso
    # mkdir /var/www/html/pub/ubuntu/24.04.4-amd64
    # mount /var/www/html/pub/ubuntu/24.04.4-amd64.iso /var/www/html/pub/ubuntu/24.04.4-amd64
    # cd /var/www/html/pub/ubuntu
    # ln -s 24.04.4-amd64.iso 24.04.4-x86_64.iso
    # ln -s 24.04.4-amd64 24.04.4-x86_64

### Create the Installation media "Ubuntu Autoinstall"

Navigate to "Hosts > Provisioning Setup > Installation media", click on "Create Medium", name it "Ubuntu Autoinstall", as "Path" use "http://foreman.localdomain/pub/ubuntu/$major.$minor-$arch"
(http is required, https will not work) and select "Debian" as "Operating System Family".

### Create the Operating system "Ubuntu" with Major version "24.04", Minor version "4", Description "Ubuntu Noble Numbat", Family "Debian", Release name "noble"

Navigate to "Hosts > Provisioning Setup > Operating systems" and click on "Create operating system".
In the dialog on the "Operating System" tab set the "Name" to "Ubuntu", "Major version" to "24.04", "Minor version" to "4"
"Description" to "Ubuntu Noble Numbat", "Family" to "Debian", "Release name" to "noble".
Click on "Submit".

### Associate the PXELinux template "Preseed default PXELinux Autoinstall" with Ubuntu

Navigate to "Hosts > Templates > Provisioning templates" and search "Preseed default PXELinux Autoinstall".
Click it and in the dialog on the "Association" tab move the entry for Ubuntu to the "Selected Items".
Click on "Submit".

### Associate the User data template "Preseed Autoinstall cloud-init user data" with Ubuntu

Navigate to "Hosts > Templates > Provisioning templates" and search "Preseed Autoinstall cloud-init user data".
Click it and in the dialog on the "Association" tab move the entry for Ubuntu to the "Selected Items".
Click on "Submit".

~~~PAGEBREAK~~~

### Associate the operating system with the Templates and set Architecture "x86_64", Partition table "Preseed default autoinstall", Installation media "Ubuntu Autoinstall" and set boolean parameter "enable-openvox8" to "true"

Navigate to "Hosts > Provisioning Setup > Operating systems" and search the Ubuntu entry.
Click it and in the dialog on the "Operating System" tab select the "Architecture" to "x86_64", on the "Partition table"
tab select "Preseed default autoinstall", on the tab "Installation media" select "Ubuntu Autoinstall", on the
"Templates" tab select the templates associated earlier for User data template and PXELinux template, verify the Finish template is set,
and add the parameter "enable-openvox8" as "boolean" with value "true".
Click on "Submit".
