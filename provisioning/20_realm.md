!SLIDE smbullets small
# FreeIPA Integration

* Setup
 * Supported by script `foreman-prepare-realm`
 * Registers Foreman to FreeIPA
 * Generates keytab on Foreman
 * Configures permissions in FreeIPA
* Provisioning
 * Foreman creates One-Time-Password
 * One-Time-Password provided in Provisioning template
 * Registration of Host is done during provisioning
* Management
 * DNS management removes need for Smart Proxy feature
 * Hostgroup membership in FreeIPA based on Foreman

~~~SECTION:handouts~~~

FreeIPA integration is easy to set up and use with Foreman. For the setup a script `foreman-prepare-realm` is provided which registers Foreman to FreeIPA, generates the required keytab on Foreman and permissions in FreeIPA for the provisioning workflow.

During provisioning Foreman creates a one-time-password for the Host which is then provided in the Provisioning template via the snippet `freeipa_register`. This one is then used to register the host during provisioning. If needed, the process can be fine-tuned by some additional parameters.

If FreeIPA is managing DNS, there is no need for a Smart Proxy with DNS feature. There are also different options to simplify the management in FreeIPA like automatic membership in groups based on the hostgroups in Foreman.

~~~PAGEBREAK~~~

More details can be found at https://docs.theforeman.org/3.18/Installing_Server/index-katello.html#configuring-project-to-manage-the-lifecycle-of-a-host-registered-to-a-freeipa-realm_foreman

~~~ENDSECTION~~~
