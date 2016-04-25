!SLIDE smbullets small
# Compute Resource

* Plugin to create and manage virtual hosts
 * based on fog (ruby cloud service library)
* Depending on virtualization provider
 * Unattended / Image-based installation
 * Console access
 * Power management
 * Changing virtual machine configuration
* Compute Profiles - predefined template for virtual hardware

~~~SECTION:handouts~~~

****

Compute Resource refers to a virtualization or cloud service which is integrate into Foreman
as a plugin. Those plugins are based on the ruby cloud service library named fog and allows
to create and manage virtual hosts. Depending on the provider machines are installed from an
image or unattended in the same fashion like a bare metal host. It allows to access the console
and do power management operations like shutting down or resetting the system. Some providers
also allow to change the virtual hardware afterwards.

~~~PAGEBREAK~~~

The table shows the providers directly supported by the Foreman Project and its capabilities,
additional providers like OpenNebula are community contributed.

Provider               | Package         | Unattended installation | Image-based | Console      | Power management
-----------------------|-----------------|-------------------------|-------------|--------------|------------------
EC2                    | foreman-ec2     | no                      | yes         | read-only    | yes
Google Compute Engine  | foreman-gce     | no                      | yes         | no           | yes
Libvirt                | foreman-libvirt | yes                     | yes         | VNC or SPICE | yes
OpenStack Nova         | foreman-compute | no                      | yes         | no           | yes
oVirt / RHEV           | foreman-ovirt   | yes                     | yes         | VNC or SPICE | yes
Rackspace              | foreman-compute | no                      | yes         | no           | yes
VMware                 | foreman-vmware  | yes                     | yes         | VNC          | yes

Compute Profiles allow to predefine the virtual hardware as a template to select for provisioning.

~~~ENDSECTION~~~
