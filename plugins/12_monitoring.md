!SLIDE smbullets small
# Monitoring

* Integrates a monitoring solution
 * Shows monitoring status in Foreman
 * Manages monitoring objects during provisioning

* Supported monitoring solutions
 * Icinga 2
 * Icinga 2 and Icinga Web 2 Director

* _Use case:_
 * Integrate monitoring into provisioning
 * Get state for running systems from Foreman

~~~SECTION:handouts~~~

****

The Monitoring integration is done via a Foreman plugin for the graphical part and a
Smart proxy plugin for the communication. So it shows a global and detailed monitoring
status for hosts, manages monitoring objects during provisioning and deprovisioning and
allows to set downtimes.

~~~PAGEBREAK~~~

For now it only supports Icinga 2 as monitoring solution and if requiring a more comfortable
administration Icinga 2 and in addition its graphical frontend Icinga Web 2 Director.

More details on: <br/>
 https://github.com/theforeman/foreman_monitoring <br/>
 https://github.com/theforeman/smart_proxy_monitoring <br/>

~~~ENDSECTION~~~

!SLIDE smbullets small
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Monitoring Integration

* Objective:
 * Integrate Monitoring into Foreman
* Steps:
 * Install Foreman plugin and Smart proxy plugin
 * Configure Smart proxy to communicate with Icinga 2 and Icinga Web 2 Director
 * Configure Foreman default actions for monitoring
 * Active integration for one host
 * Verify monitoring integration

!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Monitoring Integration

## Objective:

****

* Integrate Monitoring into Foreman

## Steps:

****

* Install Foreman plugin and Smart proxy plugin using foreman-installer

Active Icinga 2 and Icinga Web 2 Director provider.

* Configure Smart proxy to communicate with Icinga 2 and Icinga Web 2 Director
* Configure Foreman default actions for monitoring
* Active integration for one host
* Verify monitoring integration at http://monitoring.localdomain/icingaweb2

Credentials are icinga:icinga.

!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Monitoring Integration

****

## Integrate Monitoring into Foreman

****

### Install Foreman plugin and Smart proxy plugin

    # foreman-installer --enable-foreman-plugin-monitoring \
    --enable-foreman-proxy-plugin-monitoring \
    --foreman-proxy-plugin-monitoring-providers icinga2 \
    --foreman-proxy-plugin-monitoring-providers icingadirector

### Configure Smart proxy to communicate with Icinga 2 and Icinga Web 2 Director

    # scp monitoring.localdomain:/etc/icinga2/pki/ca.crt /etc/foreman-proxy/monitoring/ca.crt
    # vi /etc/foreman-proxy/settings.d/monitoring_icinga2.yml
    :enabled: true
    :server: monitoring.localdomain
    :api_cacert: /etc/foreman-proxy/monitoring/ca.crt
    :api_user: foreman
    :api_password: foreman
    :verify_ssl: false
    # vi /etc/foreman-proxy/settings.d/monitoring_icingadirector.yml
    :enabled: true
    :director_url: http://monitoring.localdomain/icingaweb2/director
    :director_cacert: /etc/foreman-proxy/monitoring/ca.crt
    :director_user: foreman
    :director_password: foreman
    :verify_ssl: false
    # systemctl restart foreman-proxy.service

### Configure Foreman default actions for monitoring

Navigate to "Administer > Settings" and on the Monitoring tab you can choose your default actions.

### Active integration for one host

Navigate to a host and edit it to include a "Monitoring Proxy".

### Verify monitoring integration at http://monitoring.localdomain/icingaweb2

Open the Icinga Web 2 interface with your browser http://monitoring.localdomain/icingaweb2 and login with icinga:icinga.
In the "Icinga Director" module you should see the host created and a service assigned to it. Start a deployment and you
will get a monitoring status in Foreman after checks are executed.
