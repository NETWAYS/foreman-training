!SLIDE subsection

# ~~~SECTION:MAJOR~~~ Introduction

!SLIDE smbullets small

# Training

This training course will introduce the architectual concepts of Foreman, will cover installation, usage and administration.
The configuration management solution used will be Puppet.

* Foreman architecture
* Installation
* Provisioning
* Configuration management
* User management
* Advanced Use

~~~SECTION:handouts~~~

****

This training course will introduce the architectual concepts of Foreman, will cover installation, usage and administration.
The configuration management solution used will be Puppet.

## Foreman architecture

This chapter will give you a basic understanding of the architecture of Foreman, its Smart proxies and Compute Resources.

~~~PAGEBREAK~~~

## Installation

In this chapter you will get an idea on the different setups you can create, what is required for running foreman, 
how the installer works and will create an All-in-one setup including DNS and DHCP in preparation for unattended installations.

## Provisioning

This chapter provides basic knowledge on automated installation mechnism for Linux. You will learn how to configure them
in the Foreman Web GUI. Afterwards several installation scenarios will be covered from bare metal installation using PXE
over creating virtual machines using Compute Resources and metal as a service with Foreman's Discovery Plugin to creating
a setup using installation media instead of PXE.

## Configuration management

Some basic explainations will give you enough knowledge to understand how Puppet works and to use it to configure newly provisioned
systems to your needs. Some existing Puppet modules will be imported, parameterized and assigned to the systems directly or
via a host group. Configuration runs will be reported back to Foreman so the administrator can see success and failure.

~~~PAGEBREAK~~~

## User management

To give more users access to the Foreman Web GUI LDAP authentication will be added. Privileges will be added to the new users.
Also the auditing capabilities of Foreman will be covered so you can see what your new users do.

## Advanced Use

Some advanced topics like debugging, clean up, backup and restore will be covered in this chapter. Also the usage of the API
and CLI will be shown. Furthermore additional plugins helpful in some environments will be introduced. And last but not least
the trainer will show you Katello. This project adds content and subscription management to Foreman and is the upstream project
for Red Hat Satellite 6.

~~~ENDSECTION~~~
