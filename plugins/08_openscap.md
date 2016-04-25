!SLIDE smbullets small
# OpenSCAP

* Open Source implementation of Security Content Automation Protocol
* Combines different security standards
* Validate systems for security compliance
 * Provides guides
 * Provides reports and remediation
* Profiles provided by different resources
 * Files to start with included
 * Other resources like the "National Institute of Standards and Technology"

* _Use case:_ Collect security compliance reports in the WebGUI

~~~SECTION:handouts~~~

****

~~~PAGEBREAK~~~

OpenSCAP is the Open Source implementation of Security Content Automation Protocol which combines
different pre-existing security standards like CVE, CCE, CPE, CVSS, XCCDF, OVAL, OCIL, AI, ARF, CCSS
and TMSAD.  All these informations are combined in datastream files which can contain different profiles
a system can be validated against. To get a compliant system a guide can be created or a compliance report
including some remediation scripts. The required files can be created by hand but are in XML so best practice is to use
a tool like the Workbench to tailor the existing files to the like of the one provided by the OpenSCAP project or
the "National Institute of Standards and Technology" (NIST).

Not used by Foreman for now is the Anaconda Plugin OpenSCAP which can also add security compliance
as part of the installation process.

With Foreman 1.11 the Plugin will get a rewrite to remove the dependency on "scaptimony"!

More details on: https://github.com/theforeman/foreman_openscap

~~~ENDSECTION~~~

!SLIDE smbullets small
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: OpenSCAP

* Objective:
 * Inspect the Security compliance of your system
* Steps:
 * Install the Foreman Plugin OpenSCAP
 * Install the Smart Proxy Plugin OpenSCAP
 * Make the Puppet Module "foreman_scap_client" available
 * Create a Policy for CentOS 7 and assign it to a host
 * Initiate a Puppet agent run on the host
 * Create a report on the host and upload it to the Smart proxy
 * Upload the report from the Smart proxy to the Foreman

!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: OpenSCAP

## Objective:

****

* Inspect the Security compliance of your system

## Steps:

****

* Install the Foreman Plugin OpenSCAP using the package "tfm-rubygem-foreman_openscap"
* Install the Smart Proxy Plugin OpenSCAP using the package "rubygem-smart_proxy_openscap"
* Make the Puppet Module "foreman_scap_client" available
* Create a Policy for CentOS 7 and assign it to a host
* Initiate a Puppet agent run on the host
* Create a report on the host and upload it to the Smart proxy
* Upload the report from the Smart proxy to the Foreman

#### Expected result:

Compliance Report is available in the Foreman WebGUI.


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: OpenSCAP

****

## Inspect the Security compliance of your system

****

### Install the Foreman Plugin OpenSCAP using the package "tfm-rubygem-foreman_openscap"

    # yum install tfm-rubygem-foreman_openscap -y
    # service httpd restart

### Install the Smart Proxy Plugin OpenSCAP using the package "rubygem-smart_proxy_openscap"

Make the plugin available to the Smart proxy.

    # yum install rubygem-smart_proxy_openscap -y
    
Uncomment the following lines in "/etc/foreman-proxy/settings.d/openscap.yml".

    :openscap_send_log_file: /var/log/foreman-proxy/openscap-send.log
    :contentdir: /var/lib/openscap/content

Allow the access to the content directory and restart the Service

    # chown foreman-proxy.foreman-proxy /var/lib/openscap/content
    # service foreman-proxy restart

Let the Foreman know about the new feature so it accepts reports by executing the action "Refresh features"
next to the Smart proxy in "Infrastructure > Smart Proxies".

### Make the Puppet Module "foreman_scap_client" available

Install the module on the Puppet master.

    # puppet module install isimluk-foreman_scap_client

Import the Puppet Class from the WebGUI ("Configure > Puppet Environments" or "Configure > Puppet Classes").

### Create a Policy for CentOS 7 and assign it to a host

Create a Hostgroup "Scap" via "Configure > Host groups" with only the name set.

Content files are avaiable per default so navigate to "Hosts > Policies" to create a "New Compliance Policy".
Name it "Centos-7-Common", choose SCAP Content "Red Hat centos7 default content" and XCCDF Profile 
"Common Profile for General-Purpose System", schedule it "Weekly" on "Sunday" and assign it to Hostgroup
"SCAP".

To view the guide click on the "Show Guide" button next to the policy.

Assign this Hostgroup to one off your CentOs 7 systems.

### Execute a Puppet agent run on the host

Login to the host you assigned the Hostgroup with the Policy and execute

    # puppet agent -t

~~~PAGEBREAK~~~

### Create a report on the host and upload to Smart proxy

The Puppet agent prepared a cronjob on your system, get it and execute its content.

    # crontab -l
    # /usr/bin/foreman_scap_client 1

### Upload the report from the Smart proxy to Foreman

On the Smart proxy is also a cronjob available which is scheduled every half hour to execute it get the report uploaded
immediately.

    # sudo -u foreman-proxy smart-proxy-openscap-send

Now you should find a report in the WebGUI next to the Host in the "All Hosts" view, in the Host details and "Hosts > Reports".
Navigate to that report and then press the "View Report" button to inspect it.
