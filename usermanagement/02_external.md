!SLIDE smbullets small
# External Authentication

* External authentication utilizing the webserver
* Kerberos
 * Foreman Installer can handle FreeIPA automatically
 * Manual configuration and tell Foreman to trust
* PAM
 * Apache module to validate login form input against PAM
* Autocreation of user possible
* Differentiates between WebGUI and API

~~~SECTION:handouts~~~

****

Foreman can also be configure to use an external authentication provided by the webserver.

In most cases this will be Kerberos to achieve a true Single Sign-On. If you use FreeIPA as your
authentication provider the Foreman Installer can create the required configuration by passing the
corresponding parameters to it.

~~~PAGEBREAK~~~

If you use another provider like Active Directory or a manually managed Kerberos it is possible to
create the required Kerberos and PAM authentication on your own and tell Foreman to accept external
users.

Another way to configure Foreman to use external authentication providers is by using the Apache
module "intercept_form_submit" to pass the login form input to PAM for validation.

It is also possible to enable autocreation of users in Foreman for external authentication.

Also note that Foreman differentiates between WebGUI and API login for external authentication
so it is possible to allow external users to only connect to one or both.

~~~ENDSECTION~~~
