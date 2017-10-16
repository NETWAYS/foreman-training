!SLIDE smbullets small
# Configuration in Foreman

* Operating System Version must be associated to:
 * Architecture
 * Installation media
 * Partition tables
 * Provisioning templates

~~~SECTION:handouts~~~

****

In Foreman the provisioning is centred on the operating system which has to be associated to
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
 * user_data
 * Script
* Selected on best match:
 * Host group and Environment
 * Host group
 * Environment
 * Operating system

~~~SECTION:handouts~~~

****

The templates are using ERB (embedded ruby) which allows to use parameters in the files, basic scripting
like conditionals and inclusion of snippets. Snippets can be everything from scripts to configuration files
you want to maintain independently because it is the same configuration for inclusion in different other
files or it will bloat up one file to render it unmaintainable.

~~~PAGEBREAK~~~

Depending on different provisioning mechanisms and methods other kinds of templates are required.

* PXELinux - Deployed to the TFTP server to ensure the Host boots the correct installer with the correct kernel options for BIOS boot
* PXEGrub / PXEGrub2 - Used in PXE environments in place of PXELinux for EFI boot
* iPXE - Used in {g,i}PXE environments in place of PXELinux
* Provision - The main unattended installation file, e.g. Kickstart or Preseed
* Finish - A post-install script used to make custom actions after the main provisioning is complete
* user_data - Similar to a Finish script, this can be assigned to hosts built on user_data-capable images (e.g. Openstack, EC2, etc)
* Script - An arbitrary script, not used by default, useful for certain custom tasks

Templates can be associated to operating systems, host groups, environments or combinations of host group and environment.
It will then select the templates to use on best match.

Partition tables are handled separately to allow the usage of the same host template with different disk layouts.

~~~ENDSECTION~~~


!SLIDE smbullets small
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Prepare PXE installation of CentOS

* Objective:
 * Prepare the installation of CentOS using PXE
* Steps:
 * Change the Installation media "CentOS mirror" to the local repo
 * Associate the PXELinux template "Kickstart default PXELinux" with CentOS
 * Associate the Provision template "Kickstart RHEL default" with CentOS
 * Associate the operating system with the Partition table "Kickstart default", Installation media "CentOS mirror",
select the Templates and set Parameter "enable-puppetlabs-puppet5-repo" to "true"

!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Prepare PXE installation of CentOS

## Objective:

****

* Prepare the installation of CentOS using PXE

## Steps:

****

* Change the Installation media "CentOS mirror" to the local repo
* Associate the PXELinux template "Kickstart default PXELinux" with CentOS
* Associate the Provision template "Kickstart RHEL default" with CentOS
* Associate the operating system with the Partition table "Kickstart default", Installation media "CentOS mirror",
select the Templates and set parameter "enable-puppetlabs-puppet5-repo" to "true"


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Prepare PXE installation of CentOS

****

## Prepare the installation of CentOS using PXE

****

### Change the Installation media "CentOS mirror" to the local repo

Navigate to "Hosts > Installation media", select the entry "CentOS mirror", change the "Path" to the
URL the trainer provided. 

### Associate the PXELinux template "Kickstart default PXELinux" with CentOS

Navigate to "Hosts > Provisioning templates" and search "Kickstart default PXELinux".
Click it and in the dialog on the "Association" tab move the entry for CentOS to the "Selected Items".
If no "Applicable Operating System" is shown, no puppet run on the Foreman server occurred, run it manually by excuting "puppet agent -t".
If using a local mirror adjust the URLs in this template.
Click on "Submit".

### Associate the Provision template "Kickstart RHEL default" with CentOS

Navigate to "Hosts > Provisioning templates" and search "Kickstart RHEL default".
Click it and in the dialog on the "Association" tab move the entry for CentOS to the "Selected Items".
Click on "Submit".

### Associate the operating system with the Partition table "Kickstart default", Installation media "CentOS mirror", select the Templates and set parameter "enable-puppetlabs-puppet5-repo" to "true"

Navigate to "Hosts > Operating systems" and search the CentOS entry.
Click it and in the dialog on the "Partition table" tab select "Kickstart default", on the tab "Installation media"
select "CentOS mirror", on the "Templates" tab select the templates associated earlier and on the "Parameters" tab
add the parameter "enable-puppetlabs-puppet5-repo" with value "true".
Click on "Submit".


