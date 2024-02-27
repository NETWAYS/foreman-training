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
* Client provided in a separate Client repository
 * Installation via Puppet, Ansible or manual

* _Use case:_ Collect security compliance reports in the WebGUI

~~~SECTION:handouts~~~

****

~~~PAGEBREAK~~~

OpenSCAP is the Open Source implementation of Security Content Automation Protocol which combines
different pre-existing security standards like CVE, CCE, CPE, CVSS, XCCDF, OVAL, OCIL, AI, ARF, CCSS
and TMSAD.  All these informations are combined in datastream files which can contain different profiles
a system can be validated against. To get a compliant system a guide can be created or a compliance report
including some remediation scripts. The required files can be created by hand but are in XML so best practice is to use
a tool like the Workbench to tailor the existing files like of the one provided by the OpenSCAP project or
the "National Institute of Standards and Technology" (NIST).

Not used by Foreman for now is the Anaconda Plugin OpenSCAP which can also add security compliance
as part of the installation process. Also the remediation scripts in bash and/or Ansible are not used
for now.

To customize the policy the Plugin was enhanced to support tailoring files.

The Client is provided by the Foreman Project in a separate Client repository and for installation and configuration
a Puppet module exists in the puppet Forge, an Ansible role in th Ansible galaxy, and instructions for manually doing
it is provided by the Foreman Webinterface.

~~~PAGEBREAK~~~

More details on: https://docs.theforeman.org/3.9/Administering_Project/index-katello.html#Managing_Security_Compliance_admin

~~~ENDSECTION~~~

!SLIDE smbullets small
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: OpenSCAP - Serverside Preparation

* Objective:
 * Prepare the server to inspect the Security compliance of your system
* Steps:
 * Install the Foreman and Smart Proxy Plugin OpenSCAP
 * Make the Puppet Module "foreman_scap_client" or the Ansible Role "theforeman.foreman_scap_client" available
 * Parameterize the Puppet Module / Ansible Role
 * Create a Hostgroup
 * Create a Policy for CentOS and assign it to a Hostgroup
 * Assign the Hostgroup to the host
 * Create an Activation key

~~~SECTION:handouts~~~

****

~~~PAGEBREAK~~~

The lastest version of the Puppet module is currently not on the forge, so get it from https://github.com/theforeman/puppet-foreman_scap_client

Examples for SCAP policy files provided by the ComplianceAsCode project can be found in the release zip archives at https://github.com/ComplianceAsCode/content/releases

~~~ENDSECTION~~~

!SLIDE smbullets small
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: OpenSCAP - Clientside Preparation

* Objective:
 * Prepare the client to inspect the Security compliance of your system
* Steps:
 * Register the Host to get client certificates
 * Make the Foreman client repository available to one host
 * Initiate a Puppet agent run or play the Ansible roles on the host
 * Create a report on the host
* Optional:
 * Customize the Policy with a tailor file

!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: OpenSCAP - Serverside Preparation

## Objective:

****

* Prepare the server to inspect the Security compliance of your system

## Steps:

****

* Install the Foreman and Smart Proxy Plugin OpenSCAP
* Make the Puppet Module "foreman_scap_client" or the Ansible Role "theforeman.foreman_scap_client" available
* Parameterize the Puppet Module / Ansible Role
* Create a Hostgroup
* Create a Policy for CentOS and assign it to a Hostgroup
* Assign the Hostgroup to the host
* Create an Activation key

!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: OpenSCAP - Clientside Preparation

## Objective:

****

* Prepare the client to inspect the Security compliance of your system

## Steps:

****

* Register the Host to get client certificates
* Make the Foreman client repository available to one host
* Initiate a Puppet agent run or play the Ansible roles on the host
* Create a report on the host

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

### Make the Puppet Module "foreman_scap_client" or the Ansible Role "theforeman.foreman_scap_client" available

For Puppet support install the module on the Puppet master.

    # puppet module install theforeman-foreman_scap_client

Or to get the latest version from git, download ans extract the tarball.

    # cd /etc/puppetlabs/code/environments/production/modules/
    # wget -O foreman_scap_client-master.tar.gz https://github.com/theforeman/puppet-foreman_scap_client/archive/master.tar.gz
    # tar xvzf foreman_scap_client-master.tar.gz
    # mv puppet-foreman_scap_client-master/ foreman_scap_client

Import the Puppet Class from the WebGUI ("Configure > Puppet ENC > Environments" or "Configure > Puppet ENC > Classes").

For Ansible support install the role on the Ansible control machine.

    # ansible-galaxy install --roles-path /etc/ansible/roles/ theforeman.foreman_scap_client

