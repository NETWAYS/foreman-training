!SLIDE subsection
# ~~~SECTION:MAJOR~~~ Katello

!SLIDE smbullets small noprint
# Katello

* Defined set of Foreman plugins to provide Content management:
 * YUM repositories (RPM + Errata)
 * Puppet modules
 * Docker container
 * OSTree branches
* Subscription Management
 * Red Hat Subscriptions
 * Track internal use
* Defined scenario for Foreman Installer
* Multitenancy is enabled by default
* Upstream project for Red Hat Network Satellite 6

<div style="text-align:right">
<img src="./_images/katello-logo.png" style="float: right, max-width:200px; max-height: 150px; width: auto; height: auto; margin: 50px" alt="Katello Logo"/>
</div>

!SLIDE smbullets small printonly
# Katello

* Defined set of Foreman plugins to provide Content management:
 * YUM repositories (RPM + Errata)
 * Puppet modules
 * Docker container
 * OSTree branches
* Subscription Management
 * Red Hat Subscriptions
 * Track internal use
* Defined scenario for Foreman Installer
* Multitenancy enabled by default
* Upstream project for Red Hat Network Satellite 6

~~~SECTION:handouts~~~

****

Katello is a defined set of Foreman plugins which add Content management and Subcription management.

The Content management feature can manage YUM repositories to provide software in RPM package format and
errata explaining the importance of the package updates, puppet modules for configuration management,
docker container for deploying application container and OSTree branches to support this type of update
format.

~~~PAGEBREAK~~~

The Subscription management feature allows to subscribe to a software distributor which will be in most
cases Red Hat. It also provides the possiblity to track the internal use of some software which can be very useful for support contracts or with multitenancy to handle customer environments.

It uses the same technology for installation as the Foreman by providing a scenario to the Foreman installer. The usage of this
installer is the supported way of installation for Katello, so there is no way of adding the plugin later to an existing Foreman installation for now.

It alters Foreman in several ways including enabling multitenancy by default to enable internal Subscription managment.

Katello is also the upstream project for Red Hat Network Satellite 6 like Spacewalk was for Satellite 5.

Detailed information on the project homepage: http://www.katello.org/

~~~ENDSECTION~~~