!SLIDE smbullets small
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Prepare PXE installation of Debian

* Objective:
 * Prepare the installation of Debian using PXE
* Steps:
 * Change the Installation media "Debian mirror" to the local repo
 * Create the Operating system "Debian" with Major version "9", Description "Debian stretch", Family "Debian", Release name "stretch"
 * Associate the PXELinux template "Preseed default PXELinux" with Debian
 * Associate the Provision template "Preseed default" with Debian
 * Associate the finish template "Preseed default finish" with Debian
 * Associate the operating system with the Templates and set Architecture "x86_64", Partition table "Preseed custom LVM" and "Preseed default", Installation media "Debian mirror" and set parameter "enable-puppetlabs-puppet5-repo" to "true"

~~~SECTION:handouts~~~

* Tell the students to skip Debian if only providing a local CentOS-Mirror.

~~~ENDSECTION~~~

!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Prepare PXE installation of Debian

## Objective:

****

* Prepare the installation of Debian using PXE

## Steps:

****

* Change the Installation media "Debian mirror" to the local repo
* Create the Operating system "Debian" with Major version "9", Description "Debian stretch", Family "Debian", Release name "stretch"
* Associate the PXELinux template "Preseed default PXELinux" with Debian
* Associate the Provision template "Preseed default" with Debian
* Associate the finish template "Preseed default finish" with Debian
* Associate the operating system with the Templates and set Architecture "x86_64", Partition table "Preseed custom LVM" and "Preseed default", Installation media "Debian mirror" and set parameter "enable-puppetlabs-puppet5-repo" to "true"


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Prepare PXE installation of Debian

****

## Prepare the installation of CentOS using Debian

****

### Change the Installation media "Debian mirror" to the local repo

Navigate to "Hosts > Installation media", select the entry "Debian mirror", change the "Path" to the
URL the trainer provided. 

### Create the Operating system "Debian" with Major version "9", Description "Debian stretch", Family "Debian", Release name "stretch"

Navigate to "Hosts > Operating systems" and click on "Create operating system".
In the dialog on the "Operating System" tab set the "Name" to "Debian", "Major version" to "9",
"Description" to "Debian stretch", "Family" to "Debian", "Release name" to "stretch".
Click on "Submit".

### Associate the PXELinux template "Preseed default PXELinux" with Debian

Navigate to "Hosts > Provisioning templates" and search "Preseed default PXELinux".
Click it and in the dialog on the "Association" tab move the entry for Debian to the "Selected Items".
Click on "Submit".

### Associate the Provision template "Preseed default" with Debian

Navigate to "Hosts > Provisioning templates" and search "Preseed default".
Click it and in the dialog on the "Association" tab move the entry for Debian to the "Selected Items".
Click on "Submit".

### Associate the finish template "Preseed default finish" with Debian

Navigate to "Hosts > Provisioning templates" and search "Preseed default finish".
Click it and in the dialog on the "Association" tab move the entry for Debian to the "Selected Items".
Click on "Submit".

### Associate the operating system with the Templates and set Architecture "x86_64", Partition table "Preseed custom LVM" and "Preseed default", Installation media "Debian mirror" and set parameter "enable-puppetlabs-puppet5-repo" to "true"

Navigate to "Hosts > Operating systems" and search the Debian entry.
Click it and in the dialog on the "Operating System" tab select the "Architecture" to "x86_64", on the "Partition table"
tab select "Preseed custom LVM" and "Preseed default", on the tab "Installation media" select "Debian mirror", on the 
"Templates" tab select the templates associated earlier and add the parameter "enable-puppetlabs-puppet5-repo" with value "true".
Click on "Submit".


!SLIDE smbullets small
# Foreman Setup

* A plugin installed by default
* Designed to help with the initial setup
 * Subnet and Domain information as input
 * Foreman-Installer commands as output
 * Configuration of Foreman host
 * Templates and Operating systems association
 * Installation media

~~~SECTION:handouts~~~

****

The Foreman Plugin Setup is installed by default to help with the initial setup (the steps we did manually).
It asks for domain and subnet information as input and will output Foreman-Installer commands. In addition
it will ensure configuration of the Foreman host, association of templates and operating systems and existence
of installation media.

~~~ENDSECTION~~~
