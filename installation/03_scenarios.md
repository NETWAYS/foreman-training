!SLIDE smbullets small
# Scenarios

* Foreman
 * All-in-one
 * All-in-one with additional Puppet servers
 * Separate Puppet servers
 * Smart proxies
 * Integration of PuppetDB
 * For Ansible without Puppet
* Katello

~~~SECTION:handouts~~~

****

The Foreman installer allows to setup different scenarios depending on its parameters or answers in interactive mode.
All the scenarios above are explained in the course material, commands required can be found in the Foreman manual on
the project homepage. For the training we will the Katello scenario and add additional Smart proxies for Provisioning.

~~~ENDSECTION~~~

!SLIDE smbullets small noprint
# Foreman: All-in-one

* Default setup on unparameterized run only for Configuration Management
* Add at least Smart Proxy TFTP for Provisioning

<div style="text-align:center"><img src="./_images/installation_all-in-one.png" style="float: center; margin-left: 50px; height: 377px;" alt="Installation All-in-one"></div>

* Expandable with additional plugins and Smart proxies

~~~SECTION:notes~~~

* Plugins can be added simply as parameter during installation or later on
* Smart proxies are covered later because it is the same procedure for installation on Foreman host or others

~~~ENDSECTION~~~


!SLIDE smbullets small printonly
# Foreman: All-in-one

* Default setup on unparameterized run only for Configuration Management
* Add at least Smart Proxy TFTP for Provisioning

<img src="./_images/installation_all-in-one.png" style="width: 95%;" alt="Installation All-in-one">

* Expandable with additional plugins and Smart proxies

~~~SECTION:handouts~~~

****

~~~PAGEBREAK~~~

The Foreman installer by default installs an all-in-one scenario with Apache httpd and Puma
serving the Foreman Web GUI and API and the Puppet server including the certificate authority.
In addition it installs and configures the Smart Proxy covering the installed components
Puppet and  Puppet CA so it can work as UI for Puppet. 

In addition it makes to prepare TFTP or another way of Provisioning.

Additional plugins including Compute Resources could be enabled setting the corresponding parameter
to true. Smart Proxies can also be added to the system hosting Foreman or on different machines which
will be covered later.

~~~ENDSECTION~~~

!SLIDE smbullets small noprint
# Foreman: All-in-one with additional Puppet servers

* Default setup on Foreman host
* Precreate certificates on Puppet CA
* Run installer with parameters to disable Foreman on additional Puppet servers

<div style="text-align:center"><img src="./_images/installation_additional-servers.png" style="float: center; margin-left: 50px; height: 395px;" alt="Installation Additional Puppet servers"></div>

~~~SECTION:notes~~~

* Preferred scenario for growing the Infrastructure and making Puppet server high available.
* But all Puppet server depend on Foreman so place it on a high available machine.

~~~ENDSECTION~~~


!SLIDE smbullets small printonly
# Foreman: All-in-one with additional Puppet servers

* Default setup on Foreman host
* Precreate certificates on Puppet CA
* Run installer with parameters to disable Foreman on additional Puppet servers

<img src="./_images/installation_additional-servers.png" style="width: 95%;" alt="Installation Additional Puppet servers">

~~~SECTION:handouts~~~

****

~~~PAGEBREAK~~~

For the Foreman host run the same setup like before afterwards create certificates for the
Puppet servers to be added. If you do not do so, it will create an additional CA on this
systems. Last run the Foreman installer on the systems with parameters to disable Foreman
and the Puppet CA.
Depending on your infrastructure there are different ways to balance the load on the Puppet
servers:

* Manual point servers to a Puppet server
* Use Round-robin DNS which requires your Puppet server certificates to be created with an 
DNS alias
* Use a Loadbalancer solution which depending on SSL handling also requires DNS aliases
* Utilize DNS SRV records which requires Puppet 3 or higher and appropriate agent configuration

~~~ENDSECTION~~~

!SLIDE smbullets small noprint
# Foreman: Separate Puppet servers

* Setup on Foreman host with Puppet server and Smart Proxies disabled
* Run installer with parameters to disable Foreman on separate Puppet servers

<div style="text-align:center"><img src="./_images/installation_separate-servers.png" style="float: center; margin-left: 50px; height: 446px;" alt="Installation Separate Puppet servers"></div>

~~~SECTION:notes~~~

* Same as the scenario before but removes load created by Puppet server from the Foreman server

~~~ENDSECTION~~~


!SLIDE smbullets small printonly
# Foreman: Separate Puppet servers

* Setup on Foreman host with Puppet server and Smart Proxies disabled
* Run installer with parameters to disable Foreman on separate Puppet servers

<img src="./_images/installation_separate-servers.png" style="width: 95%;" alt="Installation Separate Puppet servers">

~~~SECTION:handouts~~~

****

~~~PAGEBREAK~~~

This is nearly the same setup as before but removes the load created by being a Puppet server
from the Foreman server. You still have to remember to create only the first Puppet server as a
certificate authority and setup a solution to load balance the agents.

~~~ENDSECTION~~~

!SLIDE smbullets small noprint
# Foreman: Smart Proxies

* Foreman installer helps to setup Smart Proxies

<div style="text-align:center"><img src="./_images/installation_smart-proxies.png" style="float: center; margin-left: 50px; height: 301px;" alt="Installation Smart proxies"></div>