Import the Ansible Rolle from the WebGUI ("Configure > Ansible > Roles").

### Parameterize the Puppet Module / Ansible Role

Depending on the Policy file used some parameters need to be changed, in our case we need to fetch remote resources.

For Puppet navigate to "Configure > Puppet ENC > Smart Class Parameters" and select "fetch_remote_resources" from the list.
In the form select Override and set the Default Value to "true", then press "Submit".

For Ansible navigate to "Configure > Ansible > Variables" and select "foreman_scap_client_fetch_remote_resources" from the list.
In the form select Override and set the Default Value to "true", then press "Submit".

### Create a Hostgroup

A Hostgroup is required to assign the Policy, so navigate to "Configure > Host Groups" and click on "Create Host Group".
Simply name the Hostgroup "CentOS" with only the "Name" and the "Openscap Proxy" set.

~~~PAGEBREAK~~~

### Create a Policy for CentOS and assign it to a host

Get the zip archive from https://github.com/ComplianceAsCode/content/releases which includes the Policy files.
The Foreman plugin requires the datastream files which have "ds" in their name. You can upload them via
"Hosts > Compliance > SCAP content" and name it matching your operatingsystem. We are choosing CentOS 8 which is an automatically
adjusted file based on the one for RHEL 8. 
Currently the URL of the OVAL files has to be adjusted to https://access.redhat.com/security/data/oval/v2/RHEL8/rhel-8.oval.xml.bz2 or better to https://security.almalinux.org/oval/org.almalinux.alsa-8.xml.bz2.

Content files are avaiable now so navigate to "Hosts > Compliance > Policies" to create a "New Policy".
Choose "Puppet" or "Ansible" as Deployment Option, name it, choose SCAP Content provided and XCCDF Profile you prefer,
schedule it "Weekly" on "Sunday" and assign it to Hostgroup "CentOS". If you have no preference, the "Standard System Security Profile"
is a good one to start.

To view the guide click on the "Show Guide" action from the drop down button next to the policy.

### Assign the Hostgroup to the host

Assign this Hostgroup to one off your matching systems.

### Create an Activation key

Navigate to "Content > Lifecycle > Activation Keys" and click on "Create Activation Key".
In the form name it "CentOS" and simply select the Environment "Library" and the Content View "Default Organisation View" representing upstream.

!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: OpenSCAP

****

## Inspect the Security compliance of your system

****

### Register the Host to get client certificates

To generate client certificates navigate to "Hosts > Register Host". Select your Host group, Operating system, and Activation key.
Also check insecure as we have not established trust to the Katello certificate. Clicking "Generate" will give you a command to
execute on the Host.

Alternatively it could use Puppet certificates so feel free to skip this step if using Puppet and having the agent configured.

###  Make the Foreman client repository available to one host

Login to the host you assigned the Hostgroup with the Policy and execute

   # yum install -y http://yum.theforeman.org/client/3.9/el8/x86_64/foreman-client-release.rpm

Depending on the Puppet Module or Ansible Role version this could also be done by setting one of its parameters.

### Initiate a Puppet agent run or play the Ansible roles on the host

Use Remote execution to "Run Puppet Once" or "Run Ansible roles" which will deploy the client components (can be found in the Host detail view).

As an alternative login to the host you assigned the Hostgroup with the Policy and execute

    # puppet agent -t

### Create a report on the host

If using Ansible you can create a report using remote execution job "Run OpenSCAP scan" (can be found in the Host detail view).

The Puppet agent prepared a cronjob on your system, get it and execute its content. Depending on the number of rules it may take a while.

    # cat /etc/cron.d/foreman_scap_client_cron
    # /usr/bin/foreman_scap_client ds 1

The upload to Foreman will happen automatically, currently there is no card for OpenSCAP on the host detail page, so you can access the report
via the status by clicking on "Manage all statuses" and then "Compliance". Otherwise "Host > Compliance > Reports" will give you a list of all reports.
Click on the column "Reported At" to get a simplified overview. Choose the action "Full Report" to get the html view generated by OpenSCAP which can be quite slow.

### Customize the Policy with a tailor file created with SCAP workbench

Open SCAP workbench on your laptop, choose the content matching your operatingsystem release and select the choosen profile. Press Customize and name
the Profile. In the new dialog select or unselect checks and click OK. Afterwards save the tailor file via "File > Save Customization Only".
Upload this file to Foreman in the "Hosts > Compliance > Tailoring Files" dialog and then edit the policy and rerun the Puppet agent or Ansible and
Upload of the report.

