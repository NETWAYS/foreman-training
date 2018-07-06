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

With Foreman 1.11 the Plugin got a rewrite to remove the dependency on "scaptimony"! With Foreman 1.15 the Plugin was
enhanced to support tailoring files.

More details on: https://theforeman.org/plugins/foreman_openscap/0.8/index.html

~~~ENDSECTION~~~

!SLIDE smbullets small
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: OpenSCAP

* Objective:
 * Inspect the Security compliance of your system
* Steps:
 * Install the Foreman and Smart Proxy Plugin OpenSCAP
 * Make the Puppet Module "foreman_scap_client" available
 * Create a Policy for CentOS 7 and assign it to a host
 * Initiate a Puppet agent run on the host
 * Create a report on the host and upload it to the Smart proxy
 * Upload the report from the Smart proxy to the Foreman
* Optional:
 * Customize the Policy with a tailor file

!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: OpenSCAP

## Objective:

****

* Inspect the Security compliance of your system

## Steps:

****

* Install the Foreman and Smart Proxy Plugin OpenSCAP using the foreman-installer
* Make the Puppet Module "foreman_scap_client" available
* Create a Policy for CentOS 7 and assign it to a host
* Initiate a Puppet agent run on the host
* Create a report on the host and upload it to the Smart proxy
* Upload the report from the Smart proxy to the Foreman

## Optional:

****

* Customize the Policy with a tailor file created with SCAP workbench

#### Expected result:

Compliance Report is available in the Foreman WebGUI.


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: OpenSCAP

****

## Inspect the Security compliance of your system

****

### Install the Foreman and Smart Proxy Plugin OpenSCAP using the foreman-installer

    # foreman-installer --enable-foreman-plugin-openscap --enable-foreman-proxy-plugin-openscap

### Make the Puppet Module "foreman_scap_client" available

Install the module on the Puppet master.

    # puppet module install theforeman-foreman_scap_client

Import the Puppet Class from the WebGUI ("Configure > Environments" or "Configure > Classes").

### Create a Policy for CentOS 7 and assign it to a host

Create a Hostgroup "Scap" via "Configure > Host groups" with only the "Name" and the "Openscap Proxy" set.

Content files are provided by the package "scap-security-guide" and located in "/usr/share/xml/scap/ssg/content".
The Foreman plugin requires the datastream files which have "ds" in their name. You can upload them via
"Hosts > SCAP content" and name it "Centos-7".

Content files are avaiable now so navigate to "Hosts > Policies" to create a "New Policy".
Name it "Centos-7-Common", choose SCAP Content "Centos-7" and XCCDF Profile "Common Profile for General-Purpose System",
schedule it "Weekly" on "Sunday" and assign it to Hostgroup "SCAP".

To view the guide click on the "Show Guide" button next to the policy.

Assign this Hostgroup to one off your CentOS 7 systems.

### Execute a Puppet agent run on the host

Login to the host you assigned the Hostgroup with the Policy and execute

    # puppet agent -t

~~~PAGEBREAK~~~

### Create a report on the host and upload to Smart proxy

The Puppet agent prepared a cronjob on your system, get it and execute its content.

    # cat /etc/cron.d/foreman_scap_client_cron
    # /usr/bin/foreman_scap_client 1

### Upload the report from the Smart proxy to Foreman

On the Smart proxy is also a cronjob available which is scheduled every half hour to execute it get the report uploaded
immediately.

    # sudo -u foreman-proxy smart-proxy-openscap-send

Now you should find a status in the WebGUI in the Host details and the report at "Hosts > Reports".
Navigate to that report and then press the "Report at" column to inspect it.

### Customize the Policy with a tailor file created with SCAP workbench

Open SCAP workbench on your laptop, choose the CentOS7 content and select the Common Profile. Press Customize and name
the Profile. In the new dialog select or unselect checks and click OK. Afterwards save the tailor file via "File > Save Customization Only".
Upload this file to Foreman in the "Hosts > Tailoring Files" dialog and then edit the policy and rerun the Puppet agent and
Upload of the report.