~~~SECTION:notes~~~

* Smart Proxies can also be added to the All-in-one Foreman host - we will do so in the Training
* Requires certificate for communication and OAuth provided in the settings of Foreman.

~~~ENDSECTION~~~


!SLIDE smbullets small printonly
# Foreman: Smart Proxies

* Foreman installer helps to setup Smart Proxies

<img src="./_images/installation_smart-proxies.png" style="width: 95%;" alt="Installation Smart Proxies">

~~~SECTION:handouts~~~

****

The Foreman installer can install a Smart Proxy and register it automatically to the Foreman instance.
This could be done on the Foreman host itself or any other host communication is possible.
This will require the certificate to be created in advance to allow the communication. For authentication
it uses OAuth provided by Foreman available to the administrators.

~~~PAGEBREAK~~~

It also can install and configure the corresponding service like Bind for DNS, ISC DHCP or TFTP but this
is a very basic setup and will typically require some additional configuration.

After the Smart proxy is registered to Foreman import of configured data like subnets or manual configuration
is required.

~~~ENDSECTION~~~

!SLIDE smbullets small noprint
# Foreman: Integration of PuppetDB

* Foreman installer helps to integrate PuppetDB

<div style="text-align:center"><img src="./_images/installation_puppetdb.png" style="float: center; margin-left: 50px; height: 302px;" alt="Installation PuppetDB"></div>

~~~SECTION:notes~~~

* Integration of existing PuppetDB, no installation!

~~~ENDSECTION~~~


!SLIDE smbullets small printonly
# Foreman: Integration of PuppetDB

* Foreman installer helps to integrate PuppetDB

<img src="./_images/installation_puppetdb.png" style="width: 95%;" alt="Installation PuppetDB">

~~~SECTION:handouts~~~
****
The Foreman installer allows to add PuppetDB as reporting target and storeconfigs backend
to the Puppet servers. It does not setup PuppetDB server!<br/>
PuppetDB is not required in a typical setup with Foreman. Instead of using storeconfigs
or PuppetDB queries Foreman's own database could also be used for queries. The required
function is part of the Puppet module "foreman" provided by the Foreman Project.

Installation of PuppetDB if required for your setup could easily be done with the Puppet
module "puppetdb" provided by Puppetlabs.

~~~ENDSECTION~~~

!SLIDE smbullets small noprint
# Foreman: For Ansible without Puppet

* Installing without Puppet is possible, but requires your own certificates
* Ansible uses Remote Execution stack

<div style="text-align:center"><img src="./_images/installation_ansible.png" style="float: center; margin-left: 50px; height: 340px;" alt="Installation Ansible"></div>

~~~SECTION:notes~~~

* Certificates can be self-signed
* The Smart-Proxy can be part of the Foreman server
* We talk later about Remote Execution in more detail

~~~ENDSECTION~~~

!SLIDE smbullets small printonly
# Foreman: For Ansible without Puppet

* Installing without Puppet is possible, but requires your own certificates
* Ansible uses Remote Execution stack

<img src="./_images/installation_ansible.png" style="width: 95%;" alt="Installation Ansible">

~~~SECTION:handouts~~~
****

It is also possible to install Foreman without Puppet. (It will still need Puppet for the installer,
but only the agent) But as Foreman is using the Puppet CA by default for certificate generation,
you will need to provide your own certificates. The source can be every CA, even a self-signed one.

~~~PAGEBREAK~~~

As Ansible uses a push model instead of pull like Puppet, it uses the Remote Execution stack consisting
of the task engine Dynflow on the Foreman server and Smart-Proxy getting the jobs from there to run
Ansible. You can watch the job status, but it will also send reports back to Foreman.

~~~ENDSECTION~~~


!SLIDE smbullets small noprint
# Katello

* Katello adds additional complexity, so the amount of details are reduced to the main components
 * Pulp is integrated for Content Management
 * Candlepin is used for Subscription Management

<div style="text-align:center"><img src="./_images/installation_katello.png" style="float: center; margin-left: 50px; height: 340px;" alt="Installation Katello"></div>

* Requires a different scenario parameter for the installer!

~~~SECTION:notes~~~

* We will not add more details or scenarios, but if someone asks additional Smart-Proxies are possible including for Content distribution

~~~ENDSECTION~~~

!SLIDE smbullets small printonly
# Katello

* Katello adds additional complexity, so the amount of details are reduced to the main components
 * Pulp is integrated for Content Management, Candlepin for Subscription Management
 * Certificates are no longer from PuppetCA, instead its own CA is used

<img src="./_images/installation_katello.png" style="width: 95%;" alt="Installation Katello">

* Requires a different scenario parameter for the installer!

~~~SECTION:handouts~~~
****

~~~PAGEBREAK~~~

Katello adds complete new functionality to Foreman by integrating Pulp for Content Management and Candlepin for Subscription Management. This of course adds additional complexity to the setup.
To reduce this complexity support-wise it is only supported to directly install this setup by adding `--scenario katello` to the Installer and not to later add it as a plugin.
Packages for the installation are also limited to EL derivates, so support is limited to this platform.

It also changes the setup by no longer relying on Puppet for providing a CA. Instead it uses its own CA which will provide certificates used by Candlepin and Puppet as SubCAs.

~~~ENDSECTION~~~
