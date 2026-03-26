!SLIDE smbullets small
# Subscription management - Accessing vendor repositories

* Red Hat
 * Subscription Manifest - certificates for communication and subscription data
 * Add Subscriptions to the manifest
 * Red Hat Repositories - available products and repositories
 * Products and Repositories on click
 * Reporting via plugin RH Cloud and virt-who

* SUSE - Similar workflow to Red Hat via Plugin

* Ubuntu ESM - Extract information from registered host

* Other software - Multiple authentication mechanisms are supported

~~~SECTION:handouts~~~

****

Subscription management is primarily implemented for cosuming Red Hat Content you subscribed to.

Red Hat allows to create a Subscription Manifest to move Subscription management from Red Hat Network to your environment.
This manifest includes the certificates required for communication and the subscription data. 
Which subscriptions you want to manage on Katello you can decide by adding them to the manifest.
Red Hat Repositories View shows available products and repositories covered by the subscription data and allows to select them which will automatically create and synchronize them to your system.
Reporting of the consumed subscriptions is done via the plugin RH Cloud and this also gets information for Virtual Subscriptions via virt-who.

~~~PAGEBREAK~~~

For SUSE a similar workflow can be enabled when using the Foreman SCC Manager plugin which is
available as package and can be found upstream at https://github.com/ATIX-AG/foreman_scc_manager.

To access Ubuntu ESM you get a subscription token which you can use to register one system and then extract the information needed to sync the repositories.

For other software restricting the access to the repository multiple authentication mechanisms are supported, like user/password, token or client certificates.

~~~ENDSECTION~~~

!SLIDE smbullets small
# Subscription management - Simple Content Access

* New way to handle content access which is default since Katello 4.7
* Subscriptions are only required for upstream access
* No Subscription assigned to clients
* Access to all repositories by default
 * Limited to only consumable ones (only RPM for dnf, DEB for apt)
 * Support for restricting access by operating system (RHEL only)
 * Custom repositories disabled by default

~~~SECTION:handouts~~~

****

To simplify content management Katello introduced Simple Content Access which does remove the
need to assign subscriptions to clients, but a subcription to access upstream repositories is
still needed.

~~~PAGEBREAK~~~

Without the subscription limiting access to repositories a client can access all repositories
by default. This is limited to only consumable ones, so a system using dnf will only get
RPM repositories and using apt will only provide access to DEB repositories.
A solution using product certificates and operating system id allows RHEL system to automatically
restrict access to repositories for the correct version for Red Hat repositories and by assigning
such a restriction to a custom repository to expand it.
Custom repositories are disabled by default now to prevent accidential access, so enabling them
via Activation key is required.

Future improvements are very likely with ATIX already working on expanding the subscription-manager
to provide the operating system version so it could be utilized in a similar fashion for all systems
by Katello.

~~~ENDSECTION~~~
