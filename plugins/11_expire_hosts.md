!SLIDE smbullets small
# Expire Hosts

* Set an expiration date on hosts
 * Notify owners and admins in advance
 * Shutdown on expiration date
 * Delete afterwards

* _Use case:_ 
 * Autoremove virtual machines of developers and testers
 * At least notify for hardware machines no longer required

~~~SECTION:handouts~~~

****

The Foreman Plugin Expire Hosts allows to add an expiration date on hosts and to
configure notifications for owners and admins in advance, automatically shutdown
when the hosts is expired and delete it also automatically afterwards. This is
quite useful on virtual machines used for development and testing, for hardware
shutdown and deletion can not be automated but it will at least notify.

More details on: https://github.com/theforeman/foreman_expire_hosts

~~~ENDSECTION~~~


!SLIDE smbullets small
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Expire Hosts

* Objective:
 * Set a host to expire
* Steps:
 * Install the Foreman Plugin Expire Hosts
 * Configure notifications
 * Set a host to expire

~~~SECTION:notes~~~

Settings tabs is not shown: https://github.com/theforeman/foreman_expire_hosts/issues/27

~~~ENDSECTION~~~


!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Expire Hosts

## Objective:

****

* Set a host to expire

## Steps:

****

* Install the Foreman Plugin Expire Hosts using the Foreman Installer
* Configure notifications in the settings menu
* Set a host to expire on its "Additional Information" tab

#### Expected result:

Host would be expired on the date set


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Expire Hosts

****

## Set a host to expire

****

### Install the Foreman Plugin Expire Hosts using the Foreman Installer

     # foreman-installer --enable-foreman-plugin-expire-hosts

### Configure notifications in the settings menu

Navigate to "Administer > Settings" and on the "ExpireHosts" tab set the "Expiry e-mail recipients" to
admin@localdomain.

### Set a host to expire on its "Additional Information" tab

Navigate to a host detail view and set an expiration date on its "Additional Information" tab.
