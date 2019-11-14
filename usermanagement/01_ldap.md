!SLIDE smbullets small
# LDAP

* Natively supported including webbased configuration
* Supports:
 * Protocol: LDAP, LDAPS, no StartTLS
 * Schema: POSIX, Active Directory, FreeIPA
* Allows multiple backends
* Autocreation of user possible
* Optional synchronisation of group membership
* Getting stored avatars

~~~SECTION:handouts~~~

****

Foreman supports LDAP authentication natively and provides a webbased configuration for it.

~~~PAGEBREAK~~~

Supported are LDAP and LDAPS as protocol, (at the moment) for now no StartTLS. If using certificate based encyrption
trust to the certificate is mandatory. It supports the POSIX, Active Directory and FreeIPA schema
for storing users and groups, but attribute mapping can be configured manually. For the autocreation
of users the attributes "Login Name", "First Name", "Surname" and "Email" are required, optionally a
avatar can be stored as base64 encoded string in a "Photo" attribute.

~~~ENDSECTION~~~

!SLIDE smbullets small
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: LDAP Authentication

* Objective:
 * Allow the administrative accounts from the LDAP to work as Foreman admins
* Steps:
 * Configure the LDAP authentication including group synchronisation
 * Add a administrative group to grant the administrative accounts from the LDAP privileges
* Optional:
 * Add a photo to the administrator account


!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: LDAP Authentication

## Objective:

****

* Allow the administrative accounts from the LDAP to work as Foreman admins

## Steps:

****

* Configure the LDAP authentication including group synchronisation
* Add a administrative group to grant the administrative accounts from the LDAP privileges
* Optional: Add a photo to the administrator account via ldapmodify

#### Expected result:

* Login with the account "administrator" of the group "admins" with password "netways" to grant administrative privileges

~~~SECTION:handouts~~~

****

Details on the LDAP server:

* Server: foreman.localdomain
* Protocol: LDAP (Port 389/tcp)
* Schema: POSIX
* Base DN: dc=localdomain
* User DN: ou=users,dc=localdomain
* Group DN: ou=groups,dc=localdomain

~~~ENDSECTION~~~


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: LDAP Authentication

****

## Allow the administrative accounts from the LDAP to work as Foreman admins

****

### Configure the LDAP authentication including group synchronisation

Navigate to "Administer > LDAP Authentication" and press the "Create Authentication Source" button. In the dialog add the following values:

* LDAP Server
 * Name: Foreman
 * Server: foreman.localdomain
 * LDAPS: *unchecked*
 * Port: 389
 * Server Type: POSIX
* Account
 * Account username: *keep empty*
 * Account password: *keep empty*
 * Base DN: dc=localdomain
 * Groups base DN: ou=groups,dc=localdomain
 * Use netgroups: *unchecked*
 * LDAP filter: *keep empty*
 * Onthefly register: *checked*
 * Usergroup sync: *checked*
* Attribute mappings
 * Login name attribute: uid
 * Firt name attribute: givenName
 * Surname attribute: sn
 * Email address attribute: mail
 * Photo attribute: jpegPhoto

Press "Submit" to store the configuration.

~~~PAGEBREAK~~~

### Add a administrative group to grant the administrative accounts from the LDAP privileges

Navigate to "Administer > User groups" and open the group dialog by pressing "Create User group" and insert the values.

* User Group
 * Name: admins
 * User Groups: *empty*
 * Users: *empty*
* Roles:
 * Admin: *checked*
 * Roles: *non selected*
* External groups:
 * Name: admins
 * Auth source: LDAP-Foreman

Create the group by clicking "Submit" and afterwards try to login with the credentials "administrator / netways".
Login should work, grant permissions and you should find the user in "Administer > Users". If login fails check the
"LDAP Authentication", if no permissions are granted check the "User group".

* Optional: Add a photo to the administrator account

If you want to test the avatar feature, download a photo and modify ldap to include it.

    # vi jpegPhoto.ldif
    dn: cn=administrator,ou=users,dc=localdomain
    changetype: modify
    add: jpegPhoto
    jpegPhoto:< file:///tmp/tux.png
    # ldapmodify -x -D "cn=admin,dc=localdomain" -w netways -f jpegPhoto.ldif
