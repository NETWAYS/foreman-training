!SLIDE smbullets small noprint
# Katello

<div style="text-align:right">
<img src="./_images/katello-logo.png" style="float: right; max-width:200px; max-height: 150px; width: auto; height: auto; margin: 20px" alt="Katello Logo"/>
</div>

* Defined set of Foreman plugins to provide Content management:
 * YUM repositories (RPM + Errata)
 * Debian repositories
 * Docker container
 * Ansible collections
 * ...
* Subscription Management
 * Red Hat Subscriptions
 * Track internal use
* Defined scenario for Foreman Installer
* Upstream project for
 * Red Hat Network Satellite 6
 * orcharhino

!SLIDE smbullets small printonly
# Katello

* Defined set of Foreman plugins to provide Content management:
 * YUM repositories (RPM + Errata)
 * Debian repositories
 * Docker container
 * Ansible collections
 * ...
* Subscription Management
 * Red Hat Subscriptions
 * Track internal use
* Defined scenario for Foreman Installer
* Upstream project for
 * Red Hat Network Satellite 6
 * orcharhino

~~~SECTION:handouts~~~

****

~~~PAGEBREAK~~~

Katello is a defined set of Foreman plugins which add Content management and Subcription management.

The Content management feature can manage YUM repositories to provide software in RPM package format and
errata explaining the importance of the package updates, Debian packages are also supported just without errata yet,
docker container to provide a local registry, ansible collection, python packages and ordinary files.
Before the switch to Pulp 3 a different set of formats was supported and with the plugin structure of it
support for addtional formats will likely be added in the future.

The Subscription management feature allows to subscribe to a software distributor which will be in most
cases Red Hat. It also provides the possiblity to track the internal use of some software which can be very useful for support contracts or with multitenancy to handle customer environments.

It uses the same technology for installation as the Foreman by providing a scenario to the Foreman installer. The usage of this
installer is the supported way of installation for Katello, so there is no way of adding the plugin later to an existing Foreman installation for now.

Katello is also the upstream project for Red Hat Network Satellite 6 like Spacewalk was for Satellite 5.

orcharhino is a product by ATIX AG based on Foreman and Katello and adds the possibility to manage Debian and Ubuntu content including errata support. It additionally provides content management for SUSE Linux Enterprise Server and Oracle Linux. 

For more information visit: https://orcharhino.com/ and https://docs.orcharhino.com

Detailed information on the project homepage: http://www.katello.org/

~~~ENDSECTION~~~
