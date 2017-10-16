!SLIDE smbullets small
# Permissions

* Fine granular permission system
* Abstracted to roles
* Complemented by filters
* Plugins can add items to the permission system


!SLIDE smbullets small
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Add unprivileged users

* Objective:
 * Grant access and privileges for some unprivileged users
* Steps:
 * Assign the role "Viewer" to the user "viewer"
 * Create a role "Selfservice" to allow creation of new hosts and management of own hosts
 * Assign the new role "Selfservice" to the user "selfservice"


!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Add unprivileged users

## Objective:

****

* Grant access and privileges for some unprivileged users

## Steps:

****

* Assign the role "Viewer" to the user "viewer"
* Create a role "Selfservice" to allow creation of new hosts and management of own hosts
* Assign the new role "Selfservice" to the user "selfservice"

#### Expected result:

* Login with the account "viewer" and password "netways" grants read-only privileges
* Login with the account "selfservice" and password "netways" allows to created new hosts


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Add unprivileged users

****

## Grant access and privileges for some unprivileged users

****

### Assign the role "Viewer" to the user "viewer"

Login with the account "viewer" and password "netways" and you will have no privileges assigned to you.
This will create the account and you can assign the role "Viewer" to it in "Administer > Users" view.

### Create a role "Selfservice" to allow creation of new hosts and management of own hosts

Navigate to "Administer > Roles" and press "Create role", name it "Selfservice" and save it by clicking "Submit".
Afterwards you can add filters to the role.

Resource         | Permissions                                                       | Unlimited | Search
-----------------|-------------------------------------------------------------------|-----------|----------------------
Host             | build_hosts, create_hosts                                         |     X     | none
Host             | edit_hosts, power_hosts, console_hosts, view_hosts, destroy_hosts |           | owner = current_user
Compute Resource | view_compute_resources, create_compute_resources_vms              |     X     | none
Architecture     | view_architectures                                                |     X     | none
Operatingsystem  | view_operatingsystems                                             |     X     | none
Ptable           | view_ptables                                                      |     X     | none
Medium           | view_media                                                        |     X     | none
Subnet           | view_subnets                                                      |     X     | none
Domain           | view_domains                                                      |     X     | none

The additional permissions for Compute Resource allow to create also a virtual machine on it. 
Subnet permissions are at least required for getting a IP address suggestion.

### Assign the new role "Selfservice" to the user "selfservice"

Login with the account "selfservice" and password "netways" and you will have no privileges assigned to you.
This will create the account and you can assign the role "Selfservice" to it in "Administer > Users" view.
