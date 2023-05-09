!SLIDE subsectionnonum
# Monitoring

!SLIDE smbullets small
# Foreman & Smart Proxy

* Foreman
 * Webinterface should be available using HTTPs include "LoginPage"
 * Provisioning requires also HTTP requests being answered
 * Foreman log should not have entries "500 Internal Server Error"

* Smart proxy
 * Query the feature list for expected features
 * Smart proxies log should not have entries "ERROR"

~~~SECTION:handouts~~~

****

For monitoring Foreman you should include a check to verify if the Webinterface is available using HTTPs and
if it includes the string "Welcome to foreman" as it is possible that it shows a stracktrace if something is
goes wrong. If using monitoring plugins with Icinga or something similar you could use check_http.

~~~PAGEBREAK~~~

    check_http -H foreman.localdomain -p 443 -S -f follow -s 'LoginPage'


During provisioning also plain HTTP requests will be required, but you can not simulate exactly this request
because of redirect rules directing the request to HTTPs.

    check_http -H foreman.localdomain -e 301

Log entries containing "500 Internal Server Error" will typically indicate a software failure caused by
something not running properly or a bug. Check_logfiles provided at http://labs.consol.de could be used
to monitor.

    check_logfiles --logfile /var/log/foreman/production.log --rotation loglogdate8logdate8gz \
    --criticalpattern '500 Internal Server Error' --tag foreman

To monitor the Smart proxy query the feature list for expected features as a feature will be deactivated if
an error during startup occures. Remember the default port 8443 is changed to 9090 when using Katello because of Candlepin.

    check_http -H foreman.localdomain -S -p 8443 -u /features -s '["dhcp","dns","logs","puppet","puppetca","tftp"]'

In the log monitor for entries marked as "ERROR".

    check_logfiles --logfile /var/log/foreman-proxy/proxy.log --rotation loglogdate8gz \
    --criticalpattern 'ERROR' --tag foreman-proxy

~~~ENDSECTION~~~

!SLIDE smbullets small
# Managed Services

* Puppet: Query for a catalog
* TFTP: Try to get a small file like pxelinux.cfg/default
* DNS: Query DNS for a specific combination of name and address
* DHCP: Try to get a DHCPOFFER from a system not being the DHCP server

~~~SECTION:handouts~~~

****

Best way to verify that Puppet is available is trying to get a catalog and check it for some
content like the name. It will require to use the client certificate of the host for authentication.
Which are not accessable by an unprivileged user by default.

For Puppet 7 this could look like this.

    check_http -H foreman.localdomain -S -p 8140 \ 
    -J /etc/puppetlabs/puppet/ssl/certs/foreman.localdomain.pem \
    -K /etc/puppetlabs/puppet/ssl/private_keys/foreman.localdomain.pem \
    -u '/puppet/v3/catalog/foreman.localdomain?environment=production' \
    -s '"name":"foreman.localdomain"'

<br/>

To verify TFTP working fine try to get a small file like pxelinux.cfg/default (which you need to create).
There are several plugins available like the one provided at http://william.leibzon.org/nagios/

    check_tftp foreman.localdomain pxelinux.cfg/default

DNS functionality is best checked by a specific combination of name and address and could be simply included
for every host.

    check_dns -s foreman.localdomain -H foreman.localdomain -a 10.0.0.2

DHCP providing DHCPOFFERS can only be verifed from systems not being the DHCP server and should ask a specific
DHCP server to ensure answers are not provided from another system.

    check_dhcp -s 10.0.0.2 -r 10.0.0.102 -u

~~~ENDSECTION~~~

!SLIDE smbullets small
# Katello

* Service status via Systemd and Journal
* Functionality:
 * Synchronization of the Products
 * Patch level of Hosts

~~~SECTION:handouts~~~

****

In most cases it should be enough to verify the services are running and watch for errors in the journal to verify
Candlepin and Pulp are working. Candlepin is a Java application running on Tomcat and Pulp requires a bunch of services
starting with pulp, pulpworker being instanciated multiple times with the exact number depending on your tuning.
Best check known is check_systemd_service which only verifies the service being active. To query the journal another check is
needed but there is none to recommend.

~~~PAGEBREAK~~~

Checking the functionality is another way to monitor Katello. The two checks check_katello_sync for the synchronization of the Products and
check_katello_currency for the patch level of Hosts from Christian Stankowic are good ones to start with as the verify the most important
functionalities. https://github.com/stdevel?tab=repositories&q=katello

~~~ENDSECTION~~~
