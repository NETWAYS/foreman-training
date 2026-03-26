!SLIDE smbullets small
# SecureBoot

* SecureBoot is supported
 * Compute Resources - Choose the "Firmware"
 * Provisioning - Choose the "PXE loader"
* By default bootloader of Foreman server is used
* Bootloader universe allows for different bootloader
 * Directory structure - manually populate
 * Way to get bootloader differs per distribution

~~~SECTION:handouts~~~
****

While SecureBoot is supported and Foreman allows to choose the firmware of a newly created virtual machine on a compute resource and the PXE loader to use for provisioning, it will work out of the box only for the same operating system Foreman is installed on. This is a limitation which is in the design of SecureBoot as the first loaded bootloader determines which kernel can be loaded and Foreman can only use the one available from the underlaying operating system.

To resolve this limitation a so called Bootloader universe feature was added. This is a directory structure you can manually populate and when a matching bootloader is found this one will be used instaed of the default one. As the way to get the bootloader differs per distribution you can find instructions for this in https://docs.theforeman.org/3.18/Provisioning_Hosts/index-katello.html#configuring-smart-proxy-for-secure-boot

There are ideas how to make this workflow easier by having a central repository and there are new ways of provisioning in development like bootable containers as alternative.

~~~ENDSECTION~~~
