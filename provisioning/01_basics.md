!SLIDE subsection
# ~~~SECTION:MAJOR~~~ Provisioning


!SLIDE smbullets small
# Provisioning

* Definition:

*Server provisioning is a set of actions to prepare a server with appropriate systems, data and software,
and make it ready for network operation.* 

* Task:

Automate it!

~~~SECTION:handouts~~~

****

Wikipedia defines server provisioning as *a set of actions to prepare a server with appropriate systems, data and software,
and make it ready for network operation* and your task will be to automated it.

~~~ENDSECTION~~~


!SLIDE smbullets small
# Basics on automated installation

* Installer asks questions during installation
* Answer file could be provided in several ways
 * Basic configuration like timezone and language settings
 * Partition layout
 * Software installation
 * Registration to management tools
* Additional scripts during and after installation

~~~SECTION:notes~~~

* Simple installation than use configuration management

~~~ENDSECTION~~~


~~~SECTION:handouts~~~

****

For an automated installation it is required that the installer of the operating system allows to answer the questions
normally asked to the users by providing an answer file. 

The different Linux installers can handle answer files provided via network protocols like http and ftp, network file
systems or placed on the installation media. In this way basic configuration like timezone, language or network settings 
can be handled, furthermore partition layout can be created, software is installed and depending on the solution also 
registration to management tools is directly integrated. 

~~~PAGEBREAK~~~

If the installer could not solve requirements directly, scripts could be provided to be executed during and after installation.

The mechanism differs for the distributions.

Operating system family | Installer        | Answer files
------------------------|------------------|--------------
Red Hat                 | Anaconda         | Kickstart
Debian                  | Debian-Installer | Preseed
SuSE                    | YaST2            | AutoYaST2

Other operating systems have similar mechanisms but not all the capabilities. Microsoft Windows for example requires
answer file to be placed on the installation media or a "physical" disk mounted during installation like floppy or usb.

Regardless of the capabilities with configuration management in place do a simple installation and let the configuration
management solution do its work.

~~~ENDSECTION~~~


!SLIDE smbullets small
# Kickstart

* Simple textfile with different sections
 * Main section with commands for basic configuration and partitioning
 * Package section for software installation
 * Pre and post scripts during installation
 * Additional sections can be added by addons
* Added as kernel parameter to boot media

~~~SECTION:notes~~~

* If someone asks show them the file in Foreman, but we will have a look into in the exercise, too

~~~ENDSECTION~~~

~~~SECTION:handouts~~~

****

Kickstart is the answer file to the installer used by Red Hat Enterprise Linux, CentOS, Scientific Linux, other
derivates and Fedora.

It is basicly a simple text file providing commands for basic configuration and partitioning in its main section
and a list of packages and package groups to install in addition to the core system in a package section. Skripts
can be added in separate sections to run as pre-installation task or post-installation on the installer or using
chroot on the installed system.

Lastest versions allow to extend the installer with addons which can also provide its own kickstart section for
automation. One example is the OSCAP Anaconda Addon which allows to validate against a security profile already
during installation.

~~~PAGEBREAK~~~

The URL to the kickstart file can be provided during installation or for automation added as a kernel parameter
to the boot media. Necessary answers missing will be queried.

Additional information: https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/7/html/Installation_Guide/chap-kickstart-installations.html

~~~ENDSECTION~~~


!SLIDE smbullets small
# Preseed

* Simple textfile with answers
 * Basic configuration and partitioning
 * Software installation
 * Scripts after installation
* Added as kernel parameter to boot media

~~~SECTION:handouts~~~

****

Preseed is the answer file for the Debian Installer used by Debian and Ubuntu.

It is basicly a simple text file providing answers to the installation questions. It uses for all types of 
configuration the same syntax. Scripts can be downloaded to the system and be executed after the installation.

The URL to the preseed file can be added to the boot menu entry or as a kernel parameter to the boot media for
automation, an additional parameter tells the installer to run unattended or use the answers only as default.

Additional information: https://wiki.debian.org/DebianInstaller/Preseed

~~~ENDSECTION~~~


!SLIDE smbullets small
# AutoYaST2

* Structured XML file
 * Basic configuration and partitioning
 * Software installation
 * Scripts during and after installation on different times
 * Configuration of selected software and devices
* Added as kernel parameter to boot media
  
~~~SECTION:handouts~~~

****

AutoYaST2 is the answer file for SuSE Linux Enterprise Server, Desktop and openSuSE using YaST2 as installer.

It is a structured XML file meant to be created by YaST and not by hand which provides answers to the installer
quests. Different data structures are used for all kinds of configuration. It can run scripts before installation
starts, after partitioning, after package installation using chroot, post installation on first boot before 
and after starting services. In addition it can configure selected software and devices like printing service
or soundcards. Other services can be configured with an file based configuration management.

The URL to the autoyast file has to be added as a kernel parameter to the boot media. Furthermore it allows
to create a control server providing rules to automatically select autoyast files.

Additional information: http://doc.opensuse.org/projects/autoyast/

~~~ENDSECTION~~~
