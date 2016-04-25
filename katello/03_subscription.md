!SLIDE smbullets small
# Subscription management

* Red Hat
 * Subscription Manifest - certificates for communication and subscription data
 * Red Hat Repositories - available products and repositories
 * Products and Repositories on click
 * Content Hosts consume subscriptions

* Other software
 * Tracks subscribed Content Hosts for products

~~~SECTION:handouts~~~

****

Subscription management is primarily implemented for cosuming Red Hat Content you subcribed.

Red Hat allows to create a Subscription Manifest to move Subscription management from Red Hat
Network to your environment. This manifest includes the certificates required for communication
and the subscription data. Red Hat Repositories View shows available products and repositories
covered by the subscription data and allows to select them which will automatically create and
synchronize them to your system.

~~~PAGEBREAK~~~

The Content Hosts cosume these subscriptions in the same way like they were directly connected to
the Red Hat Network. If you purchased Virtual Subscriptions it requires you to run virt-what and
report your virtualization hosts before you can consume subscriptions with the virtual machines.

For other software Subscription Management can also be useful by simply tracking all subscribed
Content Hosts for products.

~~~ENDSECTION~~~

