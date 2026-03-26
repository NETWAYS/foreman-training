!SLIDE smbullets small
# Compute Resource

* Plugin to create and manage virtual hosts
 * based on fog (Ruby cloud service library)
 * or native SDK / API
* Depending on virtualization provider
 * Unattended / Image-based installation
 * Console access
 * Power management
 * Changing virtual machine configuration
* Compute Profiles - predefined template for virtual hardware

~~~SECTION:notes~~~

ATIX is currently working on a generic openTOFU-based compute resource: https://github.com/ATIX-AG/foreman_opentofu

~~~ENDSECTION~~~

~~~SECTION:handouts~~~

****

Compute Resource refers to a virtualization or cloud service which is integrated into Foreman
as a plugin. Those plugins are based on the Ruby cloud service library named fog and enable
creating and managing virtual hosts. Some are based on a native SDK or API where no fog implementation
exists or is well maintained.

Depending on the provider machines are installed from an image or unattended in the same fashion
as a bare metal host. It enables access to the console
and do power management operations like shutting down or resetting the system.
Some providers also allow to change the virtual hardware afterwards.

~~~PAGEBREAK~~~

The table shows the providers directly supported by the Foreman Project and their respective capabilities.
Additional providers are listed in *italic* and integrated through separate plugins mostly contributed by the community.

Provider               | Unattended installation | Image-based | Console      | Power management | Update VM
-----------------------|-------------------------|-------------|--------------|------------------|----------
EC2                    | no                      | yes         | read-only    | yes              | no
Google Compute Engine  | no                      | yes         | no           | yes              | no
Libvirt                | yes                     | yes         | VNC or SPICE | yes              | no
OpenStack Nova         | no                      | yes         | no           | yes              | no
oVirt / RHEV           | yes                     | yes         | VNC or SPICE | yes              | no
VMware                 | yes                     | yes         | VNC or VMRC  | yes              | yes
*Azure*                | no                      | yes         | no           | yes              | no
*Kubevirt*             | no                      | yes         | planned      | yes              | no
*Proxmox*              | yes                     | yes         | VNC          | yes              | yes
*Scaleway*             | no                      | yes         | no           | yes              | no

Compute Profiles allow to predefine the virtual hardware as a template to select for provisioning.

~~~ENDSECTION~~~
